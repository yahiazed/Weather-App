/**
 * 
 * {


    "main": {
        "temp": 302.57,
        "feels_like": 303.94,
        "temp_min": 302.27,
        "temp_max": 302.57,
        "pressure": 1007,
        "humidity": 54
    },
  
   
    
 
  

}
 */

class WeatherModel {
  String? name;
  List<Weather>? weathers;
  Cloud? cloud;
  Wind? wind;
  MainWeather? maine;
  WeatherModel({this.name, this.cloud, this.maine, this.wind, this.weathers});
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      name: json['name'],
      cloud: Cloud.fromJson(json['clouds']),
      maine: MainWeather.fromJson(json['main']),
      wind: Wind.fromJson(json['wind']),
      weathers:
          (json['weather'] as List).map((e) => Weather.fromJson(e)).toList(),
    );
  }
}

class MainWeather {
  num temp, temp_min, temp_max;
  MainWeather(
      {required this.temp, required this.temp_max, required this.temp_min});
  factory MainWeather.fromJson(Map<String, dynamic> json) {
    return MainWeather(
        temp: json['temp'],
        temp_max: json['temp_max'],
        temp_min: json['temp_min']);
  }
}

class Cloud {
  int all;
  Cloud({required this.all});
  factory Cloud.fromJson(Map<String, dynamic> json) {
    return Cloud(all: json['all']);
  }
}

class Wind {
  num speed;

  Wind({
    required this.speed,
  });
  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(speed: json['speed']);
  }
  Map<String, dynamic> toJson() {
    return {'speed': speed};
  }
}

class Weather {
  int id;
  String? main, description, icon;
  Weather({required this.id, this.main, this.description, this.icon});
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        id: json['id'],
        main: json['main'],
        description: json['description'],
        icon: json['icon']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'main': main, 'description': description};
  }
}
/**
 *  "weather": [
        {
            "id": 800,
            "main": "Clear",
            "description": "clear sky",
            "icon": "01n"
        }
    ],
 * 
 */
