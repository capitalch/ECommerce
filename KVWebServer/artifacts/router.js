"use strict";
var handler = require('./handler');
var express = require('express');
var router = express.Router();
var config, def, messages, data;
var jwt = require('jsonwebtoken');
var crypto = require('crypto');
// var requestIp = require('request-ip');
var ipaddr = require('ipaddr.js');
//var lodash = require('lodash');
router.init = function (app) {
    config = app.get('config');
    def = app.get('def');
    messages = app.get('messages');
    data = { action: 'init', conn: config.connString.replace('@dbName', config.dbName) }
    handler.init(app, data);
}
// router.get('/newuser', function (req, res, next) {
//     if (config.failOver) {
//         let code = req.query.code;
//         let offerId = req.query.offerId;
//         let failOverUrl = config.failOverUrl
//             .replace('@code', code)
//             .replace('@offerId', offerId);
//         res.redirect(failOverUrl);
//     } else {
//         next();
//     }
// });

router.post('/api/validate/token', function (req, res, next) {
    try {
        var ret = false;
        var token = req.body.token || req.query.token || req.headers['x-access-token'];
        if (token) {
            jwt.verify(token, config.jwtKey, function (error, decoded) {
                if (!error) {
                    ret = true;
                }
                res.status(200).send(ret);
            });
        } else {
            let err = new def.NError(400, messages.errTokenNotFound, messages.messTokenNotFound);
            next(err);
        }
    } catch (error) {
        let err = new def.NError(500, messages.errInternalServerError, error.message);
        next(err);
    }
});

router.get('/api/init/data', function (req, res, next) {
    let data = { kistler: config.homePageUrl, host: config.host, action: 'sql:query', sqlKey: 'GetLoginPageText', sqlParms: {} };
    handler.edgePush(res, next, 'common:result:data:carry:source', data);
    // let initData = { kistler: config.homePageUrl, host: config.host };
    // res.status(200).json(initData);
});

router.get('/api/all/master', function (req, res, next) {
    try {
        let data = { action: 'sql:query', sqlKey: 'GetAllMasters', sqlParms: {} };
        handler.edgePush(res, next, 'common:result:data', data);
    } catch (error) {
        let err = new def.NError(500, messages.errInternalServerError, error.message);
        next(err);
    }
});

//authenticate
router.post('/api/authenticate', function (req, res, next) {
    try {
        let auth = req.body.auth;
        let err;

        if (auth) {
            let clientIp = handler.getClientIp(req);
            let remoteIp = ipaddr.process(clientIp).toString();
            var data = { action: 'authenticate', auth: auth, remoteIp: remoteIp };
            handler.edgePush(res, next, 'authenticate', data);
        }
        else {
            let err = new def.NError(404, messages.errAuthStringNotFound, messages.messAuthStringinPostRequest);
            next(err);
        }
    } catch (error) {
        let err = new def.NError(500, messages.errInternalServerError, error.message);
        next(err);
    }
});

router.post('/api/send/password', function (req, res, next) {
    try {
        let auth = req.body.auth;
        if (auth) {
            jwt.verify(auth, config.jwtKey, function (error, decoded) {
                if (error) {
                    res.status(406).send(false);
                } else {

                    //let random = crypto.randomBytes(4).toString('hex');
                    let url = `<a href='${config.host}'>${config.host}</a>`;
                    let htmlBody = config.sendPassword.mailBody.replace('@url', url);
                    let emailItem = config.sendMail;
                    emailItem.htmlBody = htmlBody;
                    emailItem.subject = config.forgotPassword.subject;
                    emailItem.to = decoded.data;
                    var data = { action: 'new:password', data: emailItem, };
                    handler.edgePush(res, next, 'common:result:no:data', data);

                    // let random = crypto.randomBytes(4).toString('hex');
                    // let url = `<a href='${config.host}'>${config.host}</a>`;
                    // let htmlBody = config.sendPassword.mailBody.replace('@pwd', random).replace('@url', url);
                    // let emailItem = config.sendMail;
                    // emailItem.htmlBody = htmlBody;
                    // emailItem.subject = config.forgotPassword.subject;
                    // emailItem.to = decoded.data;
                    // handler.sendMail(res, next, emailItem);
                }
            });
        } else {
            res.status(404).send(false);
        }
    } catch (error) {
        let err = new def.NError(500, messages.errInternalServerError, error.message);
        next(err);
    }
});

