import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;


class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String coinValue ='?';
  var dict = new Map();
  void createValue() async {
    for(int  i =0 ; i<cryptoList.length;i++){
      dict[cryptoList[i]] = await getData(cryptoList[i]);
    }
  }

  DropdownButton<String> androidDropdown(String crypto) {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          createValue();
        });
      },
    );
  }

  CupertinoPicker iOSPicker(String crypto) {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
      selectedCurrency = currenciesList[selectedIndex];
      setState(() {
        createValue();
      });
      },
      children: pickerItems,
    );
  }

  //TODO: Create a method here called getData() to get the coin data from coin_data.dart
  dynamic getData(String crypto) async {
    CoinData coin = CoinData(cryptoCurrency: crypto,currency: selectedCurrency );
    dynamic data = await coin.getCoinData();
    return (data['rate']).toStringAsFixed(2);

  }

  @override
  void initState() {
    super.initState();
    createValue();

    //TODO: Call getData() when the screen loads up.
  }

  List<Widget> createList(){
    List<Widget> res = [];
    createValue();
    for(int i = 0; i<cryptoList.length;i++){
      res.add(
          Padding(
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
                  //TODO: Update the Text Widget with the live bitcoin data here.
                  '1 "${cryptoList[i]}" = ${dict[cryptoList[i]]} $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
      );
    }
    res.add(
        Container(
          height: 150.0,
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: 30.0),
          color: Colors.lightBlue,
          child: Platform.isIOS ? iOSPicker('BTC') : androidDropdown('BTC'),
        )
    );
    return res;
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
        children: createList(),
      ),
    );
  }
}
