import 'dart:convert';

import '../models/location.dart';
import 'package:http/http.dart' as https;

class OpenLocationApiClient{
  OpenLocationApiClient({https.Client? httpClient}) : _httpClient= httpClient ?? https.Client();
  final https.Client _httpClient;

  Future<Location?> getLocation (String query) async{
    final locationRequest = Uri.https(
      'https://geocoding-api.open-meteo.com',
      '/v1/search',
      {'name': query, 'count': '1'},
    );
    final response = await _httpClient.get(locationRequest);
    if(response.statusCode != 200){
      return null;
    }else {
      return Location.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    }
  }
}
