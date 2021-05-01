import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<String>> fetchVsCurrenciesData() async {
  var coinGeckoSite = 'api.coingecko.com';

  final response = await http.get(
    Uri.https(coinGeckoSite, '/api/v3/simple/supported_vs_currencies'),
  );

  if (response.statusCode == 200) {
    var res = jsonDecode(response.body).cast<String>();
    return res;
  } else {
    throw Exception('Failed to load data');
  }
}
