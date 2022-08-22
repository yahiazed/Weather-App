// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:weatherapp/controller/weather_controller.dart';
import 'package:weatherapp/model/five_day_model.dart';
import 'package:weatherapp/model/weather_model.dart';
import 'package:weatherapp/util/colors/my_color.dart';

import '../controller/tesr.dart';

class HomeSC extends StatelessWidget {
  const HomeSC({super.key});

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    WeatherController controller = Get.put(WeatherController(
        city: searchController.text == '' ? 'cairo' : searchController.text));
    return Scaffold(
      body: SafeArea(
          child: GetBuilder<WeatherController>(
        builder: (controller) => SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                gradient: _buildGrediant(colors: controller.linear)),
            child: Column(
              children: [
                Text(
                  controller.city,
                  style: TextStyle(
                    color: MyColors.textColor1,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: searchController,
                    onEditingComplete: () async {
                      controller.searchByCity(searchController.text);
                    },
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        fillColor: Colors.grey.shade300,
                        filled: true,
                        prefixIcon: Icon(
                          Icons.search_sharp,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(30))),
                  ),
                ),
                _buildPageOne(),
              ],
            ),
          ),
        ),
      )),
    );
  }

  LinearGradient _buildGrediant({required List<Color> colors}) {
    return LinearGradient(
      colors: colors,
      tileMode: TileMode.clamp,
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    );
  }

  Container _buildPageOne() {
    return Container(
      child: GetBuilder<WeatherController>(
        init: WeatherController(city: 'cairo'),
        builder: (controller) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(controller.image),
              )),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '${controller.model.weathers?[0].description}',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: MyColors.textColor1),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${(((controller.model.maine?.temp ?? 0 + 459.67) * 5 / 9) - 145.15).round().toString()}\u2103',
                  style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.wind_power_outlined,
                  color: MyColors.textColor1,
                ),
                Text('${controller.model.wind?.speed} km/h'),
                SizedBox(
                  width: 20,
                ),
                Icon(
                  Icons.water_drop_outlined,
                  color: MyColors.textColor1,
                ),
                Text('${controller.model.cloud?.all} %'),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Five Days Forecast',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: MyColors.textColor1),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) =>
                    _buildCardCites(controller.fiveModel.lists?[index]),
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildCardCites(FiveDayModel? c) {
    return Container(
      width: 200,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Card(
        child: Column(children: [
          SizedBox(
            height: 10,
          ),
          Text('${c?.weatherList?[0].main}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${(((c?.mainWeather?.temp ?? 0 + 459.67) * 5 / 9) - 143).round().toString()}\u2103',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                'o',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          GetBuilder<WeatherController>(
            builder: (controller) => Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(controller.image))),
            ),
          ),
          Text(
            '${c?.wind?.speed}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ]),
      ),
    );
  }
}
