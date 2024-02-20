import 'dart:convert';

import '../models/location.dart';
import 'package:http/http.dart' as https;

class OpenLocationApiClient{
  OpenLocationApiClient({https.Client? httpClient}) : _httpClient= httpClient ?? https.Client();
  final https.Client _httpClient;
  static const _baseUrlGeocoding = 'geocoding-api.open-meteo.com';
  Future<Location?> getLocation (String query) async{
    final locationRequest = Uri.https(
      _baseUrlGeocoding,
      '/v1/search',
      {'name': query, 'count': '1'},
    );
    final response = await _httpClient.get(locationRequest);
    print('get location');
    if(response.statusCode != 200){
      return null;
    }else {
      return Location.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    }
  }
}
