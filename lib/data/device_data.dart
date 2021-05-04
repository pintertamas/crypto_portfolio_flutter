import 'package:shared_preferences/shared_preferences.dart';

class DataHandler {
  loadPortfolio(Map<String, double> portfolio) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.getKeys().forEach((key) {
      portfolio[key] == null
          ? portfolio[key] = prefs.getDouble(key) ?? 0.0
          : portfolio.update(key, (value) => prefs.getDouble(key) ?? 0.0);
    });
  }
}
