import 'package:flutter/material.dart';
import 'package:our_weather/custom_widgets/mylist_tile2.dart';
import 'package:provider/provider.dart';
import '../providers/currentweather_provider.dart';

class ForecastDetail extends StatefulWidget {
  @override
  _ForecastDetailState createState() => _ForecastDetailState();
}

class _ForecastDetailState extends State<ForecastDetail> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CityWeatherProvider>(builder: (context, obj, child) {
      return Container(
        height: 200,
        width: 400,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Today',
                  style: TextStyle(
                    fontFamily: 'My3',
                    color: Color.fromARGB(205, 4, 20, 54),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                // Text(
                //   "Next 24 hours",
                //   style: TextStyle(
                //     fontFamily: 'My3',
                //     color: Colors.black,
                //     fontSize: 13,
                //     decoration: TextDecoration.underline,
                //   ),
                // ),
              ],
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 9,
                itemBuilder: (context, index) {
                  if (obj.daysWeather == null ||
                      obj.daysWeather!.list.isEmpty) {
                    return CustomListTile(
                      day_no: '',
                      day: '',
                      iconData: Icons.error,
                      temperature: '',
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: CustomListTile(
                        day_no: obj.formatHourDateTime(
                            obj.daysWeather!.list[index].dtTxt),
                        day: obj.formatHourTimeDateTime(
                            obj.daysWeather!.list[index].dtTxt),
                        iconData: obj.getWeatherIcon(double.parse(
                            obj.day_weatherInCelcius(obj
                                .daysWeather!.list[index].main.temp
                                .toDouble()))),
                        temperature:
                            '${obj.day_weatherInCelcius(obj.daysWeather!.list[index].main.temp.toDouble())}°',
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
