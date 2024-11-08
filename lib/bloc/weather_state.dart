part of 'weather_bloc.dart';

sealed class WeatherBlocState extends Equatable {
  const WeatherBlocState();

  @override
  List<Object> get props => [];
}

final class WeatherBlocInitial extends WeatherBlocState {}

final class WeatherBlocLoading extends WeatherBlocState {}

final class WeatherBlocSucess extends WeatherBlocState {
  final Weather weather;
  const WeatherBlocSucess(this.weather);
  @override
  List<Object> get props => [weather];
}

final class WeatherBlocFailure extends WeatherBlocState {}
