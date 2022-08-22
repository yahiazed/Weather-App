import 'package:weatherapp/model/weather_model.dart';

class FiveBig {
  String? cod;
  List<FiveDayModel>? lists;
  FiveBig({this.lists, this.cod});
  factory FiveBig.fromJson(Map<String, dynamic> json) {
    return FiveBig(
        cod: json['cod'],
        lists: (json['list'] as List)
            .map((e) => FiveDayModel.fromJson(e))
            .toList());
  }
}

class FiveDayModel {
  String? dt_txt;
  MainWeather? mainWeather;
  Wind? wind;
  Cloud? cloud;
  List<Weather>? weatherList;
  FiveDayModel(
      {this.dt_txt, this.cloud, this.mainWeather, this.wind, this.weatherList});
  factory FiveDayModel.fromJson(Map<String, dynamic> json) {
    return FiveDayModel(
      cloud: Cloud.fromJson(json['clouds']),
      dt_txt: json['dt_txt'],
      mainWeather: MainWeather.fromJson(json['main']),
      wind: Wind.fromJson(json['wind']),
      weatherList:
          (json['weather'] as List).map((e) => Weather.fromJson(e)).toList(),
    );
  }
}
