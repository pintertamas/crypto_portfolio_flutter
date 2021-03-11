//const apiKeyCoinMarketCap = '3a6bf78c-764c-40a3-8863-8a308f7f326b';
const apiKeyCoinMarketCap = 'b54bcf4d-1bca-4e8e-9a24-22ff2c3d462c'; // test key

//var siteNameCoin = 'pro-api.coinmarketcap.com';
var coinMarketCapSite = 'sandbox-api.coinmarketcap.com'; // test site
var coinGeckoSite = 'api.coingecko.com';

String selectedCurrency = currenciesList[0];

const List<String> currenciesList = [
  'USD',
  'BTC',
];

const Map<String, double> portfolio = {
  'BTC' : 2.05,
  'ETH' : 3.4,
  'LTC' : 2,
  'XRP' : 300,
  'XMR' : 2.05,
  'USDT' : 1002,
  'BNB' : 2,
  'ADA' : 30,
};