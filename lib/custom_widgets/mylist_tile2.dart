import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String day_no;
  final String day;
  final IconData iconData;
  final String temperature;

  const CustomListTile({
    super.key,
    required this.day_no,
    required this.day,
    required this.iconData,
    required this.temperature,
  });

  get mainAxisAlignment => null;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: const Color.fromARGB(255, 103, 115, 126),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              day_no,
              style: const TextStyle(
                fontFamily: 'My3',
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 1,
            ),
            Text(
              day,
              style: const TextStyle(
                fontFamily: 'My3',
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Icon(
              iconData,
              size: 35,
              color: const Color.fromARGB(255, 54, 160, 231),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              temperature.toString(),
              style: const TextStyle(
                  fontFamily: 'My3',
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
