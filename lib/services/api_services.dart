import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:our_weather/model/5days_weather.dart';
import 'package:our_weather/model/CurrentWeather.dart';

class ApiServices {
  static Future<Map<String, dynamic>> fetchAllWeather(String city) async {
    String errorMsg = "";
    http.Client client = http.Client();
    final String apiKey = '8c7ff350bd41f76e0185567405fbdeb5';

    if (!isValidCityInput(city)) {
      return {
        'currentWeather': null,
        'nextWeather': null,
        'errorMsg': 'Please enter a valid city name.',
      };
    }

    final String currentWeatherUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey';
    final String next5WeatherUrl =
        'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey';

    try {
      final currentResponse = await client.get(Uri.parse(currentWeatherUrl));
      if (currentResponse.statusCode == 200) {
        final currentJsonData = jsonDecode(currentResponse.body);
        final currentWeather = CurrentWeather.fromJson(currentJsonData);

        final next5Response = await client.get(Uri.parse(next5WeatherUrl));
        if (next5Response.statusCode == 200) {
          final next5JsonData = json.decode(next5Response.body);
          final next5Weather = DaysWeather.fromJson(next5JsonData);

          return {
            'currentWeather': currentWeather,
            'nextWeather': next5Weather,
            'errorMsg': errorMsg,
          };
        } else {
          errorMsg = "HTTP Error: ${next5Response.statusCode}";
          return {
            'currentWeather': currentWeather,
            'errorMsg': errorMsg,
          };
        }
      } else if (currentResponse.statusCode == 404) {
        errorMsg = "City not found: $city";
        return {
          'errorMsg': errorMsg,
        };
      } else {
        errorMsg = "HTTP Error: ${currentResponse.statusCode}";
        return {
          'errorMsg': errorMsg,
        };
      }
    } catch (ex, stackTrace) {
      print('Exception caught: $ex');
      print('Stack trace: $stackTrace');
      errorMsg = "Exception during API call: $ex";
      print("ex");
      return {
        'errorMsg': errorMsg,
      };
    } finally {
      client.close();
    }
  }

  static bool isValidCityInput(String input) {
    if (input.trim().isNotEmpty) {
      final RegExp regex = RegExp(r'^[a-zA-Z\s]+$');
      return regex.hasMatch(input);
    }
    return false;
  }
}
