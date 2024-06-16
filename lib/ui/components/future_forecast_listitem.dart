import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/model/weather_model.dart';

class FutureForecastListitem extends StatelessWidget {
  final Forecastday? forecastday;

  const FutureForecastListitem({super.key, this.forecastday});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(vertical: 8),
        margin: EdgeInsets.all(8),
        width: double.infinity,
        child: Row(
          children: [
            Image.network(
                "https:${forecastday?.day?.condition?.icon.toString()}"),
            Expanded(
                child: Text(
              DateFormat.MMMEd()
                  .format(DateTime.parse(forecastday?.date.toString() ?? "")),
              style: TextStyle(color: Colors.white),
            )),
            Expanded(
                child: Text(
                  forecastday?.day?.condition?.text.toString() ?? "",
                  style: const TextStyle(color: Colors.white),
                )),
            Expanded(
                child: Text(
                  "^${forecastday?.day?.mintempC?.round().toString()}/${forecastday?.day?.maxtempC?.round().toString()}",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                )),
          ],
        ),
      ),
    );
  }
}
