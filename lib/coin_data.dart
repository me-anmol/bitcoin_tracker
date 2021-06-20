import 'package:http/http.dart' as http;
import 'dart:convert';
      //TODO: Add your imports here.

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate/';
const apiKey = 'DA1FB31F-7E00-4EB3-93C4-2401E7B26FC4';

class CoinData {
  //TODO: Create your getCoinData() method here.
  CoinData({this.cryptoCurrency,this.currency});
  final String cryptoCurrency;
  final String currency;


  dynamic getCoinData() async {
    http.Response response = await http.get((Uri.parse(
        coinAPIURL + cryptoCurrency + '/' + currency + '?apikey=' + apiKey)));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Error Occurred code#${response.statusCode}');
    }
  }

}
