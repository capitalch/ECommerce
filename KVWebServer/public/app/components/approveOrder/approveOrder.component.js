"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var core_1 = require("@angular/core");
var app_service_1 = require("../../services/app.service");
var util_1 = require("../../services/util");
var router_1 = require("@angular/router");
var config_1 = require("../../config");
var ng2_modal_1 = require("ng2-modal");
var config_2 = require("../../config");
var ApproveOrder = (function () {
    function ApproveOrder(appService, router) {
        var _this = this;
        this.appService = appService;
        this.router = router;
        this.selectedAddress = {};
        this.selectedCard = {};
        this.defaultCard = {};
        this.allTotals = {};
        // payMethodForm: FormGroup;
        this.footer = {
            wineTotals: {
                wine: 0.00, addl: 0.00
            },
            salesTaxPerc: 0.00,
            shippingCharges: 0.00,
            shippingTotals: { wine: 0.00 / 1, addl: 0.00 / 1 },
            prevBalances: { wine: 0.00 / 1, addl: 0.00 / 1 },
            grandTotals: { wine: 0.00 / 1, addl: 0.00 / 1 },
            salesTaxTotals: { wine: 0.00 / 1, addl: 0.00 / 1 }
        };
        this.approveHeading = config_1.messages['mess:approve:heading'];
        this.allAddresses = [{}];
        this.payMethods = [{}];
        this.newCard = {};
        this.ccNumberOrig = '';
        this.alert = { type: "success" };
        this.otherOptions = config_2.uiText.otherOptions;
        this.payLater = function () {
            if (!_this.selectedCard || Object.keys(_this.selectedCard).length == 0) {
                return ('Pay later');
            }
            else {
                return ('');
            }
        };
        var ords = appService.request('orders');
        if (!ords) {
            router.navigate(['order']);
        }
        this.postApproveSubscription = appService.filterOn('post:save:approve:request').subscribe(function (d) {
            if (d.data.error) {
                console.log(d.data.error);
            }
            else {
                _this.appService.reset('orders');
                _this.router.navigate(['receipt']);
            }
        });
        this.getShippingSalesTaxPercSub = appService.filterOn('get:shipping:sales:tax:perc').subscribe(function (d) {
            if (d.data.error) {
                console.log(d.data.error);
            }
            else {
            }
        });
        this.approveArtifactsSub = appService.filterOn('get:approve:artifacts').subscribe(function (d) {
            if (d.data.error) {
                console.log(d.data.error);
            }
            else {
                var artifacts = JSON.parse(d.data);
                if (artifacts.Table.length > 0) {
                    _this.selectedCard = _this.defaultCard = artifacts.Table[0];
                }
                else {
                    _this.selectedCard = {};
                }
                if (artifacts.Table1.length > 0) {
                    _this.selectedAddress = artifacts.Table1[0];
                }
                else {
                    _this.selectedAddress = {};
                }
                if (artifacts.Table2.length > 0) {
                    _this.footer.prevBalance = artifacts.Table2[0] / 1;
                    _this.footer.prevBalances = { wine: artifacts.Table2[0].prevBalanceWine, addl: artifacts.Table2[0].prevBalanceAddl };
                }
                else {
                    _this.footer.prevBalances = { wine: 0.00, addl: 0.00 };
                }
            }
            _this.computeTotals();
        });
        this.allAddrSubscription = appService.filterOn('get:shipping:address').subscribe(function (d) {
            if (d.data.error) {
                console.log(d.data.error);
            }
            else {
                _this.allAddresses = JSON.parse(d.data).Table;
            }
        });
        this.allCardSubscription = appService.filterOn('get:payment:method').subscribe(function (d) {
            if (d.data.error) {
                console.log(d.data.error);
            }
            else {
                _this.payMethods = JSON.parse(d.data).Table;
            }
        });
        this.selectNewCardSub = this.appService.filterOn('select:new:card').subscribe(function (d) {
            _this.newCard = d.data || {};
            _this.selectedCard = _this.newCard;
            _this.ccNumberOrig = _this.selectedCard.ccNumber;
            _this.selectedCard.ccNumber = util_1.Util.getMaskedCCNumber(_this.selectedCard.ccNumber);
            _this.payMethodModal.close();
        });
    }
    ApproveOrder.prototype.useNewCard = function () {
        var body = {};
        body.data = JSON.stringify({ sqlKey: 'GetDefaultBillingAddressForCard' });
        this.appService.httpGet('get:default:billing:address', body);
        this.payMethodModal.open();
    };
    ;
    ApproveOrder.prototype.resetNewCard = function () {
        this.newCard = {};
    };
    ;
    ApproveOrder.prototype.changeSelectedAddress = function () {
        this.isAlert = false;
        this.appService.httpGet('get:shipping:address');
        this.addrModal.open();
    };
    ;
    ApproveOrder.prototype.selectAddress = function (address) {
        this.selectedAddress = address;
        this.addrModal.close();
    };
    ;
    ApproveOrder.prototype.changeSelectedCard = function () {
        var body = {};
        body.data = JSON.stringify({ sqlKey: 'GetAllPaymentMethods' });
        this.appService.httpGet('get:payment:method', body);
        this.cardModal.open();
    };
    ;
    ApproveOrder.prototype.selectCard = function (card) {
        this.selectedCard = card;
        this.cardModal.close();
    };
    ;
    ApproveOrder.prototype.editWineRequest = function () {
        this.router.navigate(['order']);
    };
    ;
    ApproveOrder.prototype.approve = function () {
        var orderBundle = {};
        orderBundle.orderMaster = {
            MDate: new Date(),
            TotalPriceWine: this.footer.wineTotals.wine / 1,
            TotalPriceAddl: this.footer.wineTotals.addl / 1,
            SalesTaxWine: this.footer.salesTaxTotals.wine / 1,
            SalesTaxAddl: this.footer.salesTaxTotals.addl / 1,
            ShippingWine: this.footer.shippingTotals.wine / 1,
            ShippingAddl: this.footer.shippingTotals.addl / 1
        };
        var master = orderBundle.orderMaster;
        orderBundle.orderMaster.Amount = master.TotalPriceWine + master.TotalPriceAddl + master.SalesTaxWine
            + master.SalesTaxAddl + master.ShippingWine + master.ShippingAddl;
        //to remove zero quantities
        orderBundle.orderDetails = this.orders.filter(function (a) {
            return ((a.orderQty && a.orderQty > 0) || (a.wishList && a.wishList > 0));
        }).map(function (a) {
            return ({
                OfferId: a.id,
                OrderQty: a.orderQty,
                WishList: a.wishList,
                Price: a.price
            });
        });
        orderBundle.orderImpDetails = { AddressId: this.selectedAddress.id, CreditCardId: this.selectedCard.id };
        if (!this.selectedCard.id) {
            if (Object.keys(this.selectedCard).length > 0) {
                Object.assign(orderBundle.orderImpDetails, this.newCard);
                orderBundle.orderImpDetails.ccNumber = this.ccNumberOrig;
            }
        }
        this.appService.httpPost('post:save:approve:request', orderBundle);
    };
    ;
    ApproveOrder.prototype.otherOptionsClicked = function () {
        if (Object.keys(this.selectedCard).length == 0) {
            this.selectedCard = this.defaultCard;
        }
        else {
            this.selectedCard = {};
        }
    };
    ;
    ApproveOrder.prototype.computeTotals = function () {
        this.orders = this.appService.request('orders');
        //totals
        if (!this.orders) {
            console.log('Order request is not available.');
            return;
        }
        this.footer.wineTotals = this.orders.reduce(function (a, b) {
            return ({
                wine: a.wine + b.price * b.orderQty,
                addl: a.addl + b.price * b.wishList
            });
        }, { wine: 0, addl: 0 });
        //Sales tax
        this.computeSalesTax();
        this.computeShipping();
        //grand totals
        this.footer.grandTotals = {
            wine: this.footer.wineTotals.wine / 1 + this.footer.salesTaxTotals.wine / 1 + this.footer.shippingTotals.wine / 1
                + this.footer.prevBalances.wine / 1,
            addl: this.footer.wineTotals.addl / 1 + this.footer.salesTaxTotals.addl / 1 + this.footer.shippingTotals.addl / 1
                + this.footer.prevBalances.addl / 1
        };
    };
    ;
    ApproveOrder.prototype.computeSalesTax = function () {
        var effectiveSalesTaxPerc = this.selectedAddress.salesTaxPerc;
        if (effectiveSalesTaxPerc && (effectiveSalesTaxPerc > 0)) {
            this.footer.salesTaxPerc = effectiveSalesTaxPerc;
        }
        else {
            effectiveSalesTaxPerc = this.selectedAddress.defaultSalesTaxPerc;
            if (effectiveSalesTaxPerc && (effectiveSalesTaxPerc > 0)) {
                this.footer.salesTaxPerc = effectiveSalesTaxPerc;
            }
            else {
                this.footer.salesTaxPerc = 0.00;
            }
        }
        this.footer.salesTaxTotals = {
            wine: this.footer.wineTotals.wine * this.footer.salesTaxPerc / 100,
            addl: this.footer.wineTotals.addl * this.footer.salesTaxPerc / 100
        };
    };
    ;
    ApproveOrder.prototype.computeShipping = function () {
        var effectiveShipping = this.selectedAddress.shippingCharges;
        if (effectiveShipping && (effectiveShipping > 0)) {
            this.footer.shippingTotals = effectiveShipping;
        }
        else {
            effectiveShipping = this.selectedAddress.defaultShippingCharges;
            if (effectiveShipping && (effectiveShipping > 0)) {
                this.footer.shippingTotals = { wine: effectiveShipping, addl: effectiveShipping };
            }
            else {
                this.footer.shippingTotals = { wine: 0.00, addl: 0.00 };
            }
        }
    };
    ;
    ApproveOrder.prototype.ngOnInit = function () {
        var _this = this;
        this.appService.httpGet('get:approve:artifacts');
        var body = {};
        body.data = JSON.stringify({ sqlKey: 'GetShippingSalesTaxPerc', sqlParms: { zip: '1111', bottles: 100 } });
        this.appService.httpGet('get:shipping:sales:tax:perc', body);
        this.appService.reply('close:pay:method:modal', function () { _this.payMethodModal.close(); });
    };
    ;
    ApproveOrder.prototype.ngOnDestroy = function () {
        this.approveArtifactsSub.unsubscribe();
        this.postApproveSubscription.unsubscribe();
        this.getShippingSalesTaxPercSub.unsubscribe();
        this.allAddrSubscription.unsubscribe();
        this.allCardSubscription.unsubscribe();
        this.selectNewCardSub.unsubscribe();
    };
    ;
    return ApproveOrder;
}());
__decorate([
    core_1.ViewChild('payMethodModal'),
    __metadata("design:type", ng2_modal_1.Modal)
], ApproveOrder.prototype, "payMethodModal", void 0);
__decorate([
    core_1.ViewChild('addrModal'),
    __metadata("design:type", ng2_modal_1.Modal)
], ApproveOrder.prototype, "addrModal", void 0);
__decorate([
    core_1.ViewChild('cardModal'),
    __metadata("design:type", ng2_modal_1.Modal)
], ApproveOrder.prototype, "cardModal", void 0);
ApproveOrder = __decorate([
    core_1.Component({
        templateUrl: 'app/components/approveOrder/approveOrder.component.html'
    }),
    __metadata("design:paramtypes", [app_service_1.AppService, router_1.Router])
], ApproveOrder);
exports.ApproveOrder = ApproveOrder;
//# sourceMappingURL=approveOrder.component.js.map