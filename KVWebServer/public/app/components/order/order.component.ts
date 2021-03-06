import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { Subscription } from 'rxjs/Subscription';
//import { CustomValidators } from '../../services/customValidators';
import { ControlMessages } from '../controlMessages/controlMessages.component';
import { AppService } from '../../services/app.service';
import { AlertModule } from 'ng2-bootstrap/components/alert';

@Component({
  templateUrl: 'app/components/order/order.component.html'
})
export class Order {
  alert: any = {
    show: false,
    type: 'danger',
    message: ''
  };
  onlineOrder: any = {};
  excessOrder: string = this.appService.getValidationErrorMessage('excessOrder');
  email: string;
  staticTexts: {
    introText: string,
    holidayGift: string,
    minimumRequest: string,
    bottomNotes: string
  } = {
    introText: this.appService.getMessage('mess:order:intro:text'),
    holidayGift: this.appService.getMessage('mess:order:holiday:gift'),
    minimumRequest: this.appService.getMessage('mess:order:minimum:request'),
    bottomNotes: this.appService.getMessage('mess:order:bottom:notes')
  };
  currentOfferSubscription: Subscription;
  saveOrderSubscription: Subscription;
  onlineOrderSubscription: Subscription;
  orders: any[];
  isValidOnlineOrder() {
    let isValid = false;
    if (this.onlineOrder) {
      if (Object.keys(this.onlineOrder).length != 0) {
        if (!this.onlineOrder.disableOnlineOrderForm) {
          isValid = true;
        }
      }
    }
    return (isValid);
  };

  disableOnlineOrderText() {
    let disableInlineOrderText = '';
    if (this.onlineOrder) {
      disableInlineOrderText = this.onlineOrder.disableOnlineOrderText;
    }
    return (disableInlineOrderText);
  };

  constructor(private appService: AppService, private router: Router) {
    // this.onlineOrder = appService.getSetting('onlineOrder');
    this.currentOfferSubscription = appService.filterOn('get:current:offer')
      .subscribe(d => {
        if (d.data.error) {
          console.log(d.data.error);
        } else {
          this.orders = JSON.parse(d.data).Table.map(function (value, i) {
            value.orderQty = 0;
            value.wishList = 0;
            value.imageUrl = 'app/assets/img/' + value.imageUrl;
            return (value);
          });
        }
      });
    this.saveOrderSubscription = appService.filterOn('post:save:order')
      .subscribe(d => {
        if (d.data.error) {
          console.log(d.data.error);
        } else {
          console.log(d);
        }
      });
    this.onlineOrderSubscription = appService.behFilterOn('settings:download:success').subscribe(d => {
      this.onlineOrder = appService.getSetting('onlineOrder');
    });
  };
  toggleDetails(order) {
    if (order.isShowDetails) {
      order.isShowDetails = false;
    } else {
      this.orders.map((a) => {
        a.isShowDetails = false;
      });
      order.isShowDetails = true;
    }
  };
  request() {
    let ords = this.orders.filter((a) => {
      return ((a.orderQty && a.orderQty > 0) || (a.wishList && a.wishList > 0));
    });
    let negativeValue = this.orders.find((order, index) => {
      return ((order.orderQty < 0) || (order.wishList < 0));
    });
    let index = this.orders.findIndex(a => a.orderQty > a.availableQty);
    if (negativeValue) {
      this.alert.show = true;
      this.alert.message = this.appService.getValidationErrorMessage('someNegativeValues');
    } else {
      if (index != -1) {
        this.alert.show = true;
        this.alert.message = this.appService.getValidationErrorMessage('someExcessOrder');
      } else {
        if (ords.length > 0) {
          this.alert.show = false;
          this.alert.message = '';
          this.appService.reply('orders', this.orders);
          this.router.navigate(['approve/order']);
        } else {
          this.alert.show = true;
          this.alert.message = this.appService.getValidationErrorMessage('emptyOrder');
        }
      }
    }
  }
  ngOnInit() {
    let ords = this.appService.request('orders');
    if (ords) {
      this.orders = ords;
    } else {
      this.appService.httpGet('get:current:offer');
    }
  };
  ngOnDestroy() {
    this.currentOfferSubscription.unsubscribe();
    this.saveOrderSubscription.unsubscribe();
    this.onlineOrderSubscription.unsubscribe();
  }
}