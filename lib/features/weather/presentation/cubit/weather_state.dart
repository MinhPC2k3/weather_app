import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_app/features/weather/domain/mapper/mappers.dart';
import '../../domain/entities/weather.dart';

class WeatherState extends Equatable{
  WeatherState({this.weatherStatus=WeatherStatus.initial,this.temperatureUnits=TemperatureUnits.celsius,Weather? weather}) : weather=weather ?? Weather.empty;
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