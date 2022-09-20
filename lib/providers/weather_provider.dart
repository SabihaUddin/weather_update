import 'package:flutter/material.dart';
import 'package:weather_update/models/current_response_model.dart';
import 'package:weather_update/models/forecast_response_model.dart';
import 'package:weather_update/utils/constant.dart';

class WeatherProvider extends ChangeNotifier{
CurrentResponseModel? currentResponseModel;
ForecastResponseModel? forecastResponseModel;
double latitude=0.0;
double longitude=0.0;
String unit='metric';
String unitSymbol=celcius;

setNewLocation(double lat,double lng){
  latitude=lat;
  longitude=lng;
}
getWeatherData(){
  _getCurrentData();
  _getForecastData();
}

  void _getCurrentData() {}

  void _getForecastData() {}



}