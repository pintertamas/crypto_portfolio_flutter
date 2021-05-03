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

  addToPortfolio(String coinName, double amount) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.get(coinName) == null
        ? prefs.setDouble(coinName, amount)
        : prefs.setDouble(coinName, prefs.getDouble(coinName) ?? 0.0 + amount);
  }
}
