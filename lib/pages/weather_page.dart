import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:provider/provider.dart';
import 'package:weather_update/pages/settings_page.dart';
import 'package:weather_update/providers/weather_provider.dart';
import 'package:weather_update/utils/constant.dart';
import 'package:weather_update/utils/helper_function.dart';
import 'package:weather_update/utils/location_services.dart';
import 'package:weather_update/utils/textstyle.dart';

class WeatherPage extends StatefulWidget {
  static String routeName='/';
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late WeatherProvider provider;
  bool isFirst = true;

  @override
  void didChangeDependencies() {
    if (isFirst) {
      provider = Provider.of<WeatherProvider>(context);
      _detectLocation();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff030317),
      /*backgroundColor: Colors.blueGrey.shade900,
     appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Weather'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.my_location)),
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () =>
              Navigator.pushNamed(context, SettingsPage.routeName),
              icon: Icon(Icons.settings)),
        ],
      ),*/
      body: GlowContainer(
        height: MediaQuery.of(context).size.height - 190,
        margin: const EdgeInsets.all(2.0),
        padding:  const EdgeInsets.only(top: 50, left: 30, right: 30),
        glowColor: const Color(0xff00A1FF).withOpacity(0.5),
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
        color: const Color(0xff00A1FF),
        spreadRadius: 5,
        child: Center(
          child: provider.hasDataLoaded ? ListView(
            padding:const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            children: [
              _currentWeatherSection(),
              _forecasteWeatherSection()
            ],
          ) :
          const Text('Please wait....', style: TextStyle(color: Colors.white),),
        ),
      ),

    );
  }

  void _detectLocation() async {
    final position = await determinePosition();

    provider.setNewLocation(position.latitude, position.longitude);
    provider.setTemUnit(await provider.getTempUnitPreferenceValue());
    provider.getWeatherData();
}


  Widget _currentWeatherSection() {
    final current=provider.currentResponseModel;
    return Column(
      children: [
        Text(getFormattedDateTime(current!.dt!, 'MMM dd,yyyy'),style: txtDateBig18,),
        Text('${current.name},${current.sys!.country},',style: txtAddress25,),
        Padding(padding: const EdgeInsets.all(16),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network('$iconPrefix${current.weather![0].icon}$iconSufix',fit: BoxFit.cover,),
            Text('${current.main!.temp!.round()}$degree${provider.unitSymbol}', style: txtTempBig80,)
          ],

        )
    ),
    Text('feels like ${current.main!.feelsLike}$degree${provider.unitSymbol}', style: txtNormal16White54,),
    Text('${current.weather![0].main} ${current.weather![0].description}', style: txtNormal16White54,),
    const SizedBox(height: 20,),
    Wrap(
    children: [
    Text('Humidity: ${current.main!.humidity}% ', style: txtNormal16,),
    Text('Pressure: ${current.main!.pressure}hPa ', style: txtNormal16,),
    Text('Visibility: ${current.visibility}meter ', style: txtNormal16,),
    Text('Wind Speed: ${current.wind!.speed}meter/sec ', style: txtNormal16,),
    Text('Degree: ${current.wind!.deg}$degree ', style: txtNormal16,),
    ]
    ),
        const SizedBox(height: 20,),
        Wrap(
          children: [
            Text('Sunrise: ${getFormattedDateTime(current.sys!.sunrise!, 'hh:mm a')}', style: txtNormal16White54,),
            const SizedBox(width: 10,),
            Text('Sunset: ${getFormattedDateTime(current.sys!.sunset!, 'hh:mm a')}', style: txtNormal16White54,),
          ],
        )
    ]
    );
  }

  Widget _forecasteWeatherSection() {
    return Column();
  }
}
