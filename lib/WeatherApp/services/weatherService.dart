import 'dart:convert';

import 'package:flutter_ui_design/WeatherApp/model/Weather.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherService{   //treat this as normal class you know
  static const base_url = "https://api.openweathermap.org/data/2.5/weather";
  final String Apikey;

  WeatherService(this.Apikey);
  
  Future<Weather> fetchWeather(String cityName) async {
    final response = await http.get(Uri.parse('$base_url?q=$cityName&appid=$Apikey&units=metric')); //&units=metric returns it using celsius

    if(response.statusCode == 200){
      final json = jsonDecode(response.body);
      return Weather.fromJson(json);    //change json to weather object
    }else{
      throw Exception('failed to get weather');
    }
  }

  //just ask user for location permission and convert that to city name, one issue is the code also adds local name for the city name like Addis ababa in amharic along side it so we use regex to remove non english letters
  Future<String> getCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    // Attempt to extract the city name, Remove non-Latin characters and trim whitespace, Further clean up: remove any remaining non-alphabetic characters
    String cityName = placemarks[0].locality ?? placemarks[0].name ?? "";
    cityName = cityName.replaceAll(RegExp(r'[^\x00-\x7F]+'), '').trim();
    cityName = cityName.replaceAll(RegExp(r'[^a-zA-Z\s]'), '');

    return cityName.isNotEmpty ? cityName : "Unknown city";
  }
}

