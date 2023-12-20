import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_app/views/homescreen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      SizedBox(
        height: double.infinity,
        child: Image.asset("assets/images/2.jpg", fit: BoxFit.fill),
      ),
      Container(
        alignment: Alignment.center,
        height: double.infinity,
        width: double.infinity,
        child: Text(
          "Fasten Your SeatBelts Gentleman's Weather is About to Change 👿👿",
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
          ),
        ),
      ),
    ]));
  }
}
