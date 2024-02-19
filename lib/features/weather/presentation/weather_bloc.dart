import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

@immutable
abstract class WeatherEvent{}

final class SearchWeatherEvent extends WeatherEvent{}

class WeatherBloc extends Bloc<WeatherEvent,String>{
  WeatherBloc() : super('Data null'){
    on<SearchWeatherEvent>((event,emit)=> emit(

    ));
  };

}

