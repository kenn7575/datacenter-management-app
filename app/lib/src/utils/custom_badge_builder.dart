import 'package:flutter/material.dart';

Widget customBadgeBuilder(String text, Color bgColor, Color textColor,
    {Color? borderColor}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: 1.5,
        )),
    child: Text(
      text,
      style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
    ),
  );
}
