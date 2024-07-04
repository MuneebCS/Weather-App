import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/currentweather_provider.dart';
import '../custom_widgets/others.dart';

class CurrentWeatherDetail extends StatefulWidget {
  const CurrentWeatherDetail({super.key});

  @override
  _CurrentWeatherDetailState createState() => _CurrentWeatherDetailState();
}

class _CurrentWeatherDetailState extends State<CurrentWeatherDetail> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CityWeatherProvider>(
      builder: (context, cityWeatherProvider, child) {
        String city = cityWeatherProvider.currentCity;
        String? val =
            cityWeatherProvider.currentWeather?.weather?.isNotEmpty == true
                ? cityWeatherProvider.currentWeather!.weather![0].main
                : null;
        String imagePath;
        switch (val) {
          case "Clouds":
            imagePath = "cloudy.jpg";
            break;
          case "Clear":
            imagePath = "3.jpg";
            break;
          case "Rain":
            imagePath = "2.jpg";
            break;
          case "Snow":
            imagePath = "cloudy.jpg";
            break;
          case "Drizzle":
            imagePath = "5.jpg";
            break;
          case "Atmosphere":
            imagePath = "animated_sunny.jpg";
            break;
          default:
            imagePath = "animated_mountain.jpg";
        }
        return Container(
          width: 320,
          height: 360,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/$imagePath"),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: const Color.fromARGB(255, 56, 78, 96),
              width: 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          city,
                          style: const TextStyle(
                            fontFamily: 'My3',
                            color: Color.fromARGB(205, 4, 20, 54),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Today',
                          style: TextStyle(
                            fontFamily: 'My3',
                            color: Color.fromARGB(205, 4, 20, 54),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          cityWeatherProvider.formatTime(cityWeatherProvider
                                      .currentWeather?.timezone) !=
                                  'null'
                              ? cityWeatherProvider.formatTime(
                                  cityWeatherProvider.currentWeather?.timezone)
                              : '',
                          style: const TextStyle(
                            fontFamily: 'My3',
                            color: Color.fromARGB(205, 4, 20, 54),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Center(
                  child: Consumer<CityWeatherProvider>(
                    builder: (context, cityWeatherProvider, child) {
                      return Text(
                        cityWeatherProvider.temperatureInCelsius != 'null'
                            ? '${cityWeatherProvider.temperatureInCelsius}°C'
                            : '',
                        style: const TextStyle(
                          fontFamily: 'My3',
                          color: Color.fromARGB(205, 4, 20, 54),
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 15),
                Center(
                  child: Text(
                    cityWeatherProvider.currentWeather != null &&
                            cityWeatherProvider.currentWeather!.weather !=
                                'null' &&
                            cityWeatherProvider
                                .currentWeather!.weather!.isNotEmpty
                        ? '${cityWeatherProvider.currentWeather!.weather![0].main}'
                        : '',
                    style: const TextStyle(
                      fontFamily: 'My3',
                      color: Color.fromARGB(205, 4, 20, 54),
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    cityWeatherProvider.feellike_temperatureInCelsius != 'null'
                        ? 'Feel Like ${cityWeatherProvider.feellike_temperatureInCelsius}°C'
                        : '',
                    style: const TextStyle(
                      fontFamily: 'My3',
                      color: Color.fromARGB(205, 4, 20, 54),
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(height: 80),
                Expanded(
                    child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    // OtherFactor(
                    //   FactorName: 'Wind',
                    //   icon: Icons.air,
                    //   val: cityWeatherProvider.currentWeather != null &&
                    //           cityWeatherProvider.currentWeather!.wind != null
                    //       ? '${cityWeatherProvider.currentWeather!.wind!.speed} km/h'
                    //       : '',
                    // ),
                    //  SizedBox(width: 10),
                    // OtherFactor(
                    //   FactorName: 'Pressure',
                    //   icon: Icons.ac_unit,
                    //   val: cityWeatherProvider.currentWeather != null &&
                    //           cityWeatherProvider
                    //                   .currentWeather!.main!.pressure !=
                    //               null
                    //       ? '${cityWeatherProvider.currentWeather!.main!.pressure} MB'
                    //       : '',
                    // ),
                    //  SizedBox(width: 10),
                    // OtherFactor(
                    //   FactorName: 'Humidity',
                    //   icon: Icons.water_drop,
                    //   val: cityWeatherProvider.currentWeather != null &&
                    //           cityWeatherProvider
                    //                   .currentWeather!.main!.humidity !=
                    //               null
                    //       ? '${cityWeatherProvider.currentWeather!.main!.humidity}%'
                    //       : '',
                    // ),
                    //  SizedBox(width: 10),
                    OtherFactor(
                      FactorName: 'Sea Level',
                      icon: Icons.waves,
                      val: cityWeatherProvider.currentWeather != null &&
                              cityWeatherProvider
                                      .currentWeather!.main!.seaLevel !=
                                  null
                          ? '${cityWeatherProvider.currentWeather!.main!.seaLevel} km'
                          : '',
                    ),
                    const SizedBox(width: 10),
                    OtherFactor(
                      FactorName: 'Cloudiness',
                      icon: Icons.cloud,
                      val: cityWeatherProvider.currentWeather != null &&
                              cityWeatherProvider.currentWeather!.clouds!.all !=
                                  null
                          ? '${cityWeatherProvider.currentWeather!.clouds!.all}%'
                          : '',
                    ),
                    const SizedBox(width: 10),
                    OtherFactor(
                      FactorName: 'Ground Level',
                      icon: Icons.terrain,
                      val: cityWeatherProvider.currentWeather != null &&
                              cityWeatherProvider
                                      .currentWeather!.main!.grndLevel !=
                                  null
                          ? '${cityWeatherProvider.currentWeather!.main!.grndLevel} km'
                          : '',
                    ),
                    //  SizedBox(width: 10),
                    // OtherFactor(
                    //   FactorName: 'Sun Rise',
                    //   icon: Icons.wb_sunny, // Relevant icon for sunrise
                    //   val: cityWeatherProvider.currentWeather != null &&
                    //           cityWeatherProvider
                    //                   .currentWeather!.sys!.sunrise !=
                    //               null
                    //       ? _formatTime(
                    //           cityWeatherProvider.currentWeather!.sys!.sunrise!)
                    //       : '',
                    // ),
                    //  SizedBox(width: 10),
                    // OtherFactor(
                    //   FactorName: 'Sun Rise',
                    //   icon: Icons.nightlight_round,
                    //   val: cityWeatherProvider.currentWeather != null &&
                    //           cityWeatherProvider.currentWeather!.sys!.sunset !=
                    //               null
                    //       ? _formatTime(
                    //           cityWeatherProvider.currentWeather!.sys!.sunset!)
                    //       : '',
                    // ),
                  ],
                )),
              ],
            ),
          ),
        );
      },
    );
  }
}
