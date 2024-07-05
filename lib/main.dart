import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:our_weather/providers/nextweathers_provider.dart';
import 'package:provider/provider.dart';
import 'screens/mainpage.dart';
import 'providers/currentweather_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => CityWeatherProvider()..loadFromPrefs()),
        ],
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove debug banner
      title: "Our Weather",
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },

      home: MainPage(),
    );
  }
}
