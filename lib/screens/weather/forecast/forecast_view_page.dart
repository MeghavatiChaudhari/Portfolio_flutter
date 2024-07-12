import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:first_app/service/api_services.dart';

class ForecastViewPage extends StatefulWidget {
  final String cityname;
  const ForecastViewPage({super.key, required this.cityname});

  @override
  State<ForecastViewPage> createState() => _ForecastViewPageState();
}

class _ForecastViewPageState extends State<ForecastViewPage> {
  Map<String, dynamic>? forecastInfo;
  late int index;

  List<Map<String, dynamic>> FinalList = [];
  List<dynamic> per_hr_data = [];

  Future<void> CheckForecast() async {
    var forecastdata = await ApiServices().getForecastData(widget.cityname);
    setState(() {
      forecastInfo = forecastdata;
      processForecastData();
    });
  }

  void processForecastData() {
    FinalList.clear();
    if (forecastInfo != null &&
        forecastInfo!['forecast'] != null &&
        forecastInfo!['forecast']['forecaseday'] != null) {
      FinalList.addAll(List<Map<String, dynamic>>.from(
          forecastInfo!['forecast']['forecastday']));
    }
    per_hr_data = FinalList[index]['hour'];
  }

  void initState() {
    index = 8;
    CheckForecast();
    super.initState();
  }

  void updateindex(int newindex) {
    setState(() {
      index = newindex;
      if (FinalList.isNotEmpty) {
        per_hr_data = FinalList[index]['hour'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
