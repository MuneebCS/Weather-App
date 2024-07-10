import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/currentweather_provider.dart';
import 'map_implementation.dart';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color.fromARGB(255, 103, 115, 126),
          width: 0.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      width: 320,
      height: 230,
      child: Stack(
        children: [
          MyMap(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Consumer<CityWeatherProvider>(
                  builder: (context, cityWeatherProvider, child) {
                    String city = cityWeatherProvider.currentCity;
                    return Expanded(
                      child: Row(
                        children: [
                          Text(
                            city,
                            style: const TextStyle(
                              fontFamily: 'My3',
                              color: Color.fromARGB(205, 4, 20, 54),
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          Spacer(),
                          Text(
                            cityWeatherProvider.formatTime(cityWeatherProvider
                                        .currentWeather?.timezone) !=
                                    'null'
                                ? cityWeatherProvider.formatTime(
                                    cityWeatherProvider
                                        .currentWeather?.timezone)
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
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
