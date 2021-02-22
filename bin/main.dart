import 'weather.dart';
import 'weather_api_client.dart';
import 'dart:io';

void main() async {
  while (true) {
    stdout.write('please input location name? :');
    final locationName = stdin.readLineSync() as String;
    final api = WeatherApiClient();
    try {
      final weather = await api.getWeather(locationName);
      print(weather);
    } on SocketException catch (e) {
      print('Error: Not connect network => $e');
      break;
    } catch (e) {
      print(e);
      stdout.write('next search? y/n');
      final line = stdin.readLineSync();
      if (line == 'y') {
        continue;
      } else {
        break;
      }
    }
  }
}
