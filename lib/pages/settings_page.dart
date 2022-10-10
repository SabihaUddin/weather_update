import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_update/providers/weather_provider.dart';

class SettingsPage extends StatelessWidget {
  static String routeName='/settings';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Consumer<WeatherProvider>(
        builder: (context,provider,child)=>ListView(
          padding: EdgeInsets.all(8),
          children: [SwitchListTile(
              title:const Text('Show temperature in Fahrenheit'),
              subtitle: const Text('Default is Celcius'),
              value: provider.isFahrenheit,
              onChanged: (value) async{
                provider.setTemUnit(value);
                await provider.setTempUnitPreferenceValue(value);
                provider.getWeatherData();
          })],

        ),
      ),
    );
  }
}
