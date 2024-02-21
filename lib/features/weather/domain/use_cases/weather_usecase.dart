import 'package:my_app/features/weather/data/models/weather_model.dart';
import 'package:my_app/features/weather/data/repositories/weather_repositories_impl.dart';
import 'package:my_app/features/weather/domain/entities/weather.dart';
import 'package:my_app/features/weather/domain/repositories/weather_repository.dart';

class WeatherUseCase {
  WeatherUseCase({required WeatherRepositories repository}) : weatherRepositories=repository;

  final WeatherRepositories weatherRepositories;

  Future<Weather> getWeatherData(String city) async{
    print('doing');
    return await weatherRepositories.getWeather(city);
  }}