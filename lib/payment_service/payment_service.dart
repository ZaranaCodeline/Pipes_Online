import 'dart:async';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:http_auth/http_auth.dart';

class PaypalServices {
  String domain = "https://api.sandbox.paypal.com"; // for sandbox mode
  // String domain = "https://api.paypal.com"; // for production mode

  // change clientId and secret with your own, provided by paypal
  // String clientId =
  //     'AfkS7i-aVI1eKm4XFiaqz2TO3UH0DzCNKSffGb9oAXIV_b8zemyFw_KnZMA3g1Y-6GveNH1ZWi7KRsMo';
  String clientId =
      'AatrXmMKTAh66YYoGnJj-ZodDA55G9f5jGjWHSDVCnQcolTKvyO1nTdMEZUd_m2JS6ixp0_3tsXKy1-o';
  // String secret =
  //     'EB0n1xCoO899nEaAYI0y-uvin_CRRGl3NWf6J_WOD4M3cBUBx7XG5rufmu_TcRZc_fttxEThQEE_29eI';
  String secret =
      'EDHn6Yh6wIB2c4XGioDIrcW_QEtv7UbqbJCM_LbJWfaP7D5B4KFRGKmGCorGR2HFU6X2M43pBwi65zBG';

  // for getting the access token from Paypal
  Future<String?> getAccessToken() async {
    try {
      var client = BasicAuthClient(clientId, secret);
      var response = await client.post(
          Uri.parse('$domain/v1/oauth2/token?grant_type=client_credentials'));
      if (response.statusCode == 200) {
        final body = convert.jsonDecode(response.body);
        print(body);
        return body["access_token"];
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  // for creating the payment request with Paypal
  Future<Map<String, String>?> createPaypalPayment(
      transactions, accessToken) async {
    try {
      var response = await http.post(Uri.parse('$domain/v1/payments/payment'),
          body: convert.jsonEncode(transactions),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer ' + accessToken
          });

      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 201) {
        if (body["links"] != null && body["links"].length > 0) {
          List links = body["links"];

          String executeUrl = "";
          String approvalUrl = "";
          final item = links.firstWhere((o) => o["rel"] == "approval_url",
              orElse: () => null);
          if (item != null) {
            approvalUrl = item["href"];
          }
          final item1 = links.firstWhere((o) => o["rel"] == "execute",
              orElse: () => null);
          if (item1 != null) {
            executeUrl = item1["href"];
          }
          return {"executeUrl": executeUrl, "approvalUrl": approvalUrl};
        }
        return null;
      } else {
        throw Exception(body["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }

  // for executing the payment transaction
  Future<String?> executePayment(url, payerId, accessToken) async {
    try {
      var response = await http.post(url,
          body: convert.jsonEncode({"payer_id": payerId}),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer ' + accessToken
          });

      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return body["id"];
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
