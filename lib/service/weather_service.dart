import 'package:weatherapp/Api/api_repo.dart';
import 'package:weatherapp/model/five_day_model.dart';
import 'package:weatherapp/model/weather_model.dart';

class WeatherService {
  String city;
  String url = '/weather';
  String urll = '/forecast';
  WeatherService({required this.city});

  void getWeather({
    Function()? onStart,
    Function(WeatherModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    Map<String, dynamic> queryPrameter = {
      'q': city,
      'lang': 'en',
      'appid': 'b02af426a3fad0d92d3e0b32f9324cf0'
    };
    await ApiRepository(url: url, queryPrameter: queryPrameter).getData(
      onSuccess: (data) => onSuccess!(WeatherModel.fromJson(data)),
      onError: (error) {
        onError!(error);
        print(error.toString());
      },
    );
  }

  void getFiveWeather({
    Function()? onStart,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    Map<String, dynamic> queryPrameter = {
      'q': city,
      'lang': 'en',
      'appid': 'b02af426a3fad0d92d3e0b32f9324cf0'
    };
    await ApiRepository(url: urll, queryPrameter: queryPrameter).getData(
      onSuccess: (data) => onSuccess!(FiveBig.fromJson(data)),
      onError: (error) {
        onError!(error);
        print(error.toString());
      },
    );
  }
}
