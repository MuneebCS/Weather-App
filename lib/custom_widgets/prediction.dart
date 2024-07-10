import 'package:flutter/material.dart';
import 'package:our_weather/custom_widgets/mylist_tile.dart';
import 'package:provider/provider.dart';

import '../providers/currentweather_provider.dart';

class WeatherPrediction extends StatefulWidget {
  @override
  _WeatherPredictionState createState() => _WeatherPredictionState();
}

class _WeatherPredictionState extends State<WeatherPrediction> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CityWeatherProvider>(builder: (context, obj, child) {
      return Container(
        height: 350,
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Prediction',
                  style: TextStyle(
                    fontFamily: 'My3',
                    color: Color.fromARGB(205, 4, 20, 54),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "Next 5 days",
                  style: TextStyle(
                    fontFamily: 'My3',
                    color: Colors.black,
                    fontSize: 13,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Column(
              children: [
                _buildListTile(obj, 5),
                const SizedBox(
                  height: 8,
                ),
                _buildListTile(obj, 13),
                const SizedBox(
                  height: 8,
                ),
                _buildListTile(obj, 21),
                const SizedBox(
                  height: 8,
                ),
                _buildListTile(obj, 29),
                const SizedBox(
                  height: 8,
                ),
                _buildListTile(obj, 37),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildListTile(CityWeatherProvider obj, int index) {
    if (obj.daysWeather != null && obj.daysWeather!.list.length > index) {
      var weatherItem = obj.daysWeather!.list[index];
      return CustomListTile(
        date: obj.formatDateTime(weatherItem.dtTxt),
        temperature:
            '${obj.day_weatherInCelcius(weatherItem.main.temp.toDouble())}°',
        iconPath: obj.getWeatherIcon(double.parse(
            obj.day_weatherInCelcius(weatherItem.main.temp.toDouble()))),
      );
    } else {
      return CustomListTile(
        date: '',
        temperature: '',
        iconPath: "no",
      );
    }
  }
}
