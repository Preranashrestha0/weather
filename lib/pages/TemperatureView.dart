import 'package:flutter/material.dart';
import '../models/Weather.dart';

class TemperatureView extends StatelessWidget {
  final Weather weather;

  const TemperatureView({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.blue[100],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Current Temperature',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.thermostat_outlined,
                size: 30.0,
                color: Colors.blue,
              ),
              SizedBox(width: 10.0),
              Text(
                '${weather.temperature.round()}°C',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Text(
            'Location: ${weather.location}',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'Condition: ${weather.mainCondition}',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
