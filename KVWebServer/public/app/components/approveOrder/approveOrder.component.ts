import {Component, ViewChild} from '@angular/core';
import {Subscription} from 'rxjs/Subscription';
import {FormBuilder, Validators, FormControl, FormGroup} from '@angular/forms';
import {AppService} from '../../services/app.service';
import {Util} from '../../services/util';
import {Router} from '@angular/router';
import {messages} from '../../config';
import {ModalModule, Modal} from "ng2-modal";
import {AlertModule} from 'ng2-bootstrap/components/alert';
import {PaymentMethodForm} from '../../components/paymentMethodForm/paymentMethodForm.component';
import {ShippingAddressForm} from '../../components/shippingAddressForm/shippingAddressForm.component';
import {uiText} from '../../config';

@Component({templateUrl: 'app/components/approveOrder/approveOrder.component.html'})
export class ApproveOrder {
    // justTest="ABCD";
    approveArtifactsSub : Subscription;
    postApproveSubscription : Subscription;
    getShippingSalesTaxPercSub : Subscription;
    allAddrSubscription : Subscription;
    allCardSubscription : Subscription;
    selectNewCardSub : Subscription;
    selectedAddress : any = {};
    selectedCard : any = {};
    defaultCard : any = {};
    growlMessages : any = [];
    allTotals : {} = {};
    isExistsAnyCard : boolean = false;
    footer : any = {
        wineTotals: {
            wine: 0.00,
            addl: 0.00
        },
        salesTaxPerc: 0.00,
        shippingCharges: 0.00,
        shippingTotals: {
            wine: 0.00 / 1,
            addl: 0.00 / 1
        },
        prevBalances: {
            wine: 0.00 / 1,
            addl: 0.00 / 1
        },
        grandTotals: {
            wine: 0.00 / 1,
            addl: 0.00 / 1
        },
        salesTaxTotals: {
            wine: 0.00 / 1,
            addl: 0.00 / 1
        }
    };
    approveHeading : string = messages['mess:approve:heading'];
    allAddresses : [any] = [{}];
    payMethods : [any] = [{}];
    orders : any[];
    newCard : any = {};
    newAddress : any = {};
    ccNumberOrig : string = '';
    isAlert : boolean;
    alert : any = {
        type: "success"
    };
    otherOptions : string = uiText.otherOptions
    payLater : any = () => {
        if (!this.selectedCard || Object.keys(this.selectedCard).length == 0) {
            return ('Pay later');
        } else {
            return ('');
        }
    };

    resetNewCard() {
        this.newCard = {};
    };

    constructor(private appService : AppService, private router : Router) {
        let ords = appService.request('orders');
        if (!ords) {
            router.navigate(['order']);
        }
        this.postApproveSubscription = appService
            .filterOn('post:save:approve:request')
            .subscribe(d => {
                if (d.data.error) {
                    console.log(d.data.error);
                } else {
                    this
                        .appService
                        .reset('orders');
                    this
                        .router
                        .navigate(['receipt']);
                }
            });
        this.getShippingSalesTaxPercSub = appService
            .filterOn('get:shipping:sales:tax:perc')
            .subscribe(d => {
                if (d.data.error) {
                    console.log(d.data.error)
                } else {
                    // shipping and salesTax perc in data console.log(d.data);
                }
            });

        this.approveArtifactsSub = appService
            .filterOn('get:approve:artifacts')
            .subscribe(d => {
                if (d.data.error) {
                    console.log(d.data.error);
                } else {
                    let artifacts = JSON.parse(d.data);
                    if (artifacts.Table.length > 0) {
                        this.selectedCard = this.defaultCard = artifacts.Table[0];
                    } else {
                        this.selectedCard = {};
                    }
                    if (artifacts.Table1.length > 0) {
                        this.selectedAddress = artifacts.Table1[0];
                    } else {
                        this.selectedAddress = {};
                    }
                    if (artifacts.Table2.length > 0) {
                        this.footer.prevBalance = artifacts.Table2[0] / 1;
                        this.footer.prevBalances = {
                            wine: artifacts.Table2[0].prevBalanceWine,
                            addl: artifacts.Table2[0].prevBalanceAddl
                        }
                    } else {
                        this.footer.prevBalances = {
                            wine: 0.00,
                            addl: 0.00
                        };
                    }
                    if (artifacts.Table3.length > 0) {
                        this.isExistsAnyCard = artifacts.Table3[0].count == 0
                            ? false
                            : true;
                    }
                }
                this.computeTotals();
            });

        this.allAddrSubscription = appService
            .filterOn('get:shipping:address')
            .subscribe(d => {
                if (d.data.error) {
                    console.log(d.data.error);
                } else {
                    this.allAddresses = JSON
                        .parse(d.data)
                        .Table;
                }
            });

        this.allCardSubscription = appService
            .filterOn('get:payment:method')
            .subscribe(d => {
                if (d.data.error) {
                    console.log(d.data.error);
                } else {
                    this.payMethods = JSON
                        .parse(d.data)
                        .Table;
                }
            });

        this.selectNewCardSub = this
            .appService
            .filterOn('select:new:card')
            .subscribe(d => {
                this.newCard = d.data || {};
                this.selectedCard = this.newCard;
                this.ccNumberOrig = this.selectedCard.ccNumber;
                this.selectedCard.ccNumber = Util.getMaskedCCNumber(this.selectedCard.ccNumber);
                this
                    .payMethodModal
                    .close();
            });

        this.useNewAddressSub = this
            .appService
            .filterOn('close:new:address:modal')
            .subscribe((d) => {
                this
                    .newAddressModal
                    .close();
                if (d.data.success) {
                    this.growlMessages = [];
                    this
                        .growlMessages
                        .push({severity: 'success', summary: 'Saved', detail: 'Data saved successfully'});
                    this.selectedAddress = d.data.address;
                }
            });
    };

