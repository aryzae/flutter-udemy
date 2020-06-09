import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = currenciesList.first;
  List<String> exchangeList = List.generate(cryptoList.length, (index) => '?');

  DropdownButton<String> androidDropdownButton() {
    List<DropdownMenuItem> dropdownItems = List.generate(
      currenciesList.length,
      (index) => DropdownMenuItem(
        child: Text(currenciesList[index]),
        value: currenciesList[index],
      ),
    );

    return DropdownButton<String>(
        value: selectedCurrency,
        items: dropdownItems,
        onChanged: (value) {
          setState(() {
            selectedCurrency = value;
            getData();
          });
        });
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = List.generate(
        currenciesList.length, (index) => Text(currenciesList[index]));

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (index) {
        selectedCurrency = currenciesList[index];
        getData();
      },
      children: pickerItems,
    );
  }

  void getData() async {
    CoinData coinData = CoinData(selectedCurrency);

    cryptoList.asMap().forEach((index, value) async {
      dynamic data = await coinData.getCoinData(value);
      if (data != null) {
        dynamic rate = data['rate'];
        setState(() {
          exchangeList[index] = rate.toStringAsFixed(0);
        });
      }
    });
  }

  List<RateCard> createRateCards() {
    return List.generate(
      cryptoList.length,
      (index) => RateCard(
        crypto: cryptoList[index],
        exchangeCurrency: exchangeList[index],
        selectedCurrency: selectedCurrency,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: createRateCards(),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdownButton(),
          )
        ],
      ),
    );
  }
}

class RateCard extends StatelessWidget {
  RateCard({this.crypto, this.exchangeCurrency, this.selectedCurrency});

  final String crypto;
  final String exchangeCurrency;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 ${crypto} = ${exchangeCurrency} ${selectedCurrency}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
