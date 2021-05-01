import 'package:flutter/cupertino.dart';

class BottomNavigationBarProvider with ChangeNotifier {
  int _currentIndex = 0;
  String _selectedCurrency = 'usd'; // default vs_currency
  String _selectedCrypto = 'btc'; // default new_currency

  int get currentIndex => _currentIndex;
  String get selectedCurrency => _selectedCurrency;
  String get selectedCrypto => _selectedCrypto;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  set selectedCurrency(String selectedCurrency) {
    _selectedCurrency = selectedCurrency;
    notifyListeners();
  }

  set selectedCrypto(String selectedCrypto) {
    _selectedCrypto = selectedCrypto;
    notifyListeners();
  }
}
