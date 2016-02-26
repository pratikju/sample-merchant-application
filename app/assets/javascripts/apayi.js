(function() {
var $, apayi, PaymentMode, Card, createModeObject;

$ = jQuery;
$.apayi = {};

$.apayi.endpoints = {
  local: 'http://localhost:3000',
  dev: 'http://dev.apayi.in',
  production: 'http://localhost:3000'
};

PaymentMode = (function(){

  function PaymentMode(mode) {
    this.mode = mode;
  }

  return PaymentMode;
})();

Card = (function(){
    var expiry_data;
    function Card(options) {
        PaymentMode.call(this, options.mode);
        this.options = options;
        this.expiry_data = $.payment.cardExpiryVal(this.options.expiry);
    }

    Card.prototype = Object.create(PaymentMode.prototype);

    Card.prototype.expiry = function () {
        var month;
        month = this.expiry_data.month.toString();
        return ('0' + month).slice(month.length - 1) + '/' + this.expiry_data.year.toString();
    };

    Card.prototype.brand = function () {
        return $.payment.cardType(this.options.card_number).toUpperCase();
    };

    Card.prototype.validate = function () {
      if (!$.payment.validateCardNumber(this.options.card_number)) {
        throw new Error('invalid_card_number');
      }
      if (!$.payment.validateCardExpiry(this.expiry_data.month, this.expiry_data.year)) {
        throw new Error('invalid_card_expiry');
      }
      if (!($.payment.cardType(this.options.card_number) === 'maestro' || $.payment.validateCardCVC(this.options.cvv_2))) {
        throw new Error('invalid_card_cvv');
      }
      return true;
    };

    Card.prototype.paymentOptions = function () {
        paymentOptions = this.options;
        paymentOptions.expiry = this.expiry();
        paymentOptions.card_brand = this.brand();
        return paymentOptions;
    };

    return Card;
})();

Gateway = (function() {
    function Gateway(endpoint) {
        this.endpoint = endpoint;
    }

    Gateway.prototype.makePayment = function (signatures, orderDetails, paymentDetails, callback) {
        var modeObj, paymentObj;
        if (!callback || callback.constructor !== Function) {
            throw new Error("Callback function is not defined");
        }

        try {
            modeObj = createModeObject(paymentDetails);
            modeObj.validate();

            paymentObj = {};
            paymentObj.merchantSignature = signatures.merchantSignature;
            paymentObj.requestSignature = signatures.requestSignature;
            paymentObj.header = signatures.header;
            paymentObj.orderDetails = orderDetails;
            paymentObj.paymentDetails = modeObj.paymentOptions();
            return this.makeRequest(paymentObj, callback)
        } catch (err) {
            return callback(err);
        }

    };

    Gateway.prototype.makeRequest = function (payment, callback) {
        var headerMap, response, err;
        headerMap = {
            "Content-Type": 'application/x-www-form-urlencoded',
            "Authorization": "APIAuth " + payment.merchantSignature,
            "TIMESTAMP": payment.header.timestamp
        };
        $.ajax({
            url: this.endpoint + '/api/v1/checkout/createPayment.json',
            type: "POST",
            data: payment,
            headers: headerMap,
            success: function (res) {
                response = JSON.stringify(res);
                return callback(err, response);
            },
            error: function (e) {
                switch (e.status) {
                  case 400:
                    err = JSON.stringify(e.responseJSON);
                    break;
                  case 401:
                  case 500:
                    err = e.status.toString() + ' ' + e.statusText;
                    break;
                  default:
                    err = new Error('unexpected error')
                    break;
                }
                return callback(err);
            }
        });

    };

    return Gateway;
})();

// Add other modes here
createModeObject = function(paymentDetails) {
    switch (paymentDetails.mode) {
      case 'card':
        return new Card(paymentDetails);
      default:
        throw new Error('invalid_payment_mode');
    }
};

$.apayi.gateway = function(endpoint) {
    if (endpoint === undefined) {
        endpoint = $.apayi.endpoints.production;
    }
    return new Gateway(endpoint);
};

}).call(this);