    @ViewChild('newAddressModal')newAddressModal : Modal;
    useNewAddress() {
        this
            .appService
            .behEmit('open:new:address:modal');
        this
            .newAddressModal
            .open();
    }

    @ViewChild('addrModal')addrModal : Modal;
    useExistingAddress() {
        this.isAlert = false;
        this
            .appService
            .httpGet('get:shipping:address');
        this
            .addrModal
            .open();
    };

    selectAddress(address) {
        this.selectedAddress = address;
        this
            .addrModal
            .close();
    };

    @ViewChild('cardModal')cardModal : Modal;
    useExistingCard() {
        let body : any = {};
        body.data = JSON.stringify({sqlKey: 'GetAllPaymentMethods'});
        this
            .appService
            .httpGet('get:payment:method', body);
        this
            .cardModal
            .open();
    };

    @ViewChild('payMethodModal')payMethodModal : Modal;
    useNewCard() {
        let body : any = {};
        body.data = JSON.stringify({sqlKey: 'GetDefaultBillingAddressForCard'});
        this
            .appService
            .httpGet('get:default:billing:address', body);
        this
            .payMethodModal
            .open();
    };

    useOtherOptions() {
        if (Object.keys(this.selectedCard).length == 0) {
            this.selectedCard = this.defaultCard;
        } else {
            this.selectedCard = {};
        }
    };

    selectCard(card) {
        this.selectedCard = card;
        this
            .cardModal
            .close();
    };

    editWineRequest() {
        this
            .router
            .navigate(['order']);
    };

    approve() {
        let orderBundle : any = {};
        orderBundle.orderMaster = {
            MDate: new Date(),
            TotalPriceWine: this.footer.wineTotals.wine / 1,
            TotalPriceAddl: this.footer.wineTotals.addl / 1,
            SalesTaxWine: this.footer.salesTaxTotals.wine / 1,
            SalesTaxAddl: this.footer.salesTaxTotals.addl / 1,
            ShippingWine: this.footer.shippingTotals.wine / 1,
            ShippingAddl: this.footer.shippingTotals.addl / 1
        };
        let master = orderBundle.orderMaster;
        orderBundle.orderMaster.Amount = master.TotalPriceWine + master.TotalPriceAddl + master.SalesTaxWine + master.SalesTaxAddl + master.ShippingWine + master.ShippingAddl;
        //to remove zero quantities
        orderBundle.orderDetails = this
            .orders
            .filter((a) => {
                return ((a.orderQty && a.orderQty > 0) || (a.wishList && a.wishList > 0));
            })
            .map((a) => {
                return ({OfferId: a.id, OrderQty: a.orderQty, WishList: a.wishList, Price: a.price});
            });
        orderBundle.orderImpDetails = {
            AddressId: this.selectedAddress.id,
            CreditCardId: this.selectedCard.id
        };
        if (!this.selectedCard.id) {
            //new card
            if (Object.keys(this.selectedCard).length > 0) {
                if (this.newCard.isSaveForLaterUse) {

                    orderBundle.newCard = this.newCard;
                    orderBundle.newCard.ccNumber = this.ccNumberOrig;
                } else {
                    Object.assign(orderBundle.orderImpDetails, this.newCard);
                    orderBundle.orderImpDetails.ccNumber = this.ccNumberOrig;
                }
            }
        }
        this
            .appService
            .httpPost('post:save:approve:request', orderBundle);
    };

    computeTotals() {
        this.orders = this
            .appService
            .request('orders');
        //totals
        if (!this.orders) {
            console.log('Order request is not available.');
            return;
        }
        this.footer.wineTotals = this
            .orders
            .reduce(function (a, b) {
                return ({
                    wine: a.wine + b.price * b.orderQty,
                    addl: a.addl + b.price * b.wishList
                })
            }, {
                wine: 0,
                addl: 0
            });

        //Sales tax
        this.computeSalesTax();
        this.computeShipping();

        //grand totals
        this.footer.grandTotals = {
            wine: this.footer.wineTotals.wine / 1 + this.footer.salesTaxTotals.wine / 1 + this.footer.shippingTotals.wine / 1 + this.footer.prevBalances.wine / 1,
            addl: this.footer.wineTotals.addl / 1 + this.footer.salesTaxTotals.addl / 1 + this.footer.shippingTotals.addl / 1 + this.footer.prevBalances.addl / 1
        };
    };

    computeSalesTax() {
        let effectiveSalesTaxPerc = this.selectedAddress.salesTaxPerc;
        if (effectiveSalesTaxPerc && (effectiveSalesTaxPerc > 0)) {
            this.footer.salesTaxPerc = effectiveSalesTaxPerc;
        } else {
            effectiveSalesTaxPerc = this.selectedAddress.defaultSalesTaxPerc;
            if (effectiveSalesTaxPerc && (effectiveSalesTaxPerc > 0)) {
                this.footer.salesTaxPerc = effectiveSalesTaxPerc;
            } else {
                this.footer.salesTaxPerc = 0.00;
            }
        }
        this.footer.salesTaxTotals = {
            wine: this.footer.wineTotals.wine * this.footer.salesTaxPerc / 100,
            addl: this.footer.wineTotals.addl * this.footer.salesTaxPerc / 100
        }
    };

    computeShipping() {
        let effectiveShipping = this.selectedAddress.shippingCharges;
        if (effectiveShipping && (effectiveShipping > 0)) {
            this.footer.shippingTotals = effectiveShipping;
        } else {
            effectiveShipping = this.selectedAddress.defaultShippingCharges;
            if (effectiveShipping && (effectiveShipping > 0)) {
                this.footer.shippingTotals = {
                    wine: effectiveShipping,
                    addl: effectiveShipping
                };
            } else {
                this.footer.shippingTotals = {
                    wine: 0.00,
                    addl: 0.00
                };
            }
        }
    };

    useNewAddressSub : Subscription;
    ngOnInit() {
        this
            .appService
            .httpGet('get:approve:artifacts');
        let body : any = {};
        body.data = JSON.stringify({
            sqlKey: 'GetShippingSalesTaxPerc',
            sqlParms: {
                zip: '1111',
                bottles: 100
            }
        });
        this
            .appService
            .httpGet('get:shipping:sales:tax:perc', body);
        this
            .appService
            .reply('close:pay:method:modal', () => {
                this
                    .payMethodModal
                    .close()
            });
    };

    ngOnDestroy() {
        this
            .approveArtifactsSub
            .unsubscribe();
        this
            .postApproveSubscription
            .unsubscribe();
        this
            .getShippingSalesTaxPercSub
            .unsubscribe();
        this
            .allAddrSubscription
            .unsubscribe();
        this
            .allCardSubscription
            .unsubscribe();
        this
            .selectNewCardSub
            .unsubscribe();
        this
            .useNewAddressSub
            .unsubscribe();
    };
}