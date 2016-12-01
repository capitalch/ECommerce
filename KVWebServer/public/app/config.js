"use strict";
exports.urlHash = {
    'post:authenticate': '/api/authenticate',
    'post:validate:token': '/api/validate/token',
    'post:forgot:password': '/api/forgot/password',
    'post:send:password': '/api/send/password',
    'post:change:password': '/api/change/password',
    'post:create:account': '/api/create/account',
    'get:current:offer': '/api/current/offer',
    //'post:save:order': '/api/order',
    'get:user:profile': '/api/profile',
    'post:save:profile': '/api/profile',
    'get:order:headers': '/api/order/headers',
    'get:order:details': '/api/order/details/:id',
    'get:shipping:address': '/api/shipping/address',
    'post:shipping:address': '/api/shipping/address',
    'put:shipping:address': '/api/shipping/address',
    'get:credit:card': '/api/credit/card',
    'delete:credit:card': '/api/credit/card',
    'insert:credit:card': '/api/credit/card',
    'set:default:card': '/api/credit/card/default',
    'get:default:shipping:address': '/api/shipping/address/default',
    // 'get:all:shipping:addresses': '/api/shipping/address',
    'get:default:credit:card': '/api/credit/card/default',
    'get:all:credit:cards': '/api/credit/card',
    'get:approve:artifacts': '/api/approve/artifact',
    'post:save:approve:request': '/api/approve/request',
    'get:init:data': '/api/init/data'
};
exports.messages = {
    'mess:order:intro:text': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed a tortor imperdiet, porttitor purus ut, pretium diam. Nulla convallis vel ipsum quis mattis. Nam in erat massa. Praesent bibendum dapibus lectus, nec imperdiet eros pharetra et. Vestibulum euismod velit sit amet nulla ornare iaculis viverra eget augue. Etiam dolor lacus, rhoncus in rhoncus eget, faucibus at nisi. Nulla nec mollis orci. Pellentesque pharetra facilisis dolor vel tincidunt. Suspendisse ullamcorper fermentum nunc, a dapibus tellus imperdiet vitae.',
    'mess:order:holiday:gift': 'Holiday Gift - Yes I\'m interested, please contact me',
    'mess:order:minimum:request': 'Minimum request 6 bottles',
    'mess:order:bottom:notes': 'Wines in 6 bottle packages are subject to change',
    'mess:approve:heading': 'Please review your shipping address & payment method information for your order.',
    'mess:receipt:heading': 'Thank you for your Kistler Fall 2016 Request.',
    'mess:receipt:info': 'An acknowledgement email has been sent to @email. If you do not receive the email within 10 minutes, please check your Spam / Junk mail folder. Otherwise, contact us for assistance. '
};
exports.validationErrorMessages = {
    'required': 'Value is required',
    'invalidEmail': 'Email address is invalid',
    'invalidUSPhone': 'Phone number is invalid',
    'loginFailed': 'Login failed',
    'emptyOrder': 'Empty order is not allowed',
    'excessOrder': 'Request exceeds available quantity',
    'someExcessOrder': 'One or many of the requests exceeds available quantity',
    'changePasswordFailed': 'Change of password failed',
    'oldAndNewPasswordsSame': 'Old and new passwords cannot be same',
    'confirmPasswordMismatch': 'New Password and Confirm New Password mismatch',
    'invalidCreditCard': 'Credit card is invalid',
    'addressSaveFailed': 'Saving of shipping address at server failed',
    'dataSaved': 'Data successfully saved'
};
exports.viewBoxConfig = {
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
    '/approve/order': { home: true, needHelp: true, order: false, myAccount: true, menuBar: false, logout: true }
};
//# sourceMappingURL=config.js.map