import 'package:dio/dio.dart';

class ApiRepository {
  Map<String, dynamic>? queryPrameter;
  Map<String, dynamic>? data;
  String url;
  ApiRepository({required this.url, this.queryPrameter, this.data});
  Dio dio = Dio(BaseOptions(
    baseUrl: 'https://api.openweathermap.org/data/2.5',
    //https://api.openweathermap.org/data/2.5/forecast?q=cairo&lang=en&appid=b02af426a3fad0d92d3e0b32f9324cf0
    receiveDataWhenStatusError: true,
  ));

  Future getData({
    Function()? onStart,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await dio.get(url, queryParameters: queryPrameter).then((value) {
      if (value.statusCode == 200) {
        print('success..........');
        onSuccess!(value.data);
      }
    }).catchError((error) {
      onError!(error);
      print('fail.........');
    });
  }
}
