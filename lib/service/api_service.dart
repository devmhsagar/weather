import 'dart:convert';

import 'package:http/http.dart';
import 'package:weather/constants/constants.dart';
import 'package:weather/model/weather_model.dart';

class ApiService {
  Future<WeatherModel> getWeatherData(String searchText) async {
    String url = "$base_url&q=$searchText&days=7";

    try {
      Response response = await get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        WeatherModel weather = WeatherModel.fromJson(json);
        return weather;
      } else {
        throw Exception('Failed to load weather');
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
