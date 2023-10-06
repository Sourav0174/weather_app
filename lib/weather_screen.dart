import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'AdditionalInformationItem.dart';
import 'HourlyForcastItem.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  double temp = 0;
  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }

  Future getCurrentWeather() async {
    try {
      String cityName = 'London';
      final res = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=6c0da12bf6283850ef13dca1fe48a19d',
        ),
      );
      final data = jsonDecode(res.body);
      if (data['cod'] != '200') {
        throw 'error occurred while';
      }

      setState(() {
        temp = (data['list'][0]['main']['temp']);
      });
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(33, 158, 188, 253),
      appBar: AppBar(
        // backgroundColor: const Color.fromRGBO(2, 48, 71, 200),
        title: const Text(
          "Weather App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 10,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.refresh))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // creating cards
          children: [
            // main card
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 6,
                      sigmaY: 6,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            "$temp K",
                            style: const TextStyle(fontSize: 32),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Icon(
                            Icons.cloud,
                            size: 64,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text(
                            "Rain",
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // weather forcast card
            const Text(
              "Weather Forcast",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  HourlyForcastItem(
                    time: '3:00',
                    icon: Icons.cloud,
                    value: 300.2,
                  ),
                  HourlyForcastItem(
                    time: '3:00',
                    icon: Icons.cloud,
                    value: 300.2,
                  ),
                  HourlyForcastItem(
                    time: '4:00',
                    icon: Icons.cloud,
                    value: 300.2,
                  ),
                  HourlyForcastItem(
                    time: '5:00',
                    icon: Icons.cloud,
                    value: 300.2,
                  ),
                  HourlyForcastItem(
                    time: '6:00',
                    icon: Icons.cloud,
                    value: 300.2,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // additional information
            const Text(
              "Additional Information",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AdditionalInformationItem(
                  icon: Icons.water_drop,
                  label: 'Humidity',
                  value: '94',
                ),
                AdditionalInformationItem(
                  icon: Icons.air,
                  label: 'Wind speed',
                  value: '100',
                ),
                AdditionalInformationItem(
                  icon: Icons.compress_outlined,
                  label: 'Pressure',
                  value: '1000',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
