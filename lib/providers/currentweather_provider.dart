import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/CurrentWeather.dart';
import '../model/5days_weather.dart';
import '../services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  String getWeatherIcon(double temperature) {
    if (temperature > -40 && temperature < -10) {
      return "assets/icons/90d.svg";
    } else if (temperature > -10 && temperature <= 5) {
      return "assets/icons/50d.svg";
    } else if (temperature > 5 && temperature < 15) {
      return "assets/icons/04n.svg";
    } else if (temperature > 15 && temperature < 22) {
      return "assets/icons/09d.svg";
    } else if (temperature > 22 && temperature < 25) {
      return "assets/icons/02d.svg";
    } else if (temperature > 25 && temperature < 28) {
      return "assets/icons/03n.svg";
    } else if (temperature > 28 && temperature < 30) {
      return "assets/icons/10d.svg";
    } else if (temperature > 30 && temperature < 33) {
      return "assets/icons/s3.svg";
    } else if (temperature > 33 && temperature < 35) {
      return "assets/icons/s1.svg";
    } else if (temperature > 35 && temperature <= 40) {
      return "assets/icons/01d.svg";
    } else if (temperature > 40 && temperature <= 45) {
      return "assets/icons/01n.svg";
    } else {
      return "assets/icons/01n.svg";
    }
  }

  void clearError() {
    _errorMsg = '';
    notifyListeners();
  }

  CurrentWeather? get currentWeather => _currentWeather;
  DaysWeather? get daysWeather => _daysWeather;
  String get currentCity => _currentCity;
  String get errorMsg => _errorMsg;
  bool get isLoading => _isLoading;

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

      await _saveToPrefs();
    } catch (e) {
      _errorMsg = "Failed to fetch weather data: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _saveToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentCity', _currentCity);
  }

  Future<void> loadFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _currentCity = prefs.getString('currentCity') ?? '';
    if (_currentCity.isNotEmpty) {
      await fetchWeather(_currentCity);
    }
  }
}
