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
var router_1 = require('@angular/router');
var app_service_1 = require('../services/app.service');
var config_1 = require('../config');
var AppComponent = (function () {
    function AppComponent(appService, router) {
        var _this = this;
        this.appService = appService;
        this.router = router;
        this.home = '#';
        this.kistler = '#';
        this.viewBox = config_1.viewBoxConfig['/login'];
        this.initDataSub = appService.filterOn('get:init:data').subscribe(function (d) {
            if (d.data.error) {
                console.log(d.data.error);
            }
            else {
                _this.home = d.data.host;
                _this.kistler = d.data.kistler;
            }
        });
        router.events.filter(function (e, t) {
            return (e.constructor.name === 'NavigationEnd');
        }).subscribe(function (event) {
            var url = event.urlAfterRedirects.split('?')[0];
            _this.viewBox = config_1.viewBoxConfig[url];
        });
    }
    ;
    AppComponent.prototype.logout = function () {
        this.appService.resetCredential();
    };
    AppComponent.prototype.ngOnInit = function () {
        this.appService.httpGet('get:init:data');
    };
    ;
    AppComponent.prototype.ngOnDestroy = function () {
        this.subscription.unsubscribe();
        this.initDataSub.unsubscribe();
    };
    AppComponent = __decorate([
        core_1.Component({
            selector: 'my-app',
            templateUrl: 'app/components/app.component.html'
        }), 
        __metadata('design:paramtypes', [app_service_1.AppService, router_1.Router])
    ], AppComponent);
    return AppComponent;
}());
exports.AppComponent = AppComponent;
//# sourceMappingURL=app.component.js.map