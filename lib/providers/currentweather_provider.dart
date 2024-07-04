import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/CurrentWeather.dart';
import '../model/5days_weather.dart';
import '../services/api_services.dart';

class CityWeatherProvider with ChangeNotifier {
  CurrentWeather? _currentWeather;
  DaysWeather? _daysWeather;
  String _currentCity = "";
  String _errorMsg = "";
  bool _isLoading = false;

  String _convertKtoC(double? kelvin) {
    if (kelvin == null) {
      return 'null';
    } else {
      double cel = kelvin - 273.15;
      return cel.toStringAsFixed(0);
    }
  }

  String get temperatureInCelsius {
    return _convertKtoC(_currentWeather?.main?.temp);
  }

  String get feellike_temperatureInCelsius {
    return _convertKtoC(_currentWeather?.main?.feelsLike);
  }

  String day_weatherInCelcius(double kelvin) {
    double cel = kelvin - 273.15;
    return cel.toStringAsFixed(0);
  }

  String formatDateTime(String? dateTimeString) {
    if (dateTimeString != null) {
      DateTime dateTime = DateTime.parse(dateTimeString);
      return DateFormat('MMMM d, y').format(dateTime);
    } else {
      return '';
    }
  }

  String formatHourDateTime(String? dateTimeString) {
    if (dateTimeString != null) {
      DateTime dateTime = DateTime.parse(dateTimeString);
      return DateFormat('MMMM d').format(dateTime);
    } else {
      return '';
    }
  }

  String formatHourTimeDateTime(String? dateTimeString) {
    if (dateTimeString != null) {
      DateTime dateTime = DateTime.parse(dateTimeString);
      return DateFormat('h:mm a').format(dateTime);
    } else {
      return '';
    }
  }

  String formatTime(int? timezoneOffset) {
    if (timezoneOffset != null) {
      DateTime utcTime = DateTime.now().toUtc();
      DateTime localTime = utcTime.add(Duration(seconds: timezoneOffset));
      final hour = localTime.hour % 12 == 0 ? 12 : localTime.hour % 12;
      final minute = localTime.minute.toString().padLeft(2, '0');
      final period = localTime.hour >= 12 ? 'PM' : 'AM';
      return "$hour:$minute $period";
    } else {
      return 'null';
    }
  }

  IconData getWeatherIcon(double temperature) {
    if (temperature <= -30) {
      return Icons.ac_unit;
    } else if (temperature > -30 && temperature <= -20) {
      return Icons.ac_unit;
    } else if (temperature > -20 && temperature <= -10) {
      return Icons.snowing;
    } else if (temperature > -10 && temperature <= 0) {
      return Icons.wb_cloudy;
    } else if (temperature > 0 && temperature <= 10) {
      return Icons.cloud;
    } else if (temperature > 10 && temperature <= 15) {
      return Icons.cloud_queue;
    } else if (temperature > 15 && temperature <= 20) {
      return Icons.wb_cloudy;
    } else if (temperature > 20 && temperature <= 25) {
      return Icons.wb_sunny;
    } else if (temperature > 25 && temperature <= 30) {
      return Icons.sunny_snowing;
    } else if (temperature > 30 && temperature <= 35) {
      return Icons.wb_sunny_outlined;
    } else if (temperature > 35 && temperature <= 40) {
      return Icons.wb_sunny_rounded;
    } else if (temperature > 40 && temperature <= 45) {
      return Icons.wb_sunny;
    } else if (temperature > 45 && temperature <= 50) {
      return Icons.wb_sunny;
    } else {
      return Icons.error_outline;
    }
  }

  CurrentWeather? get currentWeather => _currentWeather;
  DaysWeather? get daysWeather => _daysWeather;
  String get currentCity => _currentCity;
  String get errorMsg => _errorMsg;
  bool get isLoading => _isLoading;

  get main => null;

  Future<void> fetchWeather(String city) async {
    _errorMsg = "";
    try {
      _isLoading = true;
      notifyListeners();

      final weatherResult = await ApiServices.fetchAllWeather(city);

      if (weatherResult['currentWeather'] != null) {
        _currentWeather = weatherResult['currentWeather'];
        _currentCity = city;
      }

      if (weatherResult['nextWeather'] != null) {
        _daysWeather = weatherResult['nextWeather'];
      }

      if (weatherResult['errorMsg'] != null) {
        _errorMsg = weatherResult['errorMsg'];
      }
    } catch (e) {
      _errorMsg = "Failed to fetch weather data: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
