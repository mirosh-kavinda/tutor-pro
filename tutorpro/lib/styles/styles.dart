import 'package:flutter/material.dart';

class Styles {
  static BoxDecoration homeContainer = const BoxDecoration(
    color: Color.fromRGBO(38, 93, 114, 1),
  );

  static TextStyle baseText = const TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: Colors.black,
  );

  static TextStyle titleText = const TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: Color.fromRGBO(253, 251, 255, 1),
  );

  static TextStyle subtitleText = const TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: Color.fromRGBO(253, 251, 255, 1),
  );

  static Map<String, dynamic> containerStyle = {
    'maxWidth': 480.0,
    'width': double.infinity,
   'margin': const EdgeInsets.symmetric(horizontal: 0.0), // Set a specific value like 0.0 or any number of pixels
  };

  static Map<String, dynamic> imageContainerStyle = {
    'aspectRatio': 0.462,
    'paddingBottom': 65.0,
  };

  static Map<String, dynamic> backgroundImageStyle = {
    'fit': BoxFit.cover,
    'position': 'absolute',
  };

  static Map<String, dynamic> profileImageStyle = {
    'aspectRatio': 0.59,
    'fit': BoxFit.contain,
    'borderRadius': BorderRadius.circular(1000), // Large value for circle
  };

  static Map<String, dynamic> textContainerStyle = {
    'marginTop': 56.0,
    'marginRight': 30.0,
    'textAlign': TextAlign.right,
  };
}