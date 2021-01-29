import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_cubit_library_tutorial/data/model/weather.dart';
import 'package:bloc_cubit_library_tutorial/data/weather_repository.dart';
import 'package:equatable/equatable.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc(this.weatherRepository) : super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is GetWeather) {
      try {
        yield (WeatherLoading());
        final weather = await weatherRepository.fetchWeather(event.cityName);
        yield (WeatherLoaded(weather));
      } on NetworkException {
        yield (WeatherError('Couldn\'t get weather... Is the device online?'));
      }
    }
  }
}
