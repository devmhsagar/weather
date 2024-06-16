import 'package:flutter/material.dart';
import 'package:weather/model/weather_model.dart';
import 'package:weather/service/api_service.dart';
import 'package:weather/ui/components/future_forecast_listitem.dart';
import 'package:weather/ui/components/todays_weather.dart';
import 'package:weather/ui/components/weather_hourly_listitem.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService apiService = ApiService();
  final _textFieldController = TextEditingController();
  String searchText = "auto:ip";

  Future<void> _showInputDialog(BuildContext context) async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Search Location"),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: "Enter Location"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (_textFieldController.text.isNotEmpty) {
                  Navigator.pop(context, _textFieldController.text);
                }
              },
              child: Text("Ok"),
            ),
          ],
        );
      },
    );

    if (result != null && result.isNotEmpty) {
      setState(() {
        searchText = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            onPressed: () async {
              _textFieldController.clear();
              await _showInputDialog(context);
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                searchText = "auto:ip";
              });
            },
            icon: const Icon(
              Icons.my_location,
              color: Colors.white,
            ),
          ),
        ],
        title: const Text(
          'Weather App',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: apiService.getWeatherData(searchText),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              WeatherModel? weatherModel = snapshot.data;
              return SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Expanded(flex: 4, child: TodaysWeather(weatherModel: weatherModel)),
                    const SizedBox(height: 10),
                    const Text(
                      "Weather By Hours",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      flex: 2,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          Hour? hour = weatherModel?.forecast?.forecastday?[0].hour?[index];
                          return WeatherHourlyListitem(hour: hour);
                        },
                        itemCount: weatherModel!.forecast!.forecastday![0].hour!.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Next 7 Days Weather",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      flex: 3,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          Forecastday? forecastday = weatherModel?.forecast?.forecastday?[index];
                          return FutureForecastListitem(forecastday: forecastday);
                        },
                        itemCount: weatherModel?.forecast?.forecastday?.length,
                      ),
                    ),
                  ],
                ),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text("Please check your internet connection", style: TextStyle(color: Colors.white),),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
