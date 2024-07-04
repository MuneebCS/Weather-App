import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/currentweather_provider.dart';

class CustomBackground extends StatelessWidget {
  final Widget child;

  const CustomBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CityWeatherProvider>(
      builder: (context, cityWeatherProvider, child) {
        List<Color> gradientColors = _getGradientColors(cityWeatherProvider);

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: child,
        );
      },
      child: child,
    );
  }

  List<Color> _getGradientColors(CityWeatherProvider cityWeatherProvider) {
    String? weatherCondition =
        cityWeatherProvider.currentWeather?.weather?.isNotEmpty == true
            ? cityWeatherProvider.currentWeather!.weather![0].main
            : null;

    switch (weatherCondition) {
      case "Clouds":
        return [
          const Color.fromARGB(255, 108, 109, 109),
          const Color.fromARGB(255, 138, 140, 141),
          const Color.fromARGB(255, 188, 190, 190),
          Colors.white,
        ];
      case "Clear":
        return [
          Colors.orange.shade700,
          Colors.orange.shade300,
          Colors.orange.shade100,
          Colors.white,
        ];
      case "Rain":
        return [
          const Color.fromARGB(255, 203, 226, 226),
          const Color.fromARGB(255, 154, 164, 164),
          const Color.fromARGB(255, 128, 148, 148),
          Colors.white,
        ];
      case "Snow":
        return [
          const Color.fromARGB(255, 108, 109, 109),
          const Color.fromARGB(255, 138, 140, 141),
          const Color.fromARGB(255, 188, 190, 190),
          Colors.white,
        ];
      case "Drizzle":
        return [
          Colors.deepPurple.shade700,
          Colors.deepPurple.shade300,
          Colors.deepPurple.shade100,
          Colors.white,
        ];
      case "Atmosphere":
        return [
          Colors.orange.shade700,
          Colors.orange.shade300,
          Colors.orange.shade100,
          Colors.white,
        ];
      default:
        return [
          Colors.lightBlue.shade700,
          Colors.lightBlue.shade300,
          Colors.lightBlue.shade100,
          Colors.white,
        ];
    }
  }
}
