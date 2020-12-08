import 'dart:convert';

import 'package:http/http.dart';

class FetchApiData {
  FetchApiData();
  //final name;
  Future fun(String name) async {
    Response response = await get(
        'https://rest.coinapi.io/v1/exchangerate/BTC/$name?apikey=86A17E39-9A4D-4B19-8FB1-998BD4EF7321');
    if (response.statusCode == 200) {
      {
        var res = jsonDecode(response.body);
        print(res['time']);
        print(res['rate']);
        return res;
      }
    } else {
      var er = "error";
      return er;
    }
  }
}
