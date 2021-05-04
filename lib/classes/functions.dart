import 'package:intl/intl.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

// hopefully nobody sees this function
String format(double value) {
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