//forgot password
router.post('/api/forgot/password', function (req, res, next) {
    try {
        let auth = req.body.auth;
        if (auth) {
            let data = { action: 'get:code:and:mail', auth: auth };
            handler.edgePush(res, next, 'forgot:passowrd', data);
            //let email = Buffer.from(auth, 'base64').toString();
            //var data = { action: 'isEmailExist', email: email };
            //verify email if it exists and then send url to the verified mail
            //handler.edgePush(res, next, 'forgot:passowrd', data);
        } else {
            let err = new def.NError(404, messages.errAuthStringNotFound, messages.messAuthStringinPostRequest);
            next(err);
        }
    } catch (error) {
        let err = new def.NError(500, messages.errInternalServerError, error.message);
        next(err);
    }
});

//verify code / offerId for new user
router.post('/api/newuser/login', function (req, res, next) {
    try {
        let auth = req.body.auth;
        if (auth) {
            let codeOfferId = new Buffer(auth, 'base64').toString('ascii');
            let temp = codeOfferId.split(':');
            if (temp.length == 2) {
                let code = temp[0];
                let offerId = temp[1];
                let data = {
                    action: 'sql:scalar',
                    sqlKey: 'GetNewUserLogin',
                    sqlParms: {
                        code: code,
                        offerId: offerId
                    }
                };
                handler.edgePush(res, next, 'common:result:data', data)
            } else {
                let err = new def.NError(404, messages.errAuthStringNotFound, messages.messAuthStringinPostRequest);
                next(err);
            }
        }
        else {
            let err = new def.NError(404, messages.errAuthStringNotFound, messages.messAuthStringinPostRequest);
            next(err);
        }
    } catch (error) {
        let err = new def.NError(500, messages.errInternalServerError, error.message);
        next(err);
    }
});

router.post('/api/create/password', function (req, res, next) {
    try {
        let auth = req.body.auth;
        let encodedHash = req.body.encodedHash;
        if (auth && encodedHash) {
            jwt.verify(auth, config.jwtKey, function (error, decoded) {
                if (error) {
                    res.status(406).send(false);
                } else {
                    let body = config.createPassword.mailBody;
                    let emailItem = config.sendMail;
                    emailItem.htmlBody = body;
                    emailItem.subject = config.createPassword.subject;
                    emailItem.to = decoded.data.email;
                    var data = { action: 'create:password', data: { emailItem: emailItem, code: decoded.data.code, encodedHash: encodedHash } };
                    handler.edgePush(res, next, 'common:result:no:data', data);
                }
            });
        } else {
            res.status(404).send(false);
        }
    } catch (error) {
        let err = new def.NError(500, messages.errInternalServerError, error.message);
        next(err);
    }
});

router.post('/api/create/account', function (req, res, next) {
    try {
        let auth = req.body.auth;
        if (auth) {
            let data = { action: 'new:user', auth: auth };
            handler.edgePush(res, next, 'authenticate', data);
        } else {
            let err = new def.NError(404, messages.errAuthStringNotFound, messages.messAuthStringinPostRequest);
            next(err);
        }
    } catch (error) {
        let err = new def.NError(500, messages.errInternalServerError, error.message);
        next(err);
    }
});


router.all('/api*', function (req, res, next) {
    // implementation for token verification
    try {
        var token = req.body.token || req.query.token || req.headers['x-access-token'];
        if (token) {
            jwt.verify(token, config.jwtKey, function (error, decoded) {
                if (error) {
                    let err = new def.NError(401, messages.errInvalidToken, messages.messInvalidToken);
                    next(err);
                }
                else {
                    req.user = decoded;
                    next();
                }
            });
        }
        else {
            let err = new def.NError(400, messages.errTokenNotFound, messages.messTokenNotFound);
            next(err);
        }
    } catch (error) {
        let err = new def.NError(500, messages.errInternalServerError, error.message);
        next(err);
    }
});

//change password. auth is base64(email:hashOfOldPassword:hashOfNewPassword)
router.post('/api/change/password', function (req, res, next) {
    try {
        let auth = req.body.auth;
        if (auth) {
            let emailItem = config.sendMail;
            emailItem.htmlBody = config.changePassword.mailBody;
            emailItem.subject = config.changePassword.subject;
            var data = {
                action: 'change:password', auth: auth
                , emailItem: emailItem
            };
            handler.edgePush(res, next, 'common:result:no:data', data);
        } else {
            let err = new def.NError(404, messages.errAuthStringNotFound, messages.messAuthStringinPostRequest);
            next(err);
        }
    } catch (error) {
        let err = new def.NError(500, messages.errInternalServerError, error.message);
        next(err);
    }
});
router.get('/api/current/offer', function (req, res, next) {
    try {
        let data = { action: 'sql:query', sqlKey: 'GetCurrentOffer', sqlParms: {} };
        handler.edgePush(res, next, 'common:result:data', data);
    } catch (error) {
        let err = new def.NError(500, messages.errInternalServerError, error.message);
        next(err);
    }
});

router.get('/api/order/headers', function (req, res, next) {
    try {
        let data = { action: 'sql:query', sqlKey: 'GetOrderHeaders', sqlParms: { userId: req.user.userId } };
        handler.edgePush(res, next, 'common:result:data', data);
    } catch (error) {
        let err = new def.NError(500, messages.errInternalServerError, error.message);
        next(err);
    }
});

router.get('/api/order/details/:orderId', function (req, res, next) {
    try {
        let data = { action: 'sql:query', sqlKey: 'GetOrderDetails', sqlParms: { userId: req.user.userId, orderId: req.params.orderId } };
        handler.edgePush(res, next, 'common:result:data', data);
    } catch (error) {
        let err = new def.NError(500, messages.errInternalServerError, error.message);
        next(err);
    }
});


router.post('/api/order', function (req, res, next) {
    try {
        let data = { action: 'save:order', order: req.body.order, email: req.user.email };
        handler.edgePush(res, next, 'common:result:no:data', data);
    } catch (error) {
        let err = new def.NError(500, messages.errInternalServerError, error.message);
        next(err);
    }
});

router.get('/api/profile', function (req, res, next) {
    try {
        let data = { action: 'sql:query', sqlKey: 'GetProfile', sqlParms: { userId: req.user.userId } };
        handler.edgePush(res, next, 'common:result:data', data);
    } catch (error) {
        let err = new def.NError(500, messages.errInternalServerError, error.message);
        next(err);
    }
});

router.post('/api/profile', function (req, res, next) {
    try {
        let data = {
            action: 'update:insert:profile',
            profile: req.body.profile,
            userId: req.user.userId,
            isUpdate: req.body.profile.id ? true : false
        };
        handler.edgePush(res, next, 'common:result:no:data', data);
    } catch (error) {
        let err = new def.NError(500, messages.errInternalServerError, error.message);
        next(err);
    }
});

router.get('/api/shipping/address', function (req, res, next) {
    try {
        let data = { action: 'sql:query', sqlKey: 'GetAllShippingAddresses', sqlParms: { userId: req.user.userId } };
        handler.edgePush(res, next, 'common:result:data', data);
    } catch (error) {
        let err = new def.NError(500, messages.errInternalServerError, error.message);
        next(err);
    }
});

router.post('/api/shipping/address', function (req, res, next) {
    try {
        let data = {
            action: 'sql:scalar',
            sqlKey: 'InsertShippingAddress',
            sqlParms: {
                code: req.user.code,
                name: req.body.address.name,
                co: req.body.address.co,
                street1: req.body.address.street1,
                street2: req.body.address.street2,
                city: req.body.address.city,
                state: req.body.address.state,
                zip: req.body.address.zip,
                isDefault: req.body.address.isDefault,
                phone: req.body.address.phone,
                isoCode: req.body.address.isoCode,
                country: req.body.address.country,
                userId: req.user.userId,
                isAddressVerified: req.body.address.isAddressVerified
            }
        };
        handler.edgePush(res, next, 'common:result:data', data);
    } catch (error) {
        let err = new def.NError(500, messages.errInternalServerError, error.message);
        next(err);
    }
});

router.put('/api/shipping/address', function (req, res, next) {
    try {
        let data = {
            action: 'sql:non:query',
            sqlKey: 'UpdateShippingAddress',
            sqlParms: {
                id: req.body.address.id,
                code: req.user.code,
                name: req.body.address.name,
                co: req.body.address.co,
                street1: req.body.address.street1,
                street2: req.body.address.street2,
                city: req.body.address.city,
                state: req.body.address.state,
                zip: req.body.address.zip,
                isDefault: req.body.address.isDefault,
                phone: req.body.address.phone,
                isoCode: req.body.address.isoCode,
                country: req.body.address.country,
                userId: req.user.userId,
                isAddressVerified: req.body.address.isAddressVerified
            }
        };
        handler.edgePush(res, next, 'common:result:no:data', data);
    } catch (error) {
        let err = new def.NError(500, messages.errInternalServerError, error.message);
        next(err);
    }
});

router.get('/api/shipping/address/default', function (req, res, next) {
    try {
        let data = { action: 'sql:query', sqlKey: 'GetDefaultShippingAddress', sqlParms: { userId: req.user.userId } };
        handler.edgePush(res, next, 'common:result:data', data);
    } catch (error) {
        let err = new def.NError(500, messages.errInternalServerError, error.message);
        next(err);
    }
});

router.get('/api/credit/card', function (req, res, next) {
    try {
        let data = { action: 'sql:query', sqlKey: 'GetAllCreditCards', sqlParms: { userId: req.user.userId } };
        handler.edgePush(res, next, 'common:result:data', data);
    } catch (error) {
        let err = new def.NError(500, messages.errInternalServerError, error.message);
        next(err);
    }
});

router.post('/api/credit/card', function (req, res, next) {
    try {
        let data = {
            action: 'sql:scalar',
            sqlKey: 'InsertCreditCard',
            sqlParms: {
                cardName: req.body.card.cardName,
                cardNumber: req.body.card.cardNumber,
                expiryDate: req.body.card.expiryDate,
                userId: req.user.userId
            }
        };
        handler.edgePush(res, next, 'common:result:no:data', data);
    } catch (error) {
        let err = new def.NError(500, messages.errInternalServerError, error.message);
        next(err);
    }
});

router.delete('/api/credit/card', function (req, res, next) {
    try {
        let data = {
            action: 'sql:non:query',
            sqlKey: 'DeleteCreditCard',
            sqlParms: {
                id: req.body.id,
                email: req.user.email
            }
        };
        handler.edgePush(res, next, 'common:result:no:data', data);
    } catch (error) {
        let err = new def.NError(500, messages.errInternalServerError, error.message);
        next(err);
    }
});

router.get('/api/credit/card/default', function (req, res, next) {
    try {
        let data = { action: 'sql:query', sqlKey: 'GetDefaultCreditCard', sqlParms: { userId: req.user.userId } };
        handler.edgePush(res, next, 'common:result:data', data);
    } catch (error) {
        let err = new def.NError(500, messages.errInternalServerError, error.message);
        next(err);
    }
});

router.post('/api/credit/card/default', function (req, res, next) {
    try {
        let data = {
            action: 'sql:non:query',
            sqlKey: 'SetDefaultCreditCard',
            sqlParms: {
                cardId: req.body.id,
                userId: req.user.userId
            }
        };
        handler.edgePush(res, next, 'common:result:no:data', data);
    } catch (error) {
        let err = new def.NError(500, messages.errInternalServerError, error.message);
        next(err);
    }
});

router.get('/api/approve/artifact', function (req, res, next) {
    try {
        let data = { action: 'sql:query', sqlKey: 'GetApproveArtifacts', sqlParms: { userId: req.user.userId } };
        handler.edgePush(res, next, 'common:result:data', data);
    } catch (error) {
        let err = new def.NError(500, messages.errInternalServerError, error.message);
        next(err);
    }
});

router.post('/api/approve/request', function (req, res, next) {
    try {
        let orderBundle = req.body;
        orderBundle.orderMaster.userId = req.user.userId

        let emailItem = config.sendMail;
        emailItem.htmlBody = config.receipt.mailBody;
        emailItem.subject = config.receipt.subject;

        let data = {
            action: 'save:approve:request',
            orderBundle: orderBundle,
            userId: req.user.userId,
            emailItem: emailItem,
            email: req.user.email
        };
        handler.edgePush(res, next, 'common:result:no:data', data);
    } catch (error) {
        let err = new def.NError(500, messages.errInternalServerError, error.message);
        next(err);
    }
});
router.get('/api/generic/query', function (req, res, next) {
    try {
        let body = JSON.parse(req.headers['data']);
        let sqlKey = body.sqlKey;
        let sqlParms = body.sqlParms;
        if (!sqlParms) {
            sqlParms = {};
        }
        sqlParms.userId = req.user.userId;
        sqlParms.code = req.user.code;
        let data = { action: 'sql:query', sqlKey: sqlKey, sqlParms: sqlParms };
        handler.edgePush(res, next, 'common:result:data', data);
    } catch (error) {
        let err = new def.NError(500, messages.errInternalServerError, error.message);
        next(err);
    }
});

router.post('/api/generic/non/query', function (req, res, next) {
    try {
        let sqlKey = req.body.sqlKey;
        let sqlParms = req.body.sqlParms;
        sqlParms.userId = req.user.userId;
        let data = { action: 'sql:non:query', sqlKey: req.body.sqlKey, sqlParms: req.body.sqlParms };
        handler.edgePush(res, next, 'common:result:no:data', data);
    } catch (error) {
        let err = new def.NError(500, messages.errInternalServerError, error.message);
        next(err);
    }
});

router.post('/api/generic/scalar', function (req, res, next) {
    try {
        let sqlParms = req.body.sqlParms;
        sqlParms.userId = req.user.userId;
        //let sql = handler.insertSqlFromObject(req.body.tableName, req.body.sqlObject);
        let data = { action: 'sql:scalar', sqlKey: req.body.sqlKey, sqlParms: sqlParms };
        handler.edgePush(res, next, 'common:result:data', data);
    } catch (error) {
        let err = new def.NError(500, messages.errInternalServerError, error.message);
        next(err);
    }
});

module.exports = router;
