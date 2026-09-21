import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';

import 'package:http/http.dart' as http;

@JS('startRazorpayCheckout')
external void startRazorpayCheckout(
    JSAny options,
    JSFunction onSuccess,
    JSFunction onFailure,
    );

class PaymentResult {
  final bool success;
  final String message;

  final String? razorpayOrderId;
  final String? razorpayPaymentId;
  final String? razorpaySignature;

  const PaymentResult({
    required this.success,
    required this.message,
    this.razorpayOrderId,
    this.razorpayPaymentId,
    this.razorpaySignature,
  });
}

class PaymentService {
  PaymentService._();

  static final PaymentService instance =
  PaymentService._();

  static const String baseUrl =
      "http://localhost:3000";

  // ============================================================
  // START PAYMENT
  // ============================================================

  Future<PaymentResult> startPayment({
    required double amount,
    required String customerName,
    required String customerEmail,
  }) async {
    try {
      if (amount <= 0) {
        return const PaymentResult(
          success: false,
          message: "Invalid payment amount.",
        );
      }

      final String receipt =
          "PC-${DateTime.now().millisecondsSinceEpoch}";

      // --------------------------------------------------------
      // 1. CREATE RAZORPAY ORDER
      // --------------------------------------------------------

      final response = await http.post(
        Uri.parse(
          "$baseUrl/api/payment/create-order",
        ),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "amount": amount,
          "receipt": receipt,
          "customerName": customerName,
          "customerEmail": customerEmail,
        }),
      );

      if (response.statusCode != 200) {
        return PaymentResult(
          success: false,
          message:
          "Unable to create payment order.\n"
              "HTTP ${response.statusCode}",
        );
      }

      final dynamic data =
      jsonDecode(response.body);

      if (data is! Map<String, dynamic>) {
        return const PaymentResult(
          success: false,
          message:
          "Invalid response from payment server.",
        );
      }

      if (data["success"] != true) {
        return PaymentResult(
          success: false,
          message:
          data["message"]?.toString() ??
              "Unable to create payment order.",
        );
      }

      final String? orderId =
      data["orderId"]?.toString();

      final String? keyId =
      data["keyId"]?.toString();

      if (orderId == null || orderId.isEmpty) {
        return const PaymentResult(
          success: false,
          message:
          "Razorpay order ID is missing.",
        );
      }

      if (keyId == null || keyId.isEmpty) {
        return const PaymentResult(
          success: false,
          message:
          "Razorpay key ID is missing.",
        );
      }

      final dynamic responseAmount =
      data["amount"];

      final int amountInPaise =
      responseAmount is num
          ? responseAmount.toInt()
          : (amount * 100).round();

      // --------------------------------------------------------
      // 2. OPEN RAZORPAY CHECKOUT
      // --------------------------------------------------------

      return await _openCheckout(
        keyId: keyId,
        orderId: orderId,
        amountInPaise: amountInPaise,
        customerName: customerName,
        customerEmail: customerEmail,
      );
    } catch (e) {
      return PaymentResult(
        success: false,
        message:
        "Payment initialization failed: $e",
      );
    }
  }

  // ============================================================
  // OPEN RAZORPAY CHECKOUT
  // ============================================================

  Future<PaymentResult> _openCheckout({
    required String keyId,
    required String orderId,
    required int amountInPaise,
    required String customerName,
    required String customerEmail,
  }) async {
    final Completer<PaymentResult> completer =
    Completer<PaymentResult>();

    // ----------------------------------------------------------
    // SUCCESS CALLBACK
    // ----------------------------------------------------------

    void onSuccess(JSAny? response) async {
      try {
        print("Razorpay payment success");

        final dynamic data =
        response?.dartify();

        if (data is! Map) {
          if (!completer.isCompleted) {
            completer.complete(
              const PaymentResult(
                success: false,
                message:
                "Invalid Razorpay response.",
              ),
            );
          }

          return;
        }

        final String? paymentId =
        data["razorpay_payment_id"]
            ?.toString();

        final String? returnedOrderId =
        data["razorpay_order_id"]
            ?.toString();

        final String? signature =
        data["razorpay_signature"]
            ?.toString();

        if (paymentId == null ||
            returnedOrderId == null ||
            signature == null) {
          if (!completer.isCompleted) {
            completer.complete(
              const PaymentResult(
                success: false,
                message:
                "Incomplete Razorpay payment response.",
              ),
            );
          }

          return;
        }

        // ------------------------------------------------------
        // VERIFY PAYMENT ON BACKEND
        // ------------------------------------------------------

        final PaymentResult result =
        await verifyPayment(
          razorpayOrderId: returnedOrderId,
          razorpayPaymentId: paymentId,
          razorpaySignature: signature,
        );

        if (!completer.isCompleted) {
          completer.complete(result);
        }
      } catch (e) {
        if (!completer.isCompleted) {
          completer.complete(
            PaymentResult(
              success: false,
              message:
              "Payment verification error: $e",
            ),
          );
        }
      }
    }

    // ----------------------------------------------------------
    // FAILURE CALLBACK
    // ----------------------------------------------------------

    void onFailure(JSAny? response) {
      String message = "Payment failed.";

      try {
        final dynamic data =
        response?.dartify();

        if (data is Map) {
          final dynamic errorMessage =
          data["message"];

          if (errorMessage != null) {
            message = errorMessage.toString();
          }
        }
      } catch (_) {}

      if (!completer.isCompleted) {
        completer.complete(
          PaymentResult(
            success: false,
            message: message,
          ),
        );
      }
    }

    // ----------------------------------------------------------
    // RAZORPAY OPTIONS
    // ----------------------------------------------------------

    final Map<String, dynamic> options = {
      "key": keyId,

      "amount": amountInPaise,

      "currency": "INR",

      "name": "PharmaCare",

      "description":
      "Medicine Order Payment",

      "order_id": orderId,

      "prefill": {
        "name": customerName,
        "email": customerEmail,
      },

      "theme": {
        "color": "#008F83",
      },

      "modal": {
        "confirm_close": true,

        "ondismiss": () {
          if (!completer.isCompleted) {
            completer.complete(
              const PaymentResult(
                success: false,
                message:
                "Payment window was closed.",
              ),
            );
          }
        }.toJS,
      },
    };

    // ----------------------------------------------------------
    // CONVERT DART MAP TO JAVASCRIPT OBJECT
    // ----------------------------------------------------------

    final JSAny jsOptions =
    options.jsify()!;

    // ----------------------------------------------------------
    // CALL JAVASCRIPT BRIDGE
    // ----------------------------------------------------------

    startRazorpayCheckout(
      jsOptions,
      onSuccess.toJS,
      onFailure.toJS,
    );

    return completer.future;
  }

  // ============================================================
  // VERIFY PAYMENT
  // ============================================================

  Future<PaymentResult> verifyPayment({
    required String razorpayOrderId,
    required String razorpayPaymentId,
    required String razorpaySignature,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(
          "$baseUrl/api/payment/verify",
        ),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "razorpayOrderId":
          razorpayOrderId,

          "razorpayPaymentId":
          razorpayPaymentId,

          "razorpaySignature":
          razorpaySignature,
        }),
      );

      if (response.statusCode != 200) {
        return PaymentResult(
          success: false,
          message:
          "Payment verification failed.\n"
              "HTTP ${response.statusCode}",
        );
      }

      final dynamic data =
      jsonDecode(response.body);

      if (data is! Map<String, dynamic>) {
        return const PaymentResult(
          success: false,
          message:
          "Invalid verification response.",
        );
      }

      if (data["success"] == true) {
        return PaymentResult(
          success: true,
          message:
          "Payment verified successfully.",

          razorpayOrderId:
          razorpayOrderId,

          razorpayPaymentId:
          razorpayPaymentId,

          razorpaySignature:
          razorpaySignature,
        );
      }

      return PaymentResult(
        success: false,
        message:
        data["message"]?.toString() ??
            "Payment verification failed.",
      );
    } catch (e) {
      return PaymentResult(
        success: false,
        message:
        "Unable to verify payment: $e",
      );
    }
  }
}