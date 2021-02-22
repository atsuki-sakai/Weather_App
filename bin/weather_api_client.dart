import 'package:http/http.dart' as http;
import 'dart:convert';
import 'weather.dart';

class WeatherApiException implements Exception {
  const WeatherApiException(this.message);
  final String message;

  @override
  String toString() {
    return 'WeatherException : $message';
  }
}

class WeatherApiClient {
  static const baseUrl = 'https://www.metaweather.com/api';

  Future<int> getLocationID(String city) async {
    final locationUrl = '$baseUrl/location/search/?query=$city';
    final locationResponse = await http.get(locationUrl);
    if (locationResponse.statusCode != 200) {
      throw WeatherApiException('Error: getting locationID for city=>"$city"');
    }
    final locationJson = jsonDecode(locationResponse.body) as List;
    if (locationJson.isEmpty) {
      throw WeatherApiException("Not't match locationName for: $city ");
    }
    return locationJson.first['woeid'];
  }

  Future<Weather> fetchWeather(int locationID) async {
    final weatherUrl = '$baseUrl/location/$locationID';
    final weatherResponse = await http.get(weatherUrl);
    if (weatherResponse.statusCode != 200) {
      throw WeatherApiException(
          'Error: getting weather for location: $locationID');
    }
    final json = jsonDecode(weatherResponse.body);
    final consolidatedWeather = json['consolidated_weather'] as List;
    return Weather.fromJson(consolidatedWeather[0] as Map<String, Object>);
  }

  Future<Weather> getWeather(String city) async {
    final locationID = await getLocationID(city);
    return fetchWeather(locationID);
  }
}
