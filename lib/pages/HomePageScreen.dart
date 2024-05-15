import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapi/pages/HelpScreen.dart';
import '../Services/Weather_Service.dart';
import '../models/Weather.dart';
import '../const/consts.dart';
import 'TemperatureView.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _locationController = TextEditingController();
  final _weatherService = WeatherService(OpenWeather_API_Key);
  Weather? _weather;
  bool _isLocationEmpty = true;

  @override
  void initState() {
    super.initState();
    _fetchWeatherForCurrentLocation();
  }

  Future<void> _fetchWeatherForCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
      );
      String latitude = position.latitude.toString();
      String longitude = position.longitude.toString();

      Map<String, dynamic> weatherData =
      await _weatherService.getWeatherByCoordinates(latitude, longitude);

      setState(() {
        _weather = Weather(
          location: weatherData['name'],
          temperature: weatherData['main']['temp'].toDouble(),
          mainCondition: weatherData['weather'][0]['main'],
          iconUrl: 'https:' + weatherData['weather'][0]['icon'],
        );
      });
    } catch (e) {
      print('Error fetching weather: $e');
      // Handle error (e.g., show error message to user)
    }
  }

  void _updateWeather() async {
    String location = _locationController.text.trim();
    if (location.isEmpty) {
      // Fetch weather for current location if location field is empty
      await _fetchWeatherForCurrentLocation();
      setState(() {
        _isLocationEmpty = false;
      });
    } else {
      // Fetch weather based on user-entered location
      await _fetchWeather(location);
      setState(() {
        _isLocationEmpty = false;
      });
    }
  }

  Future<void> _fetchWeather(String location) async {
    try {
      Map<String, dynamic> weatherData =
      await _weatherService.getWeather(location);

      setState(() {
        _weather = Weather(
          location: weatherData['name'],
          temperature: weatherData['main']['temp'].toDouble(),
          mainCondition: weatherData['weather'][0]['main'],
          iconUrl: 'https:' + weatherData['weather'][0]['icon'],
        );
      });
    } catch (e) {
      print('Error fetching weather: $e');
      // Handle error (e.g., show error message to user)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HelpScreen()));
            },
            icon: Icon(Icons.help),
          ),
        ],
      ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
              TextField(
              controller: _locationController,
              onChanged: (value) {
                setState(() {
                  _isLocationEmpty = value.isEmpty;
                });
              },
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black38),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black38),
                ),
                fillColor: Colors.white,
                filled: true,
                hintStyle: TextStyle(color: Colors.grey[500]),
                hintText: 'Enter location name',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateWeather,
              child: Text(_isLocationEmpty ? 'Save' : 'Update'),
            ),
            SizedBox(height: 20),
            if (_weather != null)
        TemperatureView(weather: _weather!),
    // else
    // Container(
    // child: Text('Weather data not available'),
    // ),
    ],
    ),
    ),
    );
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }
}
