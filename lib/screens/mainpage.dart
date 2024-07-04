import 'package:flutter/material.dart';
import 'package:our_weather/custom_widgets/gradient_background.dart';
import 'package:our_weather/screens/homepage.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: const EdgeInsets.all(27),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 280,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage("assets/images/animated_cloud.png"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: const Color.fromARGB(255, 10, 127, 194),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Forecast Freedom Weather at Your Fingertips",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'My3',
                  color: Color.fromARGB(255, 1, 35, 62),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Seamless Access to Accurate Forecasts, Anytime, Anywhere!!!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'My1',
                  color: Color.fromARGB(255, 41, 151, 241),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 233, 224, 224),
                    backgroundColor: const Color(0xFF24A4F5),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    "Get Started",
                    style: TextStyle(fontFamily: 'My3'),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
