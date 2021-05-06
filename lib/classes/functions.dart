import 'package:flutter_homework/data/coin_data.dart';
import 'package:intl/intl.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

double calculateBalance(CoinData coinValues, Map<String, double> portfolio,
    String selectedCurrency) {
  double balance = 0;
  coinValues.data.forEach((key, value) {
    balance += coinValues.data[key] == null
        ? 0
        : coinValues.data[key]!.coinMarketData!.price![selectedCurrency] *
            portfolio[key]!;
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

String format(var value) {
  if (value == null)
    return "unknown";
  RegExp regex = RegExp(r'0*$');
  String formattedNumber = value.toString().replaceAll(regex, "");
  var formatter = NumberFormat("#,##0.000000", "en_US");
  formattedNumber = formatter.format(double.parse(formattedNumber));
  formattedNumber = formattedNumber.replaceAll(regex, "");
  if (formattedNumber.endsWith('.')) {
    formattedNumber = formattedNumber.substring(0, formattedNumber.length - 1);
  }
  return formattedNumber;
}
