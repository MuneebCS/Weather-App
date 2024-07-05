import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:our_weather/providers/currentweather_provider.dart';
import 'package:provider/provider.dart';

class MySearchBar extends StatefulWidget {
  @override
  _MySearchBarState createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateCity() async {
    final city = _controller.text;
    if (!mounted) return;

    if (city.isNotEmpty) {
      CityWeatherProvider myProvider =
          Provider.of<CityWeatherProvider>(context, listen: false);
      try {
        if (!mounted) return;
        await myProvider.fetchWeather(city);

        if (myProvider.errorMsg.isNotEmpty) {
          Fluttertoast.showToast(
            msg: myProvider.errorMsg,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          myProvider.clearError();
        }
        _controller.clear();
      } catch (ex) {
        if (!mounted) return;
        Fluttertoast.showToast(
          msg: "An unexpected error occurred: $ex",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        myProvider.clearError();
        _controller.clear();
      }
    } else {
      Fluttertoast.showToast(
        msg: "City name cannot be empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 103, 115, 126),
          width: 0.5,
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          hintText: 'Search City',
          hintStyle: const TextStyle(color: Colors.grey),
          border: InputBorder.none,
          suffixIcon: GestureDetector(
            onTap: _updateCity,
            child: const Icon(Icons.search, color: Colors.grey),
          ),
        ),
        style: const TextStyle(color: Colors.black87, fontFamily: 'My3'),
        cursorColor: Colors.blue,
        onSubmitted: (value) {
          _updateCity();
        },
      ),
    );
  }
}
