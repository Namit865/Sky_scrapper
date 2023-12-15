import 'package:flutter/material.dart';
import 'package:weather_app/variable/thememodel.dart';
import 'package:weather_app/variable/weatherVariables.dart';

import '../helper/apikey.dart';

class providers extends ChangeNotifier {
  Weatherdata weatherdata = Weatherdata();
  theme Theme = theme(isdark: false);

  themeToggle() {
    Theme.isdark = !Theme.isdark;
    notifyListeners();
  }

  Future<void> fetchdata(String cityname) async {
    Weatherdata data = await ApiHelper.apiHelper.fetchData(cityname);
      weatherdata = data;
    notifyListeners();
  }
}
