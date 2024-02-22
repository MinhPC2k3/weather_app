import 'package:my_app/features/weather/data/repositories/weather_repositories_impl.dart';
import 'package:my_app/features/weather/domain/use_cases/weather_usecase.dart';
import 'package:my_app/features/weather/presentation/cubit/weather_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '';
import '../../domain/entities/weather.dart';
import '../../domain/mapper/mappers.dart';
import '../../domain/repositories/weather_repository.dart';


class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit({required this.weatherUseCase}) : super(WeatherState());

  final WeatherUseCase weatherUseCase ;

  Future<void> fetchWeather(String? city) async {
    if (city == null || city.isEmpty) return;

    emit(state.copyWith(status: WeatherStatus.loading));

    try {
      final weather = await weatherUseCase.getWeatherData(city);
      final units = state.temperatureUnits;
      final value = units!.isFahrenheit
          ? weather.temperature.toFahrenheit()
          : weather.temperature;

      emit(
        state.copyWith(
          status: WeatherStatus.success,
          temperatureUnits: units,
          weather: weather.copyWith(temperature: value),
        ),
      );
    } on Exception {
      emit(state.copyWith(status: WeatherStatus.failure));
    }
  }

  Future<void> refreshWeather() async {
    if (!state.weatherStatus!.isSuccess) return;
    if (state.weather == Weather.empty) return;
    try {
      final weather = await weatherUseCase.getWeatherData(state.weather.location);
      final units = state.temperatureUnits;
      final value = units!.isFahrenheit
          ? weather.temperature.toFahrenheit()
          : weather.temperature;

      emit(
        state.copyWith(
          status: WeatherStatus.success,
          temperatureUnits: units,
          weather: weather.copyWith(temperature: value),
        ),
      );
    } on Exception {
      emit(state);
    }
  }

  void toggleUnits() {
    final units = state.temperatureUnits!.isFahrenheit
        ? TemperatureUnits.celsius
        : TemperatureUnits.fahrenheit;

    if (!state.weatherStatus!.isSuccess) {
      emit(state.copyWith(temperatureUnits: units));
      return;
    }

    final weather = state.weather;
    if (weather != Weather.empty) {
      final temperature = weather.temperature;
      final value = units.isCelsius
          ? temperature.toCelsius()
          : temperature.toFahrenheit();
      emit(
        state.copyWith(
          temperatureUnits: units,
          weather: weather.copyWith(temperature: value),
        ),
      );
    }
  }

}
