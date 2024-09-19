// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_design/WeatherApp/model/Weather.dart';
import 'package:flutter_ui_design/WeatherApp/services/weatherService.dart';
import 'package:flutter_ui_design/WeatherApp/themeNotifier.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class homepage extends StatefulWidget {
  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  // provide api key and create weather object
  final _weatherService = WeatherService('7fd69302ee67485a28b662bcdf336157');
  Weather? _weather;

  _fetchWeather() async{
    //get city name
    String cityName = await _weatherService.getCity();

    try{
      // get weather from city name
      final weather = await _weatherService.fetchWeather(cityName);

      // initialize weather object and rebuild ui
      setState((){
        _weather = weather;
      });

    }catch(e){
      print(e);
    }
  }

  String _getWeatherAnimation(String condition){
    switch(condition){
      case 'Clouds':
      case 'Fog':
      case 'Dust':
      case 'Mist':
      case 'Smoke':
        return 'assets/cloud.json';
      case 'Rain':
      case 'Drizzle':
      case 'Shower rain':
      case 'Thunderstorm':
        return 'assets/rainy.json';
      case 'Sunny':
      case 'Clear':
        return 'assets/sunny.json';

        default:
          return 'assets/sunCloud.json';
    }
  }

  // immediately fetches weather when the app opens instead of pressing a button

  @override
  void initState(){
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top:50),
            alignment: Alignment.topRight,
            child: IconButton(
                onPressed: (){
                  Provider.of<ThemeNotifier>(context, listen: false).ToggleTheme();
                },
                icon: Icon(Icons.sunny, size: 30,),
            ),
          ),

          Expanded(
              child:Center(
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _weather != null ? Text(_weather!.cityName, style: TextStyle(fontSize: 20),) : Text('...Loading'),
                      _weather != null ? Lottie.asset(_getWeatherAnimation(_weather?.condition ?? 'Sunny')) : CircularProgressIndicator(),
                      SizedBox(height: 10,),
                      _weather != null? Text('${_weather!.temperature}°C',style: TextStyle(fontSize: 20),) : Text('...Loading'),
                      _weather != null? Text('${_weather!.condition}',style: TextStyle(fontSize: 20),) : Text('...Loading'),
                    ],
                  ),
                ),
              ),
          )

          //all this is b/c for null checking

        ],
      ),
    );
  }
}
