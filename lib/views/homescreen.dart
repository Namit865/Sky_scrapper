import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/variable/weatherVariables.dart';

import '../helper/apikey.dart';
import '../provider/provider.dart';

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

  int selectedColor = 0;

  @override
  Widget build(BuildContext context) {
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
                  Switch(
                    value: Provider.of<providers>(context)
                        .Theme
                        .isdark,
                    onChanged: (value) {
                      Provider.of<providers>(context,listen: false)
                          .themeToggle();
                    },
                  ),
                  SizedBox(
                    height: 50,
                    width: 150,
                    child: TextField(
                      controller: _searchconntroller,
                      style: const TextStyle(color: Colors.white),
                      onChanged: (value) async {
                        await fetchdata(value);
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
                  const SizedBox(width: 50),
                  const Icon(
                    CupertinoIcons.bell,
                    color: Colors.white,
                  ),
                ],
              ),
              const SizedBox(height: 60),
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
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
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
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 350,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black45),
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
                      "${weatherdata.precipitation}%",
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.thermostat_rounded,
                      color: Colors.white,
                    ),
                    Text(
                      weatherdata.feelslike,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const Spacer(),
                    const Icon(
                      CupertinoIcons.wind,
                      color: Colors.white,
                    ),
                    Text(
                      "${weatherdata.windspeed}km/h",
                      style: const TextStyle(
                          color: Colors.white,
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
                  color: Colors.black45,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Text(
                          currentDay(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                        const Spacer(),
                        Text(
                          weatherdata.date,
                          style: const TextStyle(
                              fontSize: 25, color: Colors.white),
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
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
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
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
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
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
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
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
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
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(15),
                height: 150,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  children: [],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
