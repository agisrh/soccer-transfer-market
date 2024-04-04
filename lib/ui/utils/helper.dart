import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget textWithStroke({
  required String text,
  String? fontFamily,
  double fontSize = 12,
  double strokeWidth = 1,
  Color textColor = Colors.white,
  Color strokeColor = Colors.black,
}) {
  return Stack(
    children: <Widget>[
      Text(
        text,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = strokeWidth
            ..color = strokeColor,
        ),
      ),
      Text(
        text,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    ],
  );
}

class StringHelper {
  static String shortDate({required String date}) {
    DateTime parseDate = DateFormat('yyyy-MM-dd').parse(date);
    String result = DateFormat('dd MMM yyyy').format(parseDate);

    return result;
  }
}
