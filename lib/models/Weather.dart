import 'package:flutter/foundation.dart';

class Weather {
  final String location;
  final double temperature;
  final String mainCondition;
  final String iconUrl;

  Weather({
    required this.location,
    required this.temperature,
    required this.mainCondition,
    required this.iconUrl,
  });
}
