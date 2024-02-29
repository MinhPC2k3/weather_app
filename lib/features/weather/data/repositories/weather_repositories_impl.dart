import 'package:minh_weather_app/features/weather/domain/entities/weather.dart';
import 'package:minh_weather_app/features/weather/domain/repositories/weather_repository.dart';

import '../data_source/weather_data_source.dart';
import '../../domain/mapper/mappers.dart';

class WeatherRepositoriesImp implements WeatherRepositories {
  WeatherRepositoriesImp({OpenWeatherApiClient? clientWeather}) : _clientWeather= clientWeather ?? OpenWeatherApiClient();
  final OpenWeatherApiClient _clientWeather;
  @override
  Future<Weather> getWeather(String city) async{
    final location = await _clientWeather.getLocation(city);
    final weather = await _clientWeather.getWeatherApi(location!.results!.elementAt(0).latitude!, location.results!.elementAt(0).longitude!);
    // print('from data repository ${location.results![0].name!} temparature ${weather!.currentWeather!.temperature!}');
    return Weather(
      temperature: weather!.currentWeather!.temperature!,
      location: location.results![0].name!,
      condition: weather.currentWeather!.weathercode!.toInt().toCondition,
    );
    // return weather!;
  }
}

