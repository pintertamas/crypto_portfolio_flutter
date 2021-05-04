import 'dart:convert';
import 'package:http/http.dart' as http;

class CoinChartData {
  Map<int, double> data = Map();
  List<double> prices = [];
  String name = '';

  CoinChartData();

  factory CoinChartData.fromJson(Map<String, dynamic> json, String name) {
    CoinChartData res = CoinChartData();
    res.name = name;
    for (int i = 0; i < json.values.elementAt(0).length; i++) {
      res.data[json.values.elementAt(0)[i][0]] = json.values.elementAt(0)[i][1];
      res.prices.add(json.values.elementAt(0)[i][1]);
    }
    return res;
  }
}

Future<CoinChartData> fetchCoinChartData(String coinName, String selectedCurrency) async {
  var coinGeckoSite = 'api.coingecko.com';

  Map<String, String> queryParameters = {
    'vs_currency': selectedCurrency,
    'days': '7',
  };

  var uri = Uri.https(coinGeckoSite,
      '/api/v3/coins/${coinName.toLowerCase().replaceAll(' ', '')}/market_chart', queryParameters);
  var response = await http.get(uri);

  if (response.statusCode == 200) {
    return CoinChartData.fromJson(jsonDecode(response.body), coinName);
  } else {
    throw Exception('Failed to load data');
  }
}
