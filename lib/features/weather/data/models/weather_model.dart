class WeatherModel {
  CurrentWeather? currentWeather;

  WeatherModel({this.currentWeather});

  WeatherModel.fromJson(Map<String, dynamic> json) {
    currentWeather = json['current_weather'] != null
        ? new CurrentWeather.fromJson(json['current_weather'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.currentWeather != null) {
      data['current_weather'] = this.currentWeather!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temperature'] = this.temperature;
    data['weathercode'] = this.weathercode;
    return data;
  }

  // @override
  // List<Object> get props => [location, temperature, condition];
}
