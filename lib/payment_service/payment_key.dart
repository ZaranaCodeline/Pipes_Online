import 'package:flutter_stripe/flutter_stripe.dart';

Future<void> setStripeKey() async {
  Stripe.publishableKey =
      'pk_live_51Hhb6MF4WGv3hSGhpxKE2rCmt8T2EUpEOE6hQI1Ms8jLKHyJXALaY5h69Kv276w9t55QVE32YP6fLEH3yIiqtzYQ00vzdAhLCF';
  Stripe.merchantIdentifier = 'stripe payment';
  await Stripe.instance.applySettings();
}

String get secretKey =>
    "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";
