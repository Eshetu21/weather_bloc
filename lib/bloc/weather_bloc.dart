// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:bloc_weather/data/my_data.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherBlocLoading());
      try {
        WeatherFactory wf = WeatherFactory(apikey, language: Language.ENGLISH);
        Future<Position> determinePosition() async {
          bool serviceEnabled;
          LocationPermission permission;

          serviceEnabled = await Geolocator.isLocationServiceEnabled();
          if (!serviceEnabled) {
            return Future.error('Location services are disabled.');
          }

          permission = await Geolocator.checkPermission();
          if (permission == LocationPermission.denied) {
            permission = await Geolocator.requestPermission();
            if (permission == LocationPermission.denied) {
              return Future.error('Location permissions are denied');
            }
          }

          if (permission == LocationPermission.deniedForever) {
            return Future.error(
                'Location permissions are permanently denied, we cannot request permissions.');
          }

          return await Geolocator.getCurrentPosition();
        }

        Position position =  await determinePosition();
        Weather weather = await wf.currentWeatherByLocation(
            position.latitude, position.longitude);
        WeatherBlocSucess(weather);
        print(weather);
      } catch (e) {
        emit(WeatherBlocFailure());
      }
    });
  }
}
