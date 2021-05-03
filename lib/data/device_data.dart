import 'package:shared_preferences/shared_preferences.dart';

class DataHandler {
  loadPortfolio(Map<String, double> portfolio) async {
    //print(portfolio);

    final prefs = await SharedPreferences.getInstance();
    prefs.getKeys().forEach((key) {
      portfolio[key] == null
          ? portfolio[key] = prefs.getDouble(key) ?? 0.0
          : portfolio.update(key, (value) => prefs.getDouble(key) ?? 0.0);
      //print('read: $key - ${prefs.get(key)}');
    });
  }

  savePortfolio(Map<String, double> portfolio) async {
    Map<String, double> portfolio = {
      'bitcoin': 6.05,
      'ethereum': 3.4,
    };
    /*Map<String, double> portfolio = {
      'bitcoin': 6.05,
      'ethereum': 3.4,
      'litecoin': 20,
      'switcheo': 350000,
      'ripple': 300,
      'monero': 2.05,
      'tether': 1002,
      'binancecoin': 43,
      'cardano': 30,
      'tezos': 1002,
      'solana': 654,
      'cosmos': 32,
      'renbtc': 40,
      'stellar': 5321,
      'dogecoin': 200,
    };*/
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();

    portfolio.forEach((key, value) {
      prefs.setDouble(key, value);
    });
  }

  addToPortfolio(String coinName, double amount) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.get(coinName) == null
        ? prefs.setDouble(coinName, amount)
        : prefs.setDouble(coinName, prefs.getDouble(coinName) ?? 0.0 + amount);
  }
}
