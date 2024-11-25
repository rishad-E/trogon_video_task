import 'package:flutter/material.dart';

Widget preferedBox({double? height, double? width}) =>
    SizedBox(height: height, width: width);

Widget moduleTile(
    {required String title,
    required String description,
    required void Function()? onPressed,
    required String type}) {
  return ListTile(
    title: Text(
      title,
      style: const TextStyle(
          color: Color.fromARGB(255, 69, 69, 69),
          fontSize: 16,
          fontWeight: FontWeight.w600),
    ),
    subtitle: Text(
      description,
      style: const TextStyle(
          color: Color.fromARGB(255, 115, 114, 114),
          fontSize: 14,
          fontWeight: FontWeight.w400),
    ),
    trailing: TextButton(
      style: const ButtonStyle(visualDensity: VisualDensity.compact),
      onPressed: onPressed,
      child: Text(
        type == "watch video" ? "watch video" : "click here",
        style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.underline,
            decorationColor: Colors.red),
      ),
    ),
    shape: RoundedRectangleBorder(
      side: BorderSide(
        width: 1.5,
        color: Colors.black.withOpacity(0.3),
      ),
      borderRadius: BorderRadius.circular(15),
    ),
  );
}
