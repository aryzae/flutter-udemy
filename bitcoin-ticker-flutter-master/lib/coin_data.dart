import 'package:http/http.dart' as http;
import 'dart:convert';

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

// https://rest.coinapi.io/v1/exchangerate/BTC/USD?apiKey=B4112241-12EE-41D9-9922-54472BD437CE
//{
//"time": "2020-06-08T15:24:12.3053113Z",
//"asset_id_base": "BTC",
//"asset_id_quote": "USD",
//"rate": 9678.342565622937
//}
const baseUrl = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'B4112241-12EE-41D9-9922-54472BD437CE';

class CoinData {
  CoinData(this.currency);

  String currency;

  Future<dynamic> getCoinData(String crypto) async {
    String url = '$baseUrl/$crypto/$currency?apiKey=$apiKey';

    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      return JsonDecoder().convert(response.body);
    } else {
      print('status code: ${response.statusCode}');
      return null;
    }
  }
}
