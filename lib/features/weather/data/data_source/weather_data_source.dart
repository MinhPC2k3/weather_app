import 'dart:convert';

import 'package:http/http.dart' as https;

import '../models/weather.dart';

class OpenWeatherApiClient{
  OpenWeatherApiClient({https.Client? httpClient}) : _httpsClient=httpClient ?? https.Client();
  final https.Client _httpsClient;
  Future<Weather?> getWeather(double latitude, double longitude) async{
    var weatherRequest = Uri.https(
        'https://api.open-meteo.com',
        '/v1/forecast',
        {'latitude': latitude,'longitude': longitude,'current_weather': true}
    );
    var response = await _httpsClient.get(weatherRequest);
    if(response.statusCode == 200){
      return Weather.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    }else{
      return null;
    }
  }
}
