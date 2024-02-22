import 'dart:convert';

import 'package:http/http.dart' as https;

import '../models/location_model.dart';
import '../models/weather_model.dart';

class OpenWeatherApiClient{
  OpenWeatherApiClient({https.Client? httpClient}) : _httpsClient=httpClient ?? https.Client();
  final https.Client _httpsClient;
  static const _baseUrlWeather = 'api.open-meteo.com';
  static const _baseUrlGeocoding = 'geocoding-api.open-meteo.com';

  Future<LocationModel?> getLocation (String query) async{
    final locationRequest = Uri.https(
      _baseUrlGeocoding,
      '/v1/search',
      {'name': query, 'count': '1'},
    );
    final response = await _httpsClient.get(locationRequest);
    print('get location');
    if(response.statusCode != 200){
      return null;
    }else {
      return LocationModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    }
  }
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
