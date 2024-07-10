import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/currentweather_provider.dart';
import 'others_b.dart';

class WeatherDetails extends StatelessWidget {
  String _formatTime(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    return "$hour:$minute $period";
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CityWeatherProvider>(
      builder: (context, cityWeatherProvider, child) {
        return Container(
          width: 320,
          height: 280,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Weather Now",
                        style:
                            const TextStyle(fontFamily: 'My3', fontSize: 18)),
                    Text(
                      "More",
                      style: TextStyle(
                        fontFamily: 'My3',
                        color: Colors.black,
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Factor(
                      FactorName: 'Feel like',
                      icon: Icons.thermostat, // Icon for temperature
                      val: cityWeatherProvider.feellike_temperatureInCelsius !=
                              'null'
                          ? '${cityWeatherProvider.feellike_temperatureInCelsius}°C'
                          : '',
                    ),
                    Factor(
                      FactorName: 'Wind',
                      icon: Icons.air,
                      val: cityWeatherProvider.currentWeather != null &&
                              cityWeatherProvider.currentWeather!.wind != null
                          ? '${cityWeatherProvider.currentWeather!.wind!.speed} km/h'
                          : '',
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Factor(
                      FactorName: 'Pressure',
                      icon: Icons.ac_unit,
                      val: cityWeatherProvider.currentWeather != null &&
                              cityWeatherProvider
                                      .currentWeather!.main!.pressure !=
                                  null
                          ? '${cityWeatherProvider.currentWeather!.main!.pressure} MB'
                          : '', // Replace with dynamic data if available
                    ),
                    Factor(
                      FactorName: 'Humidity',
                      icon: Icons.opacity,
                      val: cityWeatherProvider.currentWeather != null &&
                              cityWeatherProvider
                                      .currentWeather!.main!.humidity !=
                                  null
                          ? '${cityWeatherProvider.currentWeather!.main!.humidity}%'
                          : '',
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Factor(
                      FactorName: 'Sun Rise',
                      icon: Icons.wb_sunny, // Relevant icon for sunrise
                      val: cityWeatherProvider.currentWeather != null &&
                              cityWeatherProvider
                                      .currentWeather!.sys!.sunrise !=
                                  null
                          ? _formatTime(
                              cityWeatherProvider.currentWeather!.sys!.sunrise!)
                          : '',
                    ),
                    Factor(
                      FactorName: 'Sun Set',
                      icon: Icons.nightlight_round,
                      val: cityWeatherProvider.currentWeather != null &&
                              cityWeatherProvider.currentWeather!.sys!.sunset !=
                                  null
                          ? _formatTime(
                              cityWeatherProvider.currentWeather!.sys!.sunset!)
                          : '',
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
