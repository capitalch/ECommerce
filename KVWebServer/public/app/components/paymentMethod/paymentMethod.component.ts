import { Component, ViewChild } from '@angular/core';
import { Subscription } from 'rxjs/Subscription';
import { AppService } from '../../services/app.service';
import { FormBuilder, Validators, FormControl, FormGroup } from '@angular/forms';
import { CustomValidators } from '../../services/customValidators';
import { Modal, ModalModule } from "ng2-modal"
import { AlertModule } from 'ng2-bootstrap/components/alert';
import { ControlMessages } from '../controlMessages/controlMessages.component';
// import {SpinnerModule} from 'primeng/primeng';
@Component({
    templateUrl: 'app/components/paymentMethod/paymentMethod.component.html'
})
export class PaymentMethod {
    getAllPaymentMethodsSub: Subscription;
    postPayMethodSub: Subscription;
    deletePayMethodSub: Subscription;
    setDefaultPayMethodSub:Subscription;
    dataReadySubs: Subscription;
    payMethodForm: FormGroup;
    alert: any = {};
    // months: [number] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
    year: number;
    month: number;
    // currentYear: number = (new Date()).getFullYear();
    countries: [any];
    selectedISOCode: string = '';
    @ViewChild('payMethodModal') payMethodModal: Modal;    
    payMethods: [any];
    isDataReady: boolean = false;
    constructor(private appService: AppService, private fb: FormBuilder) {
        this.initPayMethodForm();
        this.getAllPaymentMethodsSub = appService.filterOn("get:payment:method")
            .subscribe(d => {
                if (d.data.error) {
                    console.log(d);
                } else {
                    this.payMethods = JSON.parse(d.data).Table;
                    console.log(this.payMethods);
                }
            });
        this.dataReadySubs = appService.behFilterOn('masters:download:success').subscribe(d => {
            this.countries = this.appService.getCountries();
            this.isDataReady = true;
        });
        this.postPayMethodSub = appService.filterOn("post:payment:method")
            .subscribe(d => {
                if (d.data.error) {
                    this.appService.showAlert(this.alert, true, 'payMethodInsertFailed');
                }
                else {
                    this.initPayMethodForm();
                    this.appService.showAlert(this.alert, false);
                    this.getPaymentMethod();
                    this.payMethodModal.close();
                }
            });
        this.deletePayMethodSub = appService.filterOn("post:delete:payment:method")
            .subscribe(d => {
                if (d.data.error) {
                    console.log("Error occured");
                } else {
                    //this.payMethods.splice(d.body.index, 1);
                    this.getPaymentMethod();
                }
            });
        this.setDefaultPayMethodSub = appService.filterOn("post:set:default:payment:method")
        .subscribe(d=>{
            if(d.data.error){
                console.log('Error occured');
            } else{
                console.log('Successfully set as default')
            }
        });
    };
    initPayMethodForm() {
        this.year = (new Date()).getFullYear();
        this.month = (new Date()).getMonth() + 1;
        this.payMethodForm = this.fb.group({
            id: ['']
            , cardName: ['', Validators.required]
            , ccFirstName: ['', Validators.required]
            , ccLastName: ['', Validators.required]
            , ccType: ['', Validators.required]
            , ccNumber: ['', Validators.required]
            , ccExpiryMonth: [this.month, Validators.required]
            , ccExpiryYear: [this.year, Validators.required]
            , ccSecurityCode: ['', Validators.required]
            , co: ['']
            , name: ['', Validators.required]
            , street1: ['', Validators.required]
            , street2: ['', Validators.required]
            , city: ['', Validators.required]
            , state: ['', Validators.required]
            , zip: ['', Validators.required]
            , countryName: ['', Validators.required]
            , isoCode: ['']
            , phone: ['', [Validators.required, CustomValidators.phoneValidator]]
            , isDefault: [false]
        });
    }
    addPayMethod() {
        this.initPayMethodForm();
        this.payMethodModal.open();
    };
    cancel() {
        this.appService.showAlert(this.alert, false);
        this.payMethodModal.close();
    }
    
    remove(card) {        
        this.appService.httpPost('post:delete:payment:method', { sqlKey: 'DeletePaymentMethod', sqlParms: { id: card.id }});
    };
    submit() {
        let payMethod = {
            cardName: this.payMethodForm.controls['cardName'].value
            , ccFirstName: this.payMethodForm.controls['ccFirstName'].value
            , ccLastName: this.payMethodForm.controls['ccLastName'].value
            , ccType: this.payMethodForm.controls['ccType'].value
            , ccNumber: this.payMethodForm.controls['ccNumber'].value
            , ccExpiryMonth: this.payMethodForm.controls['ccExpiryMonth'].value
            , ccExpiryYear: this.payMethodForm.controls['ccExpiryYear'].value
            , ccSecurityCode: this.payMethodForm.controls['ccSecurityCode'].value
            //, co: ['']
            , name: this.payMethodForm.controls['name'].value
            , street1: this.payMethodForm.controls['street1'].value
            , street2: this.payMethodForm.controls['street2'].value
            , city: this.payMethodForm.controls['city'].value
            , state: this.payMethodForm.controls['state'].value
            , zip: this.payMethodForm.controls['zip'].value
            , country: ''
            , isoCode: ''
            , phone: this.payMethodForm.controls['phone'].value
            , isDefault: this.payMethodForm.controls['isDefault'].value
        };
        payMethod.isoCode = this.selectedISOCode;
        payMethod.country = this.countries.filter(d => d.isoCode == this.selectedISOCode)[0].countryName;
        this.appService.httpPost('post:payment:method', { sqlKey: 'InsertPaymentMethod', sqlParms: payMethod });
    };
    setDefault(card) {
        this.appService.httpPost('post:set:default:payment:method', {sqlKey:'SetDefaultPaymentMethod',sqlParms:{id:card.id}});
    }
    ngOnInit() {
        // this.appService.httpGet('get:credit:card', { token: token });
        this.getPaymentMethod();
    };
    getPaymentMethod() {
        let body: any = {};
        body.data = JSON.stringify({ sqlKey: 'GetAllPaymentMethods' });
        this.appService.httpGet('get:payment:method', body);
    }
    ngOnDestroy() {
        this.getAllPaymentMethodsSub.unsubscribe();
        this.dataReadySubs.unsubscribe();
        this.postPayMethodSub.unsubscribe();
        this.deletePayMethodSub.unsubscribe();
        // this.setDefaultCardSubscription.unsubscribe();
    };
}