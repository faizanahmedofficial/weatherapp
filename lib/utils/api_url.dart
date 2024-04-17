import 'package:weatherapp_starter_project/api/api_key.dart';

String apiURL(var lat, var lon) {
  String url;

  url =
      "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&appid=$apiKey&units=metric&exclude=minutely";
  return url;
}
String apiURLByCityName(String city) {
  String url;

  url =
  "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";
  return url;
}


