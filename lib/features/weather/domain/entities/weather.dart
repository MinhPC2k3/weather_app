import '../mapper/mappers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Weather extends Equatable{
  const Weather({
    required this.location,
    required this.temperature,
    required this.condition,
  });

  final String location;
  final double temperature;
  final WeatherCondition condition;

  @override
  List<Object?> get props => [location, temperature, condition];

  static final empty = const Weather(
    condition: WeatherCondition.unknown,
    // lastUpdated: DateTime(0),
    temperature: 0,
    location: '--',
  );
  Weather copyWith({
    WeatherCondition? condition,
    String? location,
    double? temperature,
  }) {
    return Weather(
      condition: condition ?? this.condition,
      location: location ?? this.location,
      temperature: temperature ?? this.temperature,
    );
  }
}

