import 'package:flutter/cupertino.dart';
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
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool isSearchTapped = false;
  late AnimationController _controller;
  late Animation<double> _heightAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 450),
      vsync: this,
    );
    _heightAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Consumer<CityWeatherProvider>(
        builder: (context, cityWeatherProvider, child) {
          if (cityWeatherProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isSearchTapped = !isSearchTapped;
                        if (isSearchTapped) {
                          _controller.forward();
                        } else {
                          _controller.reverse();
                        }
                      });
                    },
                    icon: Icon(
                      isSearchTapped ? Icons.close : Icons.search,
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizeTransition(
                        sizeFactor: _heightAnimation,
                        axisAlignment: -1.0,
                        child:
                            isSearchTapped ? MySearchBar() : SizedBox.shrink(),
                      ),
                      const SizedBox(height: 10),
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
          }
        },
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final cityWeatherProvider = Provider.of<CityWeatherProvider>(context);
    if (!cityWeatherProvider.isLoading) {
      setState(() {
        isSearchTapped = false;
        _controller.reverse();
      });
    }
  }
}
