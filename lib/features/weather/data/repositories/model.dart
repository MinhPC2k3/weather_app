enum WeatherCondition {
  clear,
  rainy,
  cloudy,
  snowy,
  unknown,
}

class WeatherRepositories {
  const WeatherRepositories({
    required this.location,
    required this.temperature,
    required this.condition,
  });

  final String location;
  final double temperature;
  final WeatherCondition condition;

}