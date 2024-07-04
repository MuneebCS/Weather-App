import 'package:flutter/material.dart';
import 'package:our_weather/custom_widgets/current_weather_detail.dart';
import 'package:our_weather/custom_widgets/gradient_background.dart';
import 'package:our_weather/custom_widgets/map_view.dart';
import 'package:our_weather/custom_widgets/weather_details.dart';
import 'package:our_weather/custom_widgets/prediction.dart';
import 'package:our_weather/custom_widgets/customized_searchbar.dart';
import 'package:provider/provider.dart';

import '../custom_widgets/weather_forcast_detail.dart';
import '../providers/currentweather_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return CustomBackground(child: Consumer<CityWeatherProvider>(
      builder: (context, cityWeatherProvider, child) {
        if (cityWeatherProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  MySearchBar(),
                  const SizedBox(height: 20),
                  const CurrentWeatherDetail(),
                  const SizedBox(height: 20),
                  ForecastDetail(),
                  const SizedBox(height: 20),
                  MapView(),
                  const SizedBox(height: 20),
                  WeatherDetails(),
                  const SizedBox(height: 20),
                  WeatherPrediction(),
                ],
              ),
            ),
          ),
        );
      },
    ));
  }
}
