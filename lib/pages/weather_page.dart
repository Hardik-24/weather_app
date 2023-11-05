import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('175d25a78df381d422f75b910d238acc');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      // ignore: avoid_print
      print('$e');
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) {
      return 'assets/sunny.json';
    }
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff164863),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            _weather?.cityName ?? 'loading city...',
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 45),
          ),
          const SizedBox(height: 70),
          Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
          const SizedBox(height: 70),
          Text(
            '${_weather?.temperature}°',
            style: GoogleFonts.poppins(
                color: Color(0xffDDF2FD),
                fontSize: 25,
                fontWeight: FontWeight.w500),
          ),
        ]),
      ),
    );
  }
}
