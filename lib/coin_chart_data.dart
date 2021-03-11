import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants.dart';

class CoinChartData {
  final Map<String, List<List<dynamic>>> data = new Map<String, List<dynamic>>();

  CoinChartData();

  factory CoinChartData.fromJson(Map<String, dynamic> json) {
    CoinChartData res = new CoinChartData();
    print(json['prices']);
    return res;
  }
}

Future<CoinChartData> fetchCoinChartData(String coinName, String currentCurrency) async {
  Map<String, String> queryParameters = {
    'vs_currency': currentCurrency,
    'days': '7',
  };

  var uri =
  Uri.https(coinGeckoSite, '/api/v3/coins/${coinName.toLowerCase()}/market_chart', queryParameters);
  var response = await http.get(uri);

  if (response.statusCode == 200) {
    print(response.request);
    return CoinChartData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}
