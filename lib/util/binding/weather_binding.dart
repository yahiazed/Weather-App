import 'package:get/instance_manager.dart';
import 'package:weatherapp/controller/weather_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WeatherController(city: 'zagazig'));
  }
}
