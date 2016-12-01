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
var core_1 = require('@angular/core');
var app_service_1 = require('../../services/app.service');
var forms_1 = require('@angular/forms');
var ng2_modal_1 = require("ng2-modal");
var ShippingAddress = (function () {
    //isDefault: boolean = true;
    function ShippingAddress(appService, fb) {
        var _this = this;
        this.appService = appService;
        this.fb = fb;
        this.alert = {};
        this.initshippingForm();
        this.getSubscription = appService.filterOn("get:shipping:address")
            .subscribe(function (d) {
            _this.addresses = JSON.parse(d.data).Table;
            console.log(d);
        });
        this.postSubscription = appService.filterOn("post:shipping:address")
            .subscribe(function (d) {
            if (d.data.error) {
                _this.appService.showAlert(_this.alert, true, 'addressSaveFailed');
            }
            else {
                _this.appService.httpGet('get:shipping:address');
                _this.initshippingForm();
                _this.appService.showAlert(_this.alert, false);
                _this.shippingModal.close();
            }
        });
        this.putSubscription = appService.filterOn("put:shipping:address")
            .subscribe(function (d) {
            if (d.data.error) {
                _this.appService.showAlert(_this.alert, true, 'addressSaveFailed');
            }
            else {
                _this.appService.httpGet('get:shipping:address');
                _this.initshippingForm();
                _this.appService.showAlert(_this.alert, false);
                _this.shippingModal.close();
            }
        });
    }
    ;
    ShippingAddress.prototype.initshippingForm = function () {
        this.shippingForm = this.fb.group({
            id: [''],
            address1: ['', forms_1.Validators.required],
            city: ['', forms_1.Validators.required],
            state: ['', forms_1.Validators.required],
            zip: ['', forms_1.Validators.required],
            isDefault: [false]
        });
    };
    ShippingAddress.prototype.ngOnInit = function () {
        this.appService.httpGet('get:shipping:address', { token: this.appService.getToken() });
    };
    ShippingAddress.prototype.edit = function (address) {
        this.shippingForm.patchValue({
            id: address.id,
            address1: address.address1,
            city: address.city,
            state: address.state,
            zip: address.zip,
            isDefault: address.isDefault
        });
        this.shippingModal.open();
    };
    ;
    ShippingAddress.prototype.delete = function (address) {
        if (confirm('Are you sure to delete this address')) {
            console.log('true');
        }
        else {
            console.log(false);
        }
    };
    ShippingAddress.prototype.submit = function () {
        var addr = {
            id: this.shippingForm.controls['id'].value,
            address1: this.shippingForm.controls['address1'].value,
            city: this.shippingForm.controls['city'].value,
            state: this.shippingForm.controls['state'].value,
            zip: this.shippingForm.controls['zip'].value,
            isDefault: this.shippingForm.controls['isDefault'].value
        };
        if (addr.id) {
            this.appService.httpPut('put:shipping:address', { address: addr });
        }
        else {
            this.appService.httpPost('post:shipping:address', { address: addr });
        }
    };
    ShippingAddress.prototype.addAddress = function () {
        this.shippingModal.open();
    };
    ;
    ShippingAddress.prototype.cancel = function () {
        this.appService.showAlert(this.alert, false);
        this.shippingForm.reset();
        this.shippingModal.close();
    };
    ShippingAddress.prototype.ngOnDestroy = function () {
        this.getSubscription.unsubscribe();
        this.postSubscription.unsubscribe();
        this.putSubscription.unsubscribe();
    };
    ;
    __decorate([
        core_1.ViewChild('shippingModal'), 
        __metadata('design:type', ng2_modal_1.Modal)
    ], ShippingAddress.prototype, "shippingModal", void 0);
    ShippingAddress = __decorate([
        core_1.Component({
            templateUrl: 'app/components/shippingAddress/shippingAddress.component.html'
        }), 
        __metadata('design:paramtypes', [app_service_1.AppService, forms_1.FormBuilder])
    ], ShippingAddress);
    return ShippingAddress;
}());
exports.ShippingAddress = ShippingAddress;
//# sourceMappingURL=shippingAddress.component.js.map