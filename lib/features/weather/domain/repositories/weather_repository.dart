
import '../entities/weather.dart';

abstract class WeatherRepositories {
  Future<Weather> getWeather(String city);
}