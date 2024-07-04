import 'package:flutter/material.dart';

class Factor extends StatefulWidget {
  final String FactorName;
  final IconData icon;
  final String val;

  const Factor({
    Key? key,
    required this.FactorName,
    required this.icon,
    required this.val,
  }) : super(key: key);

  @override
  _FactorState createState() => _FactorState();
}

class _FactorState extends State<Factor> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 70,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color.fromARGB(255, 2, 46, 82),
                  width: 0.5,
                ),
              ),
              child: Icon(
                widget.icon,
                color: const Color.fromARGB(255, 1, 71, 128),
                size: 25,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.FactorName,
                    style: const TextStyle(
                      fontFamily: 'My3',
                      color: Color.fromARGB(255, 72, 78, 96),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.val,
                    style: const TextStyle(
                      fontFamily: 'My3',
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
