"use strict";
var moment = require("moment");
var Util = (function () {
    function Util(appService) {
        this.appService = appService;
    }
    ;
    Util.isValidExpiryMonthYear = function (month, year) {
        var mDate = moment(new Date(year, month - 1, 1));
        var today = moment(new Date());
        today = today.clone().set('date', 1);
        var isValid = (mDate.isSame(today, 'day') || mDate.isAfter(today, 'day')) && mDate.isBefore(today.clone().add(8, 'years'), 'day');
        return (isValid);
    };
    Util.convertToUSDate = function (inStr) {
        var ret = null;
        if (inStr) {
            var date = moment(inStr);
            if (date.isValid()) {
                ret = date.format('MM/DD/YYYY');
            }
        }
        return (ret);
    };
    ;
    //date object to iso date
    Util.getISODate = function (d) {
        var date = moment(d, 'MM/DD/YYYY');
        var ret = null;
        if (date.isValid()) {
            ret = date.format('YYYY-MM-DD');
        }
        return (ret);
    };
    ;
    Util.getMaskedCCNumber = function (ccNumber) {
        ccNumber = ccNumber.substring(0, 4) + ' XXXX XXXX ' + ccNumber.substr(ccNumber.length - 4, 4);
        return (ccNumber);
    };
    ;
    return Util;
}());
exports.Util = Util;
//# sourceMappingURL=util.js.map