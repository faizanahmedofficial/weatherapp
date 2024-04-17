import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherapp_starter_project/controller/global_controller.dart';
import 'package:weatherapp_starter_project/utils/custom_colors.dart';
import 'package:weatherapp_starter_project/widgets/comfort_level.dart';
import 'package:weatherapp_starter_project/widgets/current_weather_widget.dart';
import 'package:weatherapp_starter_project/widgets/daily_data_forecast.dart';
import 'package:weatherapp_starter_project/widgets/header_widget.dart';
import 'package:weatherapp_starter_project/widgets/hourly_data_widget.dart';

import '../controller/theme_controller.dart';
import '../widgets/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // call
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);
  final TextEditingController _searchController = TextEditingController();


  String? city;
  final GlobalKey<ScaffoldState> _key = GlobalKey();


  @override
  Widget build(BuildContext context) {


    return Obx(() => globalController.checkLoading().isTrue
        ? Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/icons/back.jpg"),fit: BoxFit.cover),

        ),
        child: Center(child: Text("Weather App",style: TextStyle(  color: Theme.of(context).textTheme.bodyText1?.color,
          fontWeight: FontWeight.w600,
          fontSize: 40
        ),)),

          ),
    )
        : Scaffold(
      appBar: AppBar(

      ),
      key: _key,
      drawer: Drawer(child: DrawerView()),
      body: SafeArea(
        child: Center(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        style: TextStyle(fontSize: 20),
                        controller: _searchController,
                        decoration: const InputDecoration(
                            hintText: 'Enter city name',
                            hintStyle: TextStyle(fontSize: 20)
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search, size: 22,),
                      onPressed: () {
                        globalController.fetchWeatherByCityName(
                          _searchController.text,
                        );
                        city = _searchController.text;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              HeaderWidget(city: city,),
              // for our current temp ('current')
              CurrentWeatherWidget(
                weatherDataCurrent:
                globalController.getData().getCurrentWeather(),
              ),
              const SizedBox(
                height: 20,
              ),
              HourlyDataWidget(
                  weatherDataHourly:
                  globalController.getData().getHourlyWeather()),
              DailyDataForecast(
                weatherDataDaily:
                globalController.getData().getDailyWeather(),
              ),
              Container(
                height: 1,
                color: CustomColors.dividerLine,
              ),
              const SizedBox(
                height: 10,
              ),
              ComfortLevel(
                  weatherDataCurrent:
                  globalController.getData().getCurrentWeather())
            ],
          ),
        ),
      ),
    ));
  }
}
