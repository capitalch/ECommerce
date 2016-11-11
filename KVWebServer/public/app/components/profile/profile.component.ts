import { Component } from '@angular/core';
import { Subscription } from 'rxjs/subscription';
import { AppService } from '../../services/app.service';

@Component({
    templateUrl: 'app/components/profile/profile.component.html'
})
export class Profile {
    getProfileSubscription: Subscription;
    saveProfileSubscription: Subscription;
    profile: {} = {};
    // firstName: string;
    // lastName: string;
    // phone: string;
    // birthday: string;
    // mailingAddress1: string;
    // mailingAddress2: string;
    // mailingCity: string;
    // mailingState: string;
    // mailingZip: string;
    // id: number;
    //email: string;
    constructor(private appService: AppService) {
        this.getProfileSubscription = appService.filterOn('get:user:profile')
            .subscribe(d => {
                if (d.data.error) {
                    console.log(d.data.error);
                } else {
                    let profileArray = JSON.parse(d.data).Table;
                    if (profileArray.length > 0) {
                        this.profile = profileArray[0];
                    }
                }
            }, err => {
                console.log(err);
            });

        this.saveProfileSubscription = appService.filterOn('post:save:profile')
            .subscribe(d => {
                console.log(d);
            });
    };
    ngOnInit() {
        let token = this.appService.getToken();
        this.appService.httpGet('get:user:profile', { token: token });
    };
    submit() {
        let token = this.appService.getToken();
        this.appService.httpPost('post:save:profile', { token: token, profile: this.profile });
    }
    ngOnDestroy() {
        this.getProfileSubscription.unsubscribe();
        this.saveProfileSubscription.unsubscribe();
    };
}