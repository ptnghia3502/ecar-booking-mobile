import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';

class PaypalCheckoutService {
  static Future<bool> initiatePaypalCheckout(
    BuildContext context, {
    required bool sandboxMode,
    required String clientId,
    required String secretKey,
    required String returnURL,
    required String cancelURL,
    required String itemName,
    required int itemQuantity,
    required double itemPrice,
  }) async {
    Completer<bool> completer = Completer<bool>();

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => PaypalCheckout(
          sandboxMode: sandboxMode,
          clientId: clientId,
          secretKey: secretKey,
          returnURL: returnURL,
          cancelURL: cancelURL,
          transactions: [
            {
              "amount": {
                "total": (itemQuantity * itemPrice).toString(),
                "currency": "USD",
                "details": {
                  "subtotal": (itemQuantity * itemPrice).toString(),
                  "shipping": '0',
                  "shipping_discount": 0,
                }
              },
              "description": "Payment for $itemName",
              "item_list": {
                "items": [
                  {
                    "name": itemName,
                    "quantity": itemQuantity,
                    "price": itemPrice.toString(),
                    "currency": "USD"
                  },
                ],
              }
            }
          ],
          note: "Contact us for any questions on your order.",
          onSuccess: (Map params) async {
            print("onSuccess: $params");
            completer.complete(true); // Resolve the completer with success
          },
          onError: (error) {
            print("onError: $error");
            completer.complete(false); // Resolve the completer with failure
            Navigator.pop(context);
          },
          onCancel: () {
            print('cancelled:');
            completer.complete(false); // Resolve the completer with failure
          },
        ),
      ),
    );

    return completer.future; // Return the future to await the result
  }
}
