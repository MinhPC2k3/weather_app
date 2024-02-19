class Weather {
  CurrentWeather? currentWeather;

  Weather({this.currentWeather});

  Weather.fromJson(Map<String, dynamic> json) {
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
  int? windspeed;
  int? winddirection;
  int? isDay;
  int? weathercode;

  CurrentWeather(
      {this.temperature,
        this.windspeed,
        this.winddirection,
        this.isDay,
        this.weathercode});

  CurrentWeather.fromJson(Map<String, dynamic> json) {
    temperature = json['temperature'];
    windspeed = json['windspeed'];
    winddirection = json['winddirection'];
    isDay = json['is_day'];
    weathercode = json['weathercode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temperature'] = this.temperature;
    data['windspeed'] = this.windspeed;
    data['winddirection'] = this.winddirection;
    data['is_day'] = this.isDay;
    data['weathercode'] = this.weathercode;
    return data;
  }
}
