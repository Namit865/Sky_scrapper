import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/provider.dart';
import 'package:weather_app/variable/weatherVariables.dart';

import '../helper/apikey.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _searchconntroller = TextEditingController();
  Weatherdata weatherdata = Weatherdata();

  @override
  void initState() {
    super.initState();
    fetchdata("Rajkot");
  }

  Future<void> fetchdata(String cityname) async {
    Weatherdata data = await ApiHelper.apiHelper.fetchData(cityname);
    weatherdata = data;
    setState(() {});
  }

  String currentDay() {
    DateTime now = DateTime.now();
    const List<String> days = <String>[
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    return days[now.weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<providers>(context);
    var isDarkMode = provider.themeDetails.isdark;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/1.jpg"), fit: BoxFit.fill),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.location_on_sharp,
                    color: Colors.white,
                  ),
                  Text(
                    weatherdata.location,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  Text(",${weatherdata.region}",
                      style:
                          const TextStyle(color: Colors.white, fontSize: 12)),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Provider.of<providers>(context, listen: false)
                          .themeToggle();
                    },
                    icon: Provider.of<providers>(context).themeDetails.isdark
                        ? const Icon(CupertinoIcons.moon_stars,color: Colors.white,)
                        : const Icon(CupertinoIcons.cloud_sun_rain_fill,color: Colors.white,),
                  ),
                  const SizedBox(width: 12),
                  const Icon(
                    CupertinoIcons.bell,
                    color: Colors.white,
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    height: 50,
                    width: 400,
                    child: TextField(
                      cursorColor: Colors.white70,
                      controller: _searchconntroller,
                      style: const TextStyle(color: Colors.white),
                      onChanged: (value) {
                        fetchdata(value);
                      },
                      decoration: const InputDecoration(
                        hintText: "Search",
                        hintStyle: TextStyle(fontSize: 18, color: Colors.white),
                        prefixIcon: Icon(
                          CupertinoIcons.search,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 180,
                width: 180,
                child: Image.network(
                  "http:${weatherdata.weatherImage}",
                  fit: BoxFit.fill,
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: weatherdata.tempraturecelsius,
                      style:  TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white: Colors.black
                      ),
                    ),
                    const TextSpan(
                      text: "°",
                      style: TextStyle(fontSize: 40),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                weatherdata.weathercondition,
                style:  TextStyle(
                    color: isDarkMode ? Colors.white: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 350,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: isDarkMode ? Colors.black45: Colors.white54,),
                child: Row(
                  children: [
                    const SizedBox(width: 15),
                    const Icon(
                      Icons.water_drop_rounded,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "${weatherdata.precipitation}mm",
                      style:  TextStyle(fontSize: 16, color: isDarkMode ? Colors.white: Colors.black,),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.thermostat_rounded,
                      color: Colors.white,
                    ),
                    Text(
                      weatherdata.feelslike,
                      style:  TextStyle(
                          fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white: Colors.black,),
                    ),
                    const Spacer(),
                    const Icon(
                      CupertinoIcons.wind,
                      color: Colors.white,
                    ),
                    Text(
                      "${weatherdata.windspeed}km/h",
                      style:  TextStyle(
                          color: isDarkMode ? Colors.white: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                height: 270,
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: isDarkMode ? Colors.black45: Colors.white54,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Text(
                          currentDay(),
                          style: TextStyle(
                              color: isDarkMode ? Colors.white: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                        const Spacer(),
                        Text(
                          weatherdata.date,
                          style:  TextStyle(
                              fontSize: 25, color: isDarkMode ? Colors.white: Colors.black,),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Uv -------------------------------------- ${weatherdata.Uv}",
                              style:  TextStyle(
                                fontSize: 20,
                                color: isDarkMode ? Colors.white: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Clouds ------------------------------- ${weatherdata.clouds}",
                              style: TextStyle(
                                fontSize: 20,
                                color: isDarkMode ? Colors.white: Colors.black,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Visibilty ------------------------------ ${weatherdata.visibility}",
                              style:  TextStyle(
                                fontSize: 20,
                                color: isDarkMode ? Colors.white: Colors.black,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Wind Direction -------------------- ${weatherdata.visibility}",
                              style:  TextStyle(
                                fontSize: 20,
                                color: isDarkMode ? Colors.white: Colors.black,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Humidity ----------------------------- ${weatherdata.humidity}",
                              style: TextStyle(
                                fontSize: 20,
                                color: isDarkMode ? Colors.white: Colors.black,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
