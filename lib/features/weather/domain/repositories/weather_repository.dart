import 'package:my_app/features/weather/data/models/weather_model.dart';

import '../entities/weather.dart';

abstract class WeatherRepositories {
  Future<Weather> getWeather(String city);
}