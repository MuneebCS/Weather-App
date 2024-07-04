import 'package:flutter/material.dart';

class OtherFactor extends StatefulWidget {
  final String FactorName;
  final IconData icon;
  final String val;

  const OtherFactor({
    Key? key,
    required this.FactorName,
    required this.icon,
    required this.val,
  }) : super(key: key);

  @override
  _OtherFactorState createState() => _OtherFactorState();
}

class _OtherFactorState extends State<OtherFactor> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color.fromARGB(255, 103, 115, 126),
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              widget.icon,
              color: const Color.fromARGB(255, 1, 71, 128),
              size: 30,
            ),
            const SizedBox(height: 1),
            Text(
              widget.FactorName,
              style: const TextStyle(
                fontFamily: 'My3',
                color: Color.fromARGB(255, 11, 66, 229),
                fontSize: 12,
              ),
            ),
            Text(
              widget.val,
              style: const TextStyle(
                  fontFamily: 'My3', color: Colors.black, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
