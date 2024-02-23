import 'package:equatable/equatable.dart';
import 'package:my_app/features/weather/domain/mapper/mappers.dart';
import '../../domain/entities/weather.dart';

class WeatherState extends Equatable{
  const WeatherState({this.weatherStatus=WeatherStatus.initial,this.temperatureUnits=TemperatureUnits.celsius,Weather? weather}) : weather=weather ?? Weather.empty;
  final WeatherStatus? weatherStatus;
  final TemperatureUnits? temperatureUnits;
  final Weather weather;

  WeatherState copyWith({
    WeatherStatus? status,
    TemperatureUnits? temperatureUnits,
    Weather? weather,
  }) {
    return WeatherState(
      weatherStatus: status ?? weatherStatus,
      temperatureUnits: temperatureUnits ?? this.temperatureUnits,
      weather: weather ?? this.weather,
    );
  }

  @override
  List<Object?> get props => [weatherStatus, temperatureUnits, weather];

}