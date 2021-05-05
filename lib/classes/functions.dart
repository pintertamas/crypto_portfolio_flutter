import 'package:flutter_homework/data/coin_data.dart';
import 'package:intl/intl.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

double calculateBalance(CoinData coinValues, Map<String, double> portfolio, String selectedCurrency) {
  double balance = 0;
  coinValues.data.forEach((key, value) {
    balance += coinValues.data[key] == null
        ? 0
        : coinValues.data[key]!.coinMarketData.price![selectedCurrency] * portfolio[key]!;
  });
  return (balance * 10000).toInt().toDouble() / 10000;
}

String? passedTime(DateTime createdAt) {
  int seconds = DateTime.now().difference(createdAt).inSeconds;
  int minutes = seconds ~/ 60;
  int hours = minutes ~/ 60;
  int days = hours ~/ 24;
  if (days > 0)
    return "$days days ago";
  else if (hours > 0)
    return "$hours hours ago";
  else if (minutes > 0)
    return "$minutes minutes ago";
  else
    return "$seconds seconds ago";
}

// hopefully nobody sees this function
String format(String? strValue) {
  if (strValue == null) return "unknown";
  double value = double.parse(strValue);
  print(value);
  var formatter;
  if (value - value.floorToDouble() == 0)
    formatter = NumberFormat("#,##0", "en_US");
  else if (value < 1 && value > 0.1)
    formatter = NumberFormat("#,##0.00", "en_US");
  else if (value < 0.1 && value > 0.0001)
    formatter = NumberFormat("#,##0.0000", "en_US");
  else if (value < 0.0001 && value > 0.000001)
    formatter = NumberFormat("#,##0.000000", "en_US");
  else if (double.parse(value.toString()) < 0.000001)
    formatter = NumberFormat("#,##0.00000000", "en_US");
  return formatter.format(value).toString();
}
