import 'package:first_app/utils/date_formater.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:first_app/service/api_services.dart';
import '../../../theme/colors.dart';

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
    try {
      var forecastdata = await ApiServices().getForecastData(widget.cityname);
      setState(() {
        forecastInfo = forecastdata;
        print(forecastdata);
        processForecastData();
      });
    } catch (e) {
      print('error fetching forecast $e');
    }
  }

  void processForecastData() {
    FinalList.clear();
    if (forecastInfo != null &&
        forecastInfo!['forecast'] != null &&
        forecastInfo!['forecast']['forecastday'] != null) {
      FinalList.addAll(List<Map<String, dynamic>>.from(
          forecastInfo!['forecast']['forecastday']));
    }
    print('processed forecast data $FinalList'); //debug
    if (FinalList.isNotEmpty) {
      if (index >= FinalList.length) {
        index = FinalList.length - 1;
      }
      per_hr_data = FinalList[index]['hour'];
      print('per hour data : $per_hr_data'); //debug
    }
  }

  void initState() {
    index = 0;
    CheckForecast();
    super.initState();
  }

  void updateindex(int newindex) {
    setState(() {
      index = newindex;
      if (FinalList.isNotEmpty && index < FinalList.length) {
        per_hr_data = FinalList[index]['hour'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.purpleTransparent,
        title: Text(
          "${widget.cityname} Forecast",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.black, AppColors.purpleTransparent],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            stops: [0.4, 0.7],
            tileMode: TileMode.repeated,
          ),
        ),
        child: forecastInfo == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  SizedBox(height: 20),
                  Padding(
                    // list of per hr data
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: per_hr_data.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 100,
                            child: Card(
                              color: Colors.transparent,
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "${per_hr_data[index]["temp_c"].toString()} \u2103",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Image.network(
                                      "https:${per_hr_data[index]["condition"]["icon"]}",
                                    ),
                                    Text(
                                      DateFormater().getTimeAMPM(
                                          per_hr_data[index]["time"]),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Next and Current",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Icon(
                          Icons.calendar_month,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SizedBox(
                      height: 400,
                      child: Scrollbar(
                        thickness: 5,
                        radius: const Radius.circular(20),
                        child: ListView.builder(
                          itemCount: FinalList.length,
                          itemBuilder: (context, index) {
                            return TextButton(
                              onPressed: () {
                                setState(() {
                                  updateindex(index);
                                });
                              },
                              child: Container(
                                decoration: index == this.index
                                    ? BoxDecoration(
                                        border: Border.all(
                                          color: Colors.white70,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.blue,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.white.withOpacity(0.7),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      )
                                    : BoxDecoration(
                                        color: Colors.transparent,
                                      ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      DateFormater().DateFormateforforecast(
                                          FinalList[index]["date"]),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Image.network(
                                      "https:${FinalList[index]["day"]["condition"]["icon"]}",
                                    ),
                                    Text(
                                        " ${FinalList[index]["day"]["avgtemp_c"].toString()} \u00B0",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500))
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(height: 20),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: ElevatedButton(
                  //     onPressed: () {},
                  //     child: const Text("View Forecast"),
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: AppColors.purpleTransparent,
                  //       foregroundColor: Colors.white,
                  //       padding: const EdgeInsets.symmetric(
                  //         horizontal: 30,
                  //         vertical: 20,
                  //       ),
                  //       textStyle: const TextStyle(
                  //         fontSize: 20,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
      ),
    );
  }
}
