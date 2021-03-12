import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants.dart';

Future<List<String>> fetchVsCurrenciesData() async {
  final response = await http.get(
    Uri.https(coinGeckoSite, '/api/v3/simple/supported_vs_currencies'),
  );

  if (response.statusCode == 200) {
    print(response.request);
    var res = jsonDecode(response.body).cast<String>();
    print(res.runtimeType);
    return res;
  } else {
    throw Exception('Failed to load data');
  }
}
