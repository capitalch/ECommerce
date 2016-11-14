import { Component } from '@angular/core';
import { Subscription } from 'rxjs/subscription';
import { AppService } from '../../services/app.service';

@Component({
    templateUrl: 'app/components/shippingAddress/shippingAddress.component.html'
})
export class ShippingAddress {
    getSubscription: Subscription;
    postSubscription: Subscription;
    addresses: [{}];
    isDefault: boolean = true;
    constructor(private appService: AppService) {
        this.getSubscription = appService.filterOn("get:shipping:address")
            .subscribe(d => {
                this.addresses = JSON.parse(d.data).Table;
                console.log(d);
            });
        this.postSubscription = appService.filterOn("post:shipping:address")
            .subscribe(d => {
                console.log(d);
            });
    };
    ngOnInit() {
        let token = this.appService.getToken();
        this.appService.httpGet('get:shipping:address', { token: token });
    }
    toggleEdit(address) {
        // if (address.isEdit) {
        //     address.isEdit = false;
        // } else {
        //     address.isEdit = true;
        // }
        this.addresses.map((d: any, i) => d.isEdit = false);
        address.isEdit = true;
        address.isDirty = true;
    };
    setDefault(address) {
        this.addresses.map((d: any, i) => { d.isDefault = false; d.isDirty = true; });
        address.isDefault = true;
    };
    submit() {
        let dirtyAddresses = this.addresses.filter((v: any, i) => v.isDirty);
        if (dirtyAddresses.length > 0) {
            let token = this.appService.getToken();
            this.appService.httpPost('post:shipping:address', { token: token, addresses: dirtyAddresses });
        }
    };
    addAddress() {
        let address = {address1:'',city:'',zip:'',street:''};
        this.addresses.unshift(address);
        this.toggleEdit(address);
    };
    ngOnDestroy() {
        this.getSubscription.unsubscribe();
        this.postSubscription.unsubscribe();
    };
}