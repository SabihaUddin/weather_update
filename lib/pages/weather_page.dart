import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_update/providers/weather_provider.dart';
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
  bool isFirst=true;
  @override
  void didChangeDependencies() {
    if(isFirst){
      provider=Provider.of<WeatherProvider>(context);
      _detectLocation();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Text('Weather'),
      actions: [
        IconButton(onPressed: (){}, icon: Icon(Icons.my_location)),
        IconButton(onPressed: (){}, icon: Icon(Icons.search)),
        IconButton(onPressed: (){}, icon: Icon(Icons.settings)),
      ],
    ),
body: Center(
  child: provider.hasDataLoaded? ListView(
    padding: EdgeInsets.symmetric(vertical: 20,horizontal: 12),
    children: [
      _currentWeatherSection(),
      _forecasteWeatherSection()
    ],
  ):
  Text('Please wait....',style: TextStyle(color: Colors.white),),
),

    );
  }

  void _detectLocation() {
    determinePosition().then((position){
      provider.setNewLocation(position.latitude,position.longitude);
      provider.getWeatherData();
    });
  }

  Widget _currentWeatherSection() {
    final current=provider.currentResponseModel;
    return Column(
      children: [
        Text(getFormattedDateTime(current!.dt!, 'MMM dd,yyyy'),style: txtDateBig18,)
      ],
    );
  }

  Widget _forecasteWeatherSection() {
    return Column();
  }
}
