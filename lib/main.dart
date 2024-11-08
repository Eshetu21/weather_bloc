import 'package:bloc_weather/bloc/weather_bloc.dart';
import 'package:bloc_weather/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        home: BlocProvider<WeatherBlocBloc>(
          create: (context) =>WeatherBlocBloc()..add(FetchWeather()),
          child: const HomeScreen(),
        ));
  }
}
