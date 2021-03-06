export var urlHash = {
    'post:authenticate': '/api/authenticate',
    'post:validate:token': '/api/validate/token',
    'post:forgot:password': '/api/forgot/password',
    'post:send:password': '/api/send/password',
    'post:change:password': '/api/change/password',
    'post:create:password': '/api/create/password',
    'post:create:account': '/api/create/account',
    'post:save:profile': '/api/profile',
    'post:shipping:address': '/api/shipping/address',
    'post:save:approve:request': '/api/approve/request',
    'post:payment:method': '/api/generic/scalar',
    'post:delete:payment:method': '/api/generic/non/query',
    'post:delete:shipping:address': '/api/generic/non/query',
    'post:set:default:payment:method': '/api/generic/non/query',
    'post:new:user:login': '/api/newuser/login',
    'post:order:change:shipping:address': '/api/generic/scalar',
    'post:order:change:payment:method': '/api/generic/scalar',

    'get:current:offer': '/api/current/offer',
    'get:user:profile': '/api/profile',
    'get:order:headers': '/api/order/headers',
    'get:order:details': '/api/order/details/:id',
    'get:shipping:address': '/api/shipping/address',
    'get:credit:card': '/api/credit/card',
    'get:default:shipping:address': '/api/shipping/address/default',
    'get:default:credit:card': '/api/credit/card/default',
    'get:approve:artifacts': '/api/approve/artifact',
    'get:init:data': '/api/init/data',
    'get:all:masters': '/api/all/master',
    'get:shipping:sales:tax:perc': '/api/generic/query',
    'get:payment:method': '/api/generic/query',
    'get:all:settings': '/api/generic/query',
    'get:default:billing:address': '/api/generic/query',
    'get:smartyStreet': 'https://us-street.api.smartystreets.com/street-address?auth-id=:authId&auth-token=:authToken&street=:street&street2=:street2&city=:city&state=:state&zipcode=:zipcode&',
    'smartyStreetAutoCom': 'https://us-autocomplete.api.smartystreets.com/suggest?auth-id=63395b2b-4df2-c8c7-a487-21ecc25979c8&auth-token=ikDR4hndQSAScpWSPdj8&prefix=Wyomi'

    , 'put:shipping:address': '/api/shipping/address'    
    , 'insert:credit:card': '/api/credit/card'
    , 'set:default:card': '/api/credit/card/default'
    , 'delete:credit:card': '/api/credit/card'

};
export var messages = {
    'mess:order:intro:text': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed a tortor imperdiet, porttitor purus ut, pretium diam. Nulla convallis vel ipsum quis mattis. Nam in erat massa. Praesent bibendum dapibus lectus, nec imperdiet eros pharetra et. Vestibulum euismod velit sit amet nulla ornare iaculis viverra eget augue. Etiam dolor lacus, rhoncus in rhoncus eget, faucibus at nisi. Nulla nec mollis orci. Pellentesque pharetra facilisis dolor vel tincidunt. Suspendisse ullamcorper fermentum nunc, a dapibus tellus imperdiet vitae.',
    'mess:order:holiday:gift': 'Holiday Gift - Yes I\'m interested, please contact me',
    'mess:order:minimum:request': 'Minimum request 6 bottles',
    'mess:order:bottom:notes': 'Wines in 6 bottle packages are subject to change',
    'mess:approve:heading': 'Please review your shipping address & payment method information for your order.',
    'mess:receipt:heading': 'Thank you for your Kistler Fall 2016 Request.',
    'mess:receipt:info': 'An acknowledgement email has been sent to @email. If you do not receive the email within 10 minutes, please check your Spam / Junk mail folder. Otherwise, contact us for assistance. ',
    'mess:confirm:save:invalid:address': 'This address could not be verified. Do you still want to proceed with this unverified address? ',
    'mess:confirm:save:edited:address': 'This address has been verified by US Postal Service but some minor changes are required. \nPlease confirm you accept the revised address below: \n\n'
};
export var validationErrorMessages = {
    'required': 'Value is required',
    'invalidEmail': 'Email address is invalid',
    'invalidPhone': 'Phone number is invalid',
    'loginFailed': 'Login failed',
    'emptyOrder': 'Empty order is not allowed',
    'excessOrder': 'Request exceeds available quantity',
    'someExcessOrder': 'One or many of the requests exceeds available quantity',
    'changePasswordFailed': 'Change of password failed',
    'oldAndNewPasswordsSame': 'Old and new passwords cannot be same',
    'confirmPasswordMismatch': 'New Password and Confirm New Password mismatch',
    'invalidCreditCard': 'Credit card is invalid',
    'addressSaveFailed': 'Saving of address at server failed',
    'dataSaved': 'Data successfully saved',
    'invalidDate': 'Date is invalid',
    'dataNotSaved': 'Data could not be saved',
    'createPasswordFailed': 'Creation of new password failed',
    'changePasswordSuccess': 'Password successfully changed',
    'payMethodInsertFailed': 'Payment method insert failed',
    'addressValidationUnauthorized': 'Authorization error while validating address.',
    'invalidAddress': 'This address is invalid',
    'invalidZipCode': 'This zip code is not a US legal zip code',
    'addressDeleteFailed': 'Address could not be removed due to server side error',
    'someNegativeValues': 'Some values in your request or wish list are negative which is not allowed',
    'pwdLengthLt8': 'Password must have at least 8 characters',
    'invalidPwd': 'Password must satisfy at least three out of following four criterias: 1) Lower case, 2) Upper case, 3) Number, 4)  Special character like “!@#$%^&*()',
    'invalidExpiryYear':'Expiry year of card is not valid',
    'invalidExpiryMonthYear':'Expiry month and expiry year combination of the card is not valid',
    'invalidForm':'Data in the form is invalid'
};
export var viewBoxConfig = {
    '/login': { home: true, needHelp: false, order: false, myAccount: false, menuBar: false, logout: false },
    '/order': { home: true, needHelp: true, order: false, myAccount: true, menuBar: false, logout: true },
    '/approve': { home: true, needHelp: true, order: false, myAccount: true, menuBar: false, logout: true },
    '/receipt': { home: true, needHelp: true, order: false, myAccount: true, menuBar: false, logout: true },
    '/profile': { home: true, needHelp: false, order: true, myAccount: false, menuBar: true, logout: true },
    '/order/history': { home: true, needHelp: false, order: true, myAccount: false, menuBar: true, logout: true },
    '/shipping/address': { home: true, needHelp: false, order: true, myAccount: false, menuBar: true, logout: true },
    '/payment/method': { home: true, needHelp: false, order: true, myAccount: false, menuBar: true, logout: true },
    '/change/password': { home: true, needHelp: false, order: true, myAccount: false, menuBar: true, logout: true },
    '/create/account': { home: true, needHelp: false, order: false, myAccount: false, menuBar: false, logout: true },
    '/forgot/password': { home: true, needHelp: false, order: false, myAccount: false, menuBar: false, logout: true },
    '/send/password': { home: true, needHelp: false, order: false, myAccount: false, menuBar: false, logout: true },
    '/approve/order': { home: true, needHelp: true, order: false, myAccount: true, menuBar: false, logout: true },
    '/create/password': { home: true, needHelp: false, order: false, myAccount: false, menuBar: false, logout: false },
    '/newuser': { home: true, needHelp: false, order: false, myAccount: false, menuBar: false, logout: false },
};
export var uiText = {
    otherOptions: 'Payment by check, money order or wire transfer. Once your order is finalized, we will send you an order confirmation with payment instructions.'
}