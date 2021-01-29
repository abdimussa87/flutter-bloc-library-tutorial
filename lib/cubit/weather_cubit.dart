import 'package:bloc/bloc.dart';
import 'package:bloc_cubit_library_tutorial/data/model/weather.dart';
import 'package:bloc_cubit_library_tutorial/data/weather_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherCubit(this.weatherRepository) : super(WeatherInitial());

  Future<void> getWeather(String cityName) async {
    try {
      emit(WeatherLoading());
      final weather = await weatherRepository.fetchWeather(cityName);
      emit(WeatherLoaded(weather));
    } on NetworkException {
      emit(WeatherError('Couldn\t fetch weather... Is the device Online?'));
    }
  }
}
