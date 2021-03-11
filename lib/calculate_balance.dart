import 'coin_data.dart';

double calculateBalance(CoinData coinValues, Map<String, double> portfolio) {
  double balance = 0;
  coinValues.data.forEach((key, value) {
    balance += coinValues.data[key].price * portfolio[key];
  });
  return (balance * 10000).toInt().toDouble()/10000;
}