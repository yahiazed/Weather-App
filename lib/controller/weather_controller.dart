import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherapp/model/five_day_model.dart';
import 'package:weatherapp/model/weather_model.dart';
import 'package:weatherapp/service/weather_service.dart';
import 'package:weatherapp/util/colors/my_color.dart';

class WeatherController extends GetxController {
  String city;
  WeatherController({required this.city});
  WeatherModel model = WeatherModel();
  FiveBig fiveModel = FiveBig();

  var error;
  @override
  void onInit() async {
    city = 'cairo';
    await getCurrentWeather();
    getFiveCity();
    await check();
    super.onInit();
  }

  @override
  void onReady() {
    getFiveCity();
    super.onReady();
  }

  void searchByCity(String search) async {
    city = search;
    await getCurrentWeather();
    await getFiveCity();
    await check();
    update();
  }

  List<Color> linear = [];
  String image = 'assets/images/rain.png';
  Future check() async {
    if (model.weathers?[0].icon == '01n') {
      linear = MyColors.wind;
      image = 'assets/images/colud.png';
      update();
    } else if (model.weathers?[0].icon == '04n') {
      linear = MyColors.good;
      image = 'assets/images/ran.png';

      update();
    } else {
      linear = MyColors.sunny;

      image = 'assets/images/sun0.jpg';
      update();
    }
  }

  Future getFiveCity() async {
    WeatherService(city: city).getFiveWeather(
      onSuccess: (data) {
        fiveModel = data;
        print('data..........${fiveModel.lists?.length}');
        update();
      },
      onError: (error) {
        this.error = error;
        print('eroor is...$error');
        update();
      },
    );
  }

  Future getCurrentWeather() async {
    WeatherService(city: city).getWeather(
      onSuccess: (data) {
        model = data;
        update();
      },
      onError: (error) {
        this.error = error;
        update();
      },
    );
  }
}
