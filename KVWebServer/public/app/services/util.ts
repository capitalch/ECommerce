import { AppService } from './app.service';
import * as moment from 'moment';
export class Util {
    constructor(private appService: AppService) {

    };

    static isValidExpiryMonthYear(month: number, year: number) {            
        let mDate = moment(new Date(year, month - 1, 1));
        let today = moment(new Date());
        today = today.clone().set('date',1);
        let isValid = (mDate.isSame(today,'day') || mDate.isAfter(today,'day')) && mDate.isBefore(today.clone().add(8, 'years'),'day');        
        return (isValid);
    }

    static convertToUSDate(inStr) {
        let ret = null;
        if (inStr) {
            let date = moment(inStr);
            if (date.isValid()) {
                ret = date.format('MM/DD/YYYY');
            }
        }
        return (ret);
    };

    //date object to iso date
    static getISODate(d) {
        let date = moment(d, 'MM/DD/YYYY');
        let ret = null;
        if (date.isValid()) {
            ret = date.format('YYYY-MM-DD');
        }
        return (ret);
    };

    static getMaskedCCNumber(ccNumber) {
        ccNumber = ccNumber.substring(0, 4) + ' XXXX XXXX ' + ccNumber.substr(ccNumber.length - 4, 4)
        return (ccNumber);
    };
}