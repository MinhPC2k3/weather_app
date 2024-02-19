import '../data_source/weather_data_source.dart';
import '../models/weather.dart';
import '../../../search/data/models/location.dart';
import '../../../search/data/data_source/location_data_source.dart';
enum WeatherCondition {
  clear,
  rainy,
  cloudy,
  snowy,
  unknown,
}

class WeatherRepositoriesModel {
  const WeatherRepositoriesModel({
    required this.location,
    required this.temperature,
    required this.condition,
  });

  final String location;
  final double temperature;
  final WeatherCondition condition;

}
class WeatherRepositories {
  WeatherRepositories({OpenLocationApiClient? clientLocation,OpenWeatherApiClient? clientWeather}) : _clientLocation= clientLocation ?? OpenLocationApiClient(), _clientWeather= clientWeather ?? OpenWeatherApiClient();
  final OpenLocationApiClient _clientLocation;
  final OpenWeatherApiClient _clientWeather;
  Future<WeatherRepositoriesModel> getWeather(String city) async{
    final location = await _clientLocation.getLocation(city);
    final weather = await _clientWeather.getWeather(location!.results![0].latitude!, location!.results![0].latitude!);
    return WeatherRepositoriesModel(
      temperature:weather!.currentWeather!.temperature!,
        location: location.results![0].name!,
        condition: weather.currentWeather!.weathercode!.toInt().toCondition,
    );
  }
}

extension on int {
  WeatherCondition get toCondition {
    switch (this) {
      case 0:
        return WeatherCondition.clear;
      case 1:
      case 2:
      case 3:
      case 45:
      case 48:
        return WeatherCondition.cloudy;
      case 51:
      case 53:
      case 55:
      case 56:
      case 57:
      case 61:
      case 63:
      case 65:
      case 66:
      case 67:
      case 80:
      case 81:
      case 82:
      case 95:
      case 96:
      case 99:
        return WeatherCondition.rainy;
      case 71:
      case 73:
      case 75:
      case 77:
      case 85:
      case 86:
        return WeatherCondition.snowy;
      default:
        return WeatherCondition.unknown;
    }
  }
}