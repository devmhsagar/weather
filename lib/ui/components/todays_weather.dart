import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:intl/intl.dart';
import 'package:weather/model/weather_model.dart';

class TodaysWeather extends StatelessWidget {
  final WeatherModel? weatherModel;

  const TodaysWeather({super.key, required this.weatherModel});

WeatherType getWeatherType(Current? current) {
 if(current?.isDay == 1){
   if(current?.condition?.text == "Sunny"){
     return WeatherType.sunny;
   }else if(current?.condition?.text == "Partly cloudy"){
     return WeatherType.cloudy;
   }else if(current?.condition?.text == "Overcast"){
     return WeatherType.overcast;
   }else if(current?.condition?.text == "Cloudy"){
     return WeatherType.cloudy;
   }else if(current?.condition?.text == "Mist"){
     return WeatherType.lightSnow;
   }else if(current!.condition!.text!.contains("thunder")){
     return WeatherType.thunder;
   }else if(current!.condition!.text!.contains("showers")){
     return WeatherType.middleSnow;
   }else if(current?.condition?.text == "Clear"){
     return WeatherType.sunny;
   }
 }else{
   if(current?.condition?.text == "Sunny"){
     return WeatherType.sunny;
   }else if(current?.condition?.text == "Partly cloudy"){
     return WeatherType.cloudyNight;
   }else if(current?.condition?.text == "Overcast"){
     return WeatherType.overcast;
   }else if(current?.condition?.text == "Cloudy"){
     return WeatherType.cloudyNight;
   }else if(current?.condition?.text == "Mist"){
     return WeatherType.lightSnow;
   }else if(current!.condition!.text!.contains("thunder")){
     return WeatherType.thunder;
   }else if(current!.condition!.text!.contains("showers")){
     return WeatherType.middleSnow;
   }else if(current?.condition?.text == "Clear"){
     return WeatherType.sunnyNight;
   }
 }
 return WeatherType.thunder;
}


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          WeatherBg(
              weatherType: getWeatherType(weatherModel?.current),
              width: MediaQuery.of(context).size.width,
              height: 315),
          SizedBox(
            width: double.infinity,
            height: 315,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text(
                        weatherModel?.location?.name ?? '',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateFormat.yMMMMEEEEd().format(DateTime.parse(
                            weatherModel?.current?.lastUpdated ?? '')),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    SizedBox(width: 10,),
                    Container(
                      decoration:  BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white10,
                      ),
                        child: Image.network(
                            "http:${weatherModel?.current?.condition?.icon}")),
                    Spacer(),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top:2.0,),
                              child: Text(
                                weatherModel?.current?.tempC?.round().toString() ?? '',
                                style: const TextStyle(
                                    color: Colors.pink,
                                    fontSize: 60,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              "o",
                              style: TextStyle(
                                  color: Colors.pink,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Text(
                          weatherModel?.current?.condition?.text ?? '',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(width: 15),
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Feels Like",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300),
                              ),
                              Text(
                                weatherModel?.current?.feelslikeC?.round().toString() ?? '',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "Wind",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300),
                              ),
                              Text(
                                "${weatherModel?.current?.windKph?.round()} km/h",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 6,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Humidity",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300),
                              ),
                              Text(
                                weatherModel?.current?.humidity?.toString() ?? '',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "Visibility",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300),
                              ),
                              Text(
                                "${weatherModel?.current?.visKm?.round()} km",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
      
      
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
