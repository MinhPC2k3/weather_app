import 'package:my_app/features/weather/domain/entities/weather.dart';
import 'package:my_app/features/weather/domain/repositories/weather_repository.dart';

import '../data_source/weather_data_source.dart';
import '../../domain/mapper/mappers.dart';
import '../../../search/data/data_source/location_data_source.dart';
import 'package:http/http.dart' as https;

class WeatherRepositoriesImp implements WeatherRepositories {
  WeatherRepositoriesImp({OpenLocationApiClient? clientLocation,OpenWeatherApiClient? clientWeather}) : _clientLocation= clientLocation ?? OpenLocationApiClient(), _clientWeather= clientWeather ?? OpenWeatherApiClient();
  final OpenLocationApiClient _clientLocation;
  final OpenWeatherApiClient _clientWeather;
  @override
  Future<Weather> getWeather(String city) async{
    final location = await _clientLocation.getLocation(city);
    final weather = await _clientWeather.getWeather(location!.results![0].latitude!, location.results![0].longitude!);
    print('from data repository');
    return Weather(
      temperature: weather!.currentWeather!.temperature!,
      location: location.results![0].name!,
      condition: weather.currentWeather!.weathercode!.toInt().toCondition,
    );
    // return weather!;
  }
}

