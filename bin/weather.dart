class Weather {
  const Weather({
    required this.weatherState,
    required this.minTemp,
    required this.maxTemp,
    required this.avgTemp,
  });

  final String weatherState;
  final double minTemp;
  final double maxTemp;
  final double avgTemp;

  factory Weather.fromJson(Map<String, Object> json) {
    return Weather(
      weatherState: json['weather_state_name'] as String,
      minTemp: json['min_temp'] as double,
      maxTemp: json['max_temp'] as double,
      avgTemp: json['the_temp'] as double,
    );
  }

  static Map<String, Object> toJson(Weather weather) {
    return {
      'weather_state': weather.weatherState,
      'min_temp': weather.minTemp,
      'max_temp': weather.maxTemp,
      'avg_temp': weather.avgTemp,
    };
  }

  @override
  String toString() => '''

  ------------------------------
 | Current Temp: ${avgTemp.toStringAsFixed(0)}°C 
 | Condition:    $weatherState                   
 | Daily Min:    ${minTemp.toStringAsFixed(0)}°C    
 | Daily Max:    ${maxTemp.toStringAsFixed(0)}°C    
  ------------------------------

  ''';
}
