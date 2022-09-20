import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_update/pages/settings_page.dart';
import 'package:weather_update/pages/weather_page.dart';
import 'package:weather_update/providers/weather_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create:(_)=>WeatherProvider();
  child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "MerriweatherSans",
        primarySwatch: Colors.blue,
      ),
      initialRoute: WeatherPage.routeName,
      routes: {
        SettingsPage.routeName:(_)=>SettingsPage(),
        WeatherPage.routeName:(_)=>WeatherPage()
      },
    );
  }
}

