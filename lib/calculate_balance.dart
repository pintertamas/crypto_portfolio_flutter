import 'data/coin_data.dart';

double calculateBalance(CoinData coinValues, Map<String, double> portfolio, String selectedCurrency) {
  double balance = 0;
  coinValues.data.forEach((key, value) {
    balance += coinValues.data[key] == null
        ? 0
        : coinValues.data[key]!.coinMarketData.price![selectedCurrency] * portfolio[key]!;
  });
  return (balance * 10000).toInt().toDouble() / 10000;
}
