import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/model/weather_model.dart';

class WeatherHourlyListitem extends StatelessWidget {
  final Hour? hour;

  const WeatherHourlyListitem({
    super.key,
    this.hour,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        width: 100,
        decoration: BoxDecoration(
            color: Colors.white24, borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text(
                    hour?.tempC?.round().toString() ?? "",
                    style: const TextStyle(
                        color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const Text(
                  "o",
                  style: TextStyle(
                      color: Colors.white, fontSize: 14,),
                ),
              ],
            ),
            Container(
              height: 45,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.teal,
              ),
              child: Image.network(
                "https:${hour?.condition?.icon.toString()}",
              ),
            ),
            Text(DateFormat.j().format(DateTime.parse(hour?.time.toString() ?? "")),style: TextStyle(color: Colors.white),)
          ],
        ),
      ),
    );
  }
}
