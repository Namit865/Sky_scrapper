import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/variable/weatherVariables.dart';

class ApiHelper{

  ApiHelper._();

  static final ApiHelper apiHelper = ApiHelper._();

  Future<dynamic> fetchData(String cityname) async {
    String apiKey = "b3a8605b591c4a77ad6120424231112";
    String apiUrl =
        "http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$cityname&aqi=no";

    http.Response response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);

      Map<String, dynamic> location = data['location'];
      Map<String, dynamic> currentdata = data['current'];

      Weatherdata res = Weatherdata(
        location: location['name'] ?? '',
        feelslike: currentdata['feelslike_c'].toString(),
        precipitation: currentdata['precip_mm'].toString(),
        tempraturecelsius: currentdata['temp_c'].toString(),
        weathercondition: currentdata['condition']['text'].toString(),
        weatherImage: currentdata['condition']['icon'].toString(),
        windspeed: currentdata['wind_kph'].toString(),
        date: location['localtime'].toString(),
        region : location['region'].toString(),
        Uv : currentdata['uv'].toString(),
        clouds : currentdata['cloud'].toString(),
        visibility : currentdata['vis_km'].toString(),
        windDirection : currentdata['wind_dir'].toString(),
        humidity : currentdata['humidity'].toString(),
      );

      return res;
    }
  }

  Future<dynamic> searchData(String cityname) async {
    String apiKey = "b3a8605b591c4a77ad6120424231112";
    String apiUrl =
        "http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$cityname&aqi=no";

    http.Response response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);

      Map<String, dynamic> location = data['location'];
      Map<String, dynamic> currentdata = data['current'];

      Weatherdata res = Weatherdata(
        location: location['name'] ?? '',
        feelslike: currentdata['feelslike_c'].toString(),
        precipitation: currentdata['precip_mm'].toString(),
        tempraturecelsius: currentdata['temp_c'].toString(),
        weathercondition: currentdata['condition']['text'].toString(),
        weatherImage: currentdata['condition']['icon'].toString(),
        windspeed: currentdata['wind_kph'].toString(),
        date: location['localtime'].toString(),
        region : location['region'].toString(),
        Uv : currentdata['uv'].toString(),
        clouds : currentdata['cloud'].toString(),
        visibility : currentdata['vis_km'].toString(),
        windDirection : currentdata['wind_dir'].toString(),
        humidity : currentdata['humidity'].toString(),
      );

      return res;
    }
  }
}