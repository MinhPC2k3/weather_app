class WeatherModel {
  CurrentWeather? currentWeather;

  WeatherModel({this.currentWeather});

  WeatherModel.fromJson(Map<String, dynamic> json) {
    currentWeather = json['current_weather'] != null
        ? CurrentWeather.fromJson(json['current_weather'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (currentWeather != null) {
      data['current_weather'] = currentWeather!.toJson();
    }
    return data;
  }
}

class CurrentWeather {
  double? temperature;
  int? weathercode;

  CurrentWeather(
      {this.temperature,
        this.weathercode});

  CurrentWeather.fromJson(Map<String, dynamic> json) {
    temperature = json['temperature'];
    weathercode = json['weathercode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['temperature'] = temperature;
    data['weathercode'] = weathercode;
    return data;
  }

  // @override
  // List<Object> get props => [location, temperature, condition];
}
