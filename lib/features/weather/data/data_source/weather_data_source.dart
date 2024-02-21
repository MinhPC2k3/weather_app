import 'dart:convert';

import 'package:http/http.dart' as https;

import '../models/weather_model.dart';

class OpenWeatherApiClient{
  OpenWeatherApiClient({https.Client? httpClient}) : _httpsClient=httpClient ?? https.Client();
  final https.Client _httpsClient;
  static const _baseUrlWeather = 'api.open-meteo.com';
  Future<WeatherModel?> getWeatherApi(double latitude, double longitude) async{
    var weatherRequest = Uri.https(
        _baseUrlWeather,
        '/v1/forecast',
        {'latitude': '$latitude','longitude': '$latitude','current_weather': 'true'}
    );
    var response = await _httpsClient.get(weatherRequest);
    print('get weather');
    if(response.statusCode == 200){
      return WeatherModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    }else{
      return null;
    }
  }
}
