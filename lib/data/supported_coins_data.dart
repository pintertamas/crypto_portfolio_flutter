import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants.dart';

Future<List<String>> fetchSupportedCoinsData() async {
  final response = await http.get(
    Uri.https(coinGeckoSite, '/api/v3/coins/list'),
  );

  if (response.statusCode == 200) {
    //print(response.request);
    var res = jsonDecode(response.body).cast<String>();
    return res;
  } else {
    throw Exception('Failed to load data');
  }
}
