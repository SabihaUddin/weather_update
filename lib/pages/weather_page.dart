import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_update/pages/settings_page.dart';
import 'package:weather_update/providers/weather_provider.dart';
import 'package:weather_update/utils/constant.dart';
import 'package:weather_update/utils/helper_function.dart';
import 'package:weather_update/utils/location_services.dart';
import 'package:weather_update/utils/textstyle.dart';

class WeatherPage extends StatefulWidget {
  static String routeName = '/';

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
      backgroundColor: Colors.black,
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
      body: Center(
        child: provider.hasDataLoaded
            ? ListView(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                children: [
                  _currentWeatherSection(),
                  _forecasteWeatherSection()
                ],
              )
            : const Text(
                'Please wait....',
                style: TextStyle(color: Colors.white),
              ),
      ),
    );
  }

  void _detectLocation() async {
    final position = await determinePosition();

    provider.setNewLocation(position.latitude, position.longitude);
    provider.setTemUnit(await provider.getTempUnitPreferenceValue());
    provider.getWeatherData();
    setState(() {
      isFirst = false;
    });
  }

  Widget _currentWeatherSection() {
    final current = provider.currentResponseModel;
    if (current != null) {
      return Container(
            height: MediaQuery.of(context).size.height * .8,
            margin: const EdgeInsets.all(2),
            padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
            decoration: const BoxDecoration(
                color: Color(0xff00A1FF),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue,
                    blurRadius: 15.5,
                    spreadRadius: 5,
                  )
                ]),
        child: Column(
            children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                CupertinoIcons.square_grid_2x2,
                color: Colors.white,
              ),
              Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.white),
                  Text(
                    '${current.name},${current.sys!.country}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                ],
              ),
              IconButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, SettingsPage.routeName),
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.white,
                  )),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(width: 0.2, color: Colors.white),
                borderRadius: BorderRadius.circular(30)),
            child: Text(
              getFormattedDateTime(current.dt!, 'dd MMM yyyy'),
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          Image.asset(
            'images/thunder.png',
          ),
          Text(
            '${current.main!.temp!.round()}$degree${provider.unitSymbol}',
            style: txtTempBig80,
          ),
          Text(
            'feels like ${current.main!.feelsLike}$degree${provider.unitSymbol}',
            style: txtNormal16White54,
          ),
          const Divider(
            color: Colors.white,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Icon(
                    CupertinoIcons.wind,
                    color: Colors.white,
                  ),
                  Text(
                    '${current.wind!.speed}m/s ',
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                  Text(
                    "Wind",
                    style: TextStyle(
                      color: Colors.white.withOpacity(.6),
                      fontSize: 16,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  const Icon(
                    Icons.water_drop,
                    color: Colors.white,
                  ),
                  Text(
                    '${current.main!.humidity}% ',
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                  Text(
                    "Humidity",
                    style: TextStyle(
                      color: Colors.white.withOpacity(.6),
                      fontSize: 16,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  const Icon(
                    Icons.cloud,
                    color: Colors.white,
                  ),
                  Text(
                    '${current.main!.pressure}Kmh ',
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                  Text(
                    "Pressure",
                    style: TextStyle(
                      color: Colors.white.withOpacity(.6),
                      fontSize: 16,
                    ),
                  )
                ],
              )
            ],
          ),

          /*Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                '$iconPrefix${current.weather![0].icon}$iconSufix',
                fit: BoxFit.cover,
              ),
              Text(
                '${current.main!.temp!.round()}$degree${provider.unitSymbol}',
                style: txtTempBig80,
              )
            ],
          ),
          Text(
            'feels like ${current.main!.feelsLike}$degree${provider.unitSymbol}',
            style: txtNormal16White54,
          ),
          Text(
            '${current.weather![0].main} ${current.weather![0].description}',
            style: txtNormal16White54,
          ),
          const SizedBox(
            height: 20,
          ),
          Wrap(children: [
            Text(
              'Humidity: ${current.main!.humidity}% ',
              style: txtNormal16,
            ),
            Text(
              'Pressure: ${current.main!.pressure}hPa ',
              style: txtNormal16,
            ),
            Text(
              'Visibility: ${current.visibility}meter ',
              style: txtNormal16,
            ),
            Text(
              'Wind Speed: ${current.wind!.speed}meter/sec ',
              style: txtNormal16,
            ),
            Text(
              'Degree: ${current.wind!.deg}$degree ',
              style: txtNormal16,
            ),
          ]),*/
          const SizedBox(
            height: 20,
          ),
          Wrap(
            children: [
              Text(
                'Sunrise: ${getFormattedDateTime(current.sys!.sunrise!, 'hh:mm a')}',
                style: txtNormal16White54,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Sunset: ${getFormattedDateTime(current.sys!.sunset!, 'hh:mm a')}',
                style: txtNormal16White54,
              ),
            ],
          )
        ]),
      );
    }
    return const SizedBox();
  }

   _forecasteWeatherSection() {
    final forecast=provider.forecastResponseModel;
    if(forecast!=null){


    }
  }
}
