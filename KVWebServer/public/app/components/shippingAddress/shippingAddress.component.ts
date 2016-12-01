import { Component, ViewChild } from '@angular/core';
import { Subscription } from 'rxjs/Subscription';
import { AppService } from '../../services/app.service';
import { FormBuilder, Validators, FormControl, FormGroup } from '@angular/forms';
import { CustomValidators } from '../../services/customValidators';
import { Modal, ModalModule } from "ng2-modal"
import { AlertModule } from 'ng2-bootstrap/components/alert';
import { ControlMessages } from '../controlMessages/controlMessages.component';
@Component({
    templateUrl: 'app/components/shippingAddress/shippingAddress.component.html'
})
export class ShippingAddress {
    getSubscription: Subscription;
    postSubscription: Subscription;
    putSubscription: Subscription;
    shippingForm: FormGroup;
    alert:any={};
    @ViewChild('shippingModal') shippingModal: Modal;
    addresses: [{}];
    //isDefault: boolean = true;
    constructor(private appService: AppService, private fb: FormBuilder) {
        this.initshippingForm();
        this.getSubscription = appService.filterOn("get:shipping:address")
            .subscribe(d => {
                this.addresses = JSON.parse(d.data).Table;
                console.log(d);
            });
        this.postSubscription = appService.filterOn("post:shipping:address")
            .subscribe(d => {
                if (d.data.error) {
                    this.appService.showAlert(this.alert,true,'addressSaveFailed');                    
                } else {
                    this.appService.httpGet('get:shipping:address');
                    this.initshippingForm();
                    this.appService.showAlert(this.alert,false);
                    this.shippingModal.close();
                }
            });
        this.putSubscription = appService.filterOn("put:shipping:address")
            .subscribe(d => {
                if (d.data.error) {
                    this.appService.showAlert(this.alert,true,'addressSaveFailed');
                } else {
                    this.appService.httpGet('get:shipping:address');
                    this.initshippingForm();
                    this.appService.showAlert(this.alert,false);
                    this.shippingModal.close();
                }
            });
    };
    initshippingForm(){
        this.shippingForm = this.fb.group({
            id: [''],
            address1: ['', Validators.required],
            city: ['', Validators.required],
            state: ['', Validators.required],
            zip: ['', Validators.required],
            isDefault: [false]
        });
    }
    ngOnInit() {
        this.appService.httpGet('get:shipping:address', { token: this.appService.getToken() });
    }
    edit(address) {
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
    delete(address){
        if(confirm('Are you sure to delete this address')){
            console.log('true');
        } else{
            console.log(false);
        }
    }
    submit() {
        let addr = {
            id: this.shippingForm.controls['id'].value,
            address1: this.shippingForm.controls['address1'].value,
            city: this.shippingForm.controls['city'].value,
            state: this.shippingForm.controls['state'].value,
            zip: this.shippingForm.controls['zip'].value,
            isDefault: this.shippingForm.controls['isDefault'].value
        };
        if (addr.id) {
            this.appService.httpPut('put:shipping:address', { address: addr });
        } else {
            this.appService.httpPost('post:shipping:address', { address: addr });
        }

    }
    addAddress() {        
        this.shippingModal.open();
    };    
    cancel(){
        this.appService.showAlert(this.alert,false);
        this.shippingForm.reset();
        this.shippingModal.close();
    }
    ngOnDestroy() {
        this.getSubscription.unsubscribe();
        this.postSubscription.unsubscribe();
        this.putSubscription.unsubscribe();
    };
}