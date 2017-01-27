import {Component, ViewChild} from '@angular/core';
import {Subscription} from 'rxjs/Subscription';
import {PaginationModule} from 'ng2-bootstrap/components/Pagination';
import {AppService} from '../../services/app.service';
import {ModalModule, Modal} from "ng2-modal";
import {AlertModule} from 'ng2-bootstrap/components/alert';
import {GrowlModule} from 'primeng/components/growl/growl';

@Component({templateUrl: 'app/components/orderHistory/orderHistory.component.html'})
export class OrderHistory {
    isDataAvailable : boolean = false;
    orderHeaderSub : Subscription;
    orderDetailsSub : Subscription;
    allAddrSubscription : Subscription;
    postOrderChangeAddressSub : Subscription;
    allCardSubscription : Subscription;
    postOrderChangeCardSub : Subscription;
    payMethods : any = [{}];
    allAddresses : any = [{}];
    growlMessages : any = [];
    orderHeaders : [{}];
    orderImpDetailsId : string;
    selectedAddress : any;
    orderDetails : any = {
        details: [
            {}
        ],
        address: {},
        card: {}
    };
    selectedOrder : {} = {};
    //Pagination
    pageRows : any;
    itemsPerPage : number = 5;
    maxSize : number = 5;
    alert : any = {
        show: false,
        type: 'danger',
        message: this
            .appService
            .getValidationErrorMessage('invalidAddress')
    };
    onPageChange(page : any) {
        let start = (page.page - 1) * page.itemsPerPage;
        let end = page.itemsPerPage > -1
            ? (start + page.itemsPerPage)
            : this.orderHeaders.length;
        this.pageRows = this
            .orderHeaders
            .slice(start, end);
        if (this.pageRows.length > 0) {
            this.showDetails(this.pageRows[0]);
        }
    }
    constructor(private appService : AppService) {
        this.orderDetailsSub = appService
            .filterOn('get:order:details')
            .subscribe(d => {
                if (d.data.error) {
                    console.log(d.data.error);
                } else {
                    let tables = JSON.parse(d.data);
                    this.orderDetails.details = tables.Table;
                    this.orderDetails.address = tables.Table1[0];
                    this.orderDetails.card = tables.Table2[0];
                    //to escape from null values
                    this.orderDetails.details = this.orderDetails.details
                        ? this.orderDetails.details
                        : [{}];
                    this.orderDetails.address = this.orderDetails.address
                        ? this.orderDetails.address
                        : {};
                    this.orderDetails.card = this.orderDetails.card
                        ? this.orderDetails.card
                        : {};
                }
            });

        this.orderHeaderSub = appService
            .filterOn('get:order:headers')
            .subscribe(d => {
                if (d.data.error) {
                    console.log(d.data.error);
                } else {
                    this.orderHeaders = JSON
                        .parse(d.data)
                        .Table;
                    this.pageRows = this
                        .orderHeaders
                        .slice(0, this.itemsPerPage);
                    if (this.orderHeaders.length > 0) {
                        let ord : any = this.orderHeaders[0];
                        ord.checked = true;
                        this.showDetails(ord);
                        this.isDataAvailable = true;
                    }
                }
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

        this.postOrderChangeAddressSub = appService
            .filterOn('post:order:change:shipping:address')
            .subscribe(d => {
                if (d.data.error) {
                    console.log(d.data.error);
                    appService.showAlert(this.alert, true, 'dataNotSaved');
                } else {
                    appService.showAlert(this.alert, false);
                    this.orderDetails.address = this.selectedAddress;
                    this.orderDetails.address.orderImpDetailsId = this.orderImpDetailsId;
                    this.growlMessages = [];
                    this
                        .growlMessages
                        .push({severity: 'success', summary: 'Success', detail: 'Data saved successfully'});
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
        this.postOrderChangeCardSub = appService
            .filterOn('post:order:change:payment:method')
            .subscribe(d => {
                if (d.data.error) {
                    console.log(d.data.error);
                    appService.showAlert(this.alert, true, 'dataNotSaved');
                } else {
                    appService.showAlert(this.alert, false);
                    this.orderDetails.card = this.selectedCard;
                    this.orderDetails.card.orderImpDetailsId = this.orderImpDetailsId;
                    this.growlMessages = [];
                    this
                        .growlMessages
                        .push({severity: 'success', summary: 'Success', detail: 'Data saved successfully'});
                }
            });
    };

    showDetails(order) {
        this
            .orderHeaders
            .map((a : any, b) => {
                a.checked = false;
            }); //to uncheck all rows
        order.grandTotalWine = order.totalPriceWine / 1 + order.salesTaxWine / 1 + order.shippingWine / 1;
        order.grandTotalAddl = order.totalPriceAddl / 1 + order.salesTaxAddl / 1 + order.shippingAddl / 1;
        order.checked = true; // to check current row
        this.selectedOrder = order;
        this
            .appService
            .httpGet('get:order:details', {id: order.id})
    };

    selectAddress(address) {
        this.selectedAddress = address;
        this.orderImpDetailsId = this.orderDetails.address.orderImpDetailsId;
        this
            .appService
            .showAlert(this.alert, false);
        this
            .appService
            .httpPost('post:order:change:shipping:address', {
                sqlKey: 'UpdateOrderShippingAddress',
                sqlParms: {
                    addressId: address.id,
                    id: this.orderImpDetailsId //this is orderImpDetailsId
                }
            });
        this
            .addrModal
            .close();
    }

    @ViewChild('addrModal')addrModal : Modal;
    changeAddress() {
        this
            .appService
            .httpGet('get:shipping:address');
        this
            .addrModal
            .open();
    }

    @ViewChild('cardModal')cardModal : Modal;
    changePaymentMethod() {
        let body : any = {};
        body.data = JSON.stringify({sqlKey: 'GetAllPaymentMethods'});
        this
            .appService
            .httpGet('get:payment:method', body);
        this
            .cardModal
            .open();
    }

    selectedCard : {};
    selectCard(card) {
        this.selectedCard = card;
        this.orderImpDetailsId = this.orderDetails.card.orderImpDetailsId;
        this
            .appService
            .showAlert(this.alert, false);
        this
            .appService
            .httpPost('post:order:change:payment:method', {
                sqlKey: 'UpdateOrderPaymentMethod',
                sqlParms: {
                    cardId: card.id,
                    id: this.orderImpDetailsId //this is orderImpDetailsId
                }
            });
        this
            .cardModal
            .close();
    }

    ngOnInit() {
        this
            .appService
            .httpGet('get:order:headers')
    };

    ngOnDestroy() {
        this
            .orderHeaderSub
            .unsubscribe();
        this
            .orderDetailsSub
            .unsubscribe();
        this
            .allAddrSubscription
            .unsubscribe();
        this
            .postOrderChangeAddressSub
            .unsubscribe();
        this
            .allCardSubscription
            .unsubscribe();
        this
            .postOrderChangeCardSub
            .unsubscribe();
    };
}