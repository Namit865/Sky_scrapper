import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/provider.dart';
import 'package:weather_app/views/splashscreen.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => providers(),
          child: const MyApp()),
    );

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => providers(),
      child:  MaterialApp(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: (Provider.of<providers>(context).Theme.isdark==false)?ThemeMode.light:ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        home: Splash(),
      ),
    );
  }
}
