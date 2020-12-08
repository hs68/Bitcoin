import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'api.dart';
import 'coin_data.dart';
import 'coin_data.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selected_currency = 'USD';
  var val = 0.0;
  FetchApiData obj = FetchApiData();

  DropdownButton<String> getandroid() {
    List<DropdownMenuItem<String>> dropDown = [];
    for (String currency in currenciesList) {
      var newitem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDown.add(newitem);
    }

    return DropdownButton<String>(
      value: selected_currency,
      items: dropDown,
      onChanged: (value) async {
        var res = await obj.fun(value);

        setState(() {
          selected_currency = value;
          val = res['rate'];
        });
      },
    );
  }

  CupertinoPicker getIos() {
    List<Widget> scroll = [];
    for (String currency in currenciesList) {
      var newItem = Text(
        currency,
      );
      scroll.add(newItem);
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) async {
        selected_currency = currenciesList[selectedIndex];
        var res = await obj.fun(selected_currency);
        setState(() {
          val = res['rate'];
          selected_currency = currenciesList[selectedIndex];
        });

        //val = res['rate'];
      },
      children: scroll,
    );
    //return scroll;
  }

  Widget getpicker() {
    if (Platform.isAndroid)
      return getandroid();
    else if (Platform.isIOS) return getIos();
  }

  @override
  Widget build(BuildContext context) {
    //getandroid();
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
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
                  '1 BTC = $val $selected_currency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getIos(),
          ),
        ],
      ),
    );
  }
}
/*
*/
