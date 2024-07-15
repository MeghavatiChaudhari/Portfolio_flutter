import 'package:first_app/models/get_city_weather.dart';
import 'package:first_app/models/get_ip.dart';
import 'package:first_app/models/get_ip_geolocation.dart';
import 'package:first_app/models/get_weather.dart';
import 'package:first_app/screens/weather/forecast/forecast_view_page.dart';
import 'package:first_app/service/api_services.dart';
import 'package:first_app/theme/colors.dart';
import 'package:first_app/utils/date_formater.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../models/get_search_city.dart';

class WeatherHomeView extends StatefulWidget {
  const WeatherHomeView({super.key});

  @override
  State<WeatherHomeView> createState() => _WeatherHomeViewState();
}

class _WeatherHomeViewState extends State<WeatherHomeView> {
  bool isSearch = false;
  bool isready = false;
  late String searchedcity = "";

  TextEditingController searchcontroller = TextEditingController();

  IpInfoModel ipInfoModelr = IpInfoModel();
  IpIGeoLocModel ipIGeoLocModel = IpIGeoLocModel();
  CityWeatherModel cityWeatherModel = CityWeatherModel();

  WeatherModel weatherModel = WeatherModel();

  List<SearchCityModel> resultlist = [];

  _getSearchResult(String searchquery) {
    ApiServices().searchCity(searchquery).then((searchval) {
      setState(() {
        resultlist = searchval!;
        setNewCity(resultlist[0].region.toString());
      });
    });
  }

  _getcurrentlocweather() {
    isready = true;
    ApiServices().getmyIp().then((val) {
      if (val != null) {
        ipInfoModelr.ip = val.ip ?? 'Unknown Ip';
        ApiServices().getIPGeoLocation(ipInfoModelr.ip.toString()).then((data) {
          ipIGeoLocModel = data!;
          // print("City Get ${ipIGeoLocModel.city}");
          String city = searchedcity == ""
              ? ipIGeoLocModel.city.toString()
              : searchedcity;
          ApiServices().getCityWeather(city).then((data) {
            cityWeatherModel = data!;
            // print(
            //     "city weather is ${cityWeatherModel.current?.tempC.toString()}");
            setState(() {});
          });
        });
      } else {
        print("Failed ");
      }
      isready = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _getcurrentlocweather();
    super.initState();
  }

  void setNewCity(String city) {
    setState(() {
      searchedcity = city;
      _getcurrentlocweather();
      isSearch = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: isSearch
          ? AppBar(
              leading: TextButton(
                child: const Icon(Icons.arrow_back_sharp),
                onPressed: () {
                  setState(() {
                    isSearch = false;
                  });
                },
              ),
              backgroundColor: Colors.purple,
              title: TextField(
                controller: searchcontroller,
                onChanged: _getSearchResult(searchcontroller.text),
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white),
                ),
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    _getSearchResult(searchcontroller.text);
                  },
                  child: const Icon(
                    Icons.search,
                    size: 35,
                    color: Colors.white,
                  ),
                )
              ],
            )
          : AppBar(
              backgroundColor: AppColors.purpleTransparent,
              leading: Icon(
                MdiIcons.mapMarker,
                size: 35,
                color: Colors.white,
              ),
              title: Row(
                children: [
                  Text(
                    cityWeatherModel.location!.name.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.w800, color: Colors.white),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    setState(() {
                      isSearch = true;
                    });
                  },
                  child: const Icon(
                    Icons.search,
                    size: 35,
                    color: Colors.white,
                  ),
                )
              ],
            ),
      body: isready == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : isSearch
              ? Scaffold(
                  backgroundColor: Colors.white,
                  body: ListView.builder(
                    itemCount: resultlist.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: TextButton(
                            onPressed: () {
                              // setNewCity(resultlist[index].region.toString());
                            },
                            child: Text(resultlist[index].region.toString())),
                      );
                    },
                  ),
                )
              : Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black, AppColors.purpleTransparent],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      stops: [0.4, 0.7],
                      tileMode: TileMode.repeated,
                    ),
                  ),
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Image.network(
                        "https:${cityWeatherModel.current!.condition!.icon.toString()}",
                        width: 400,
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Opacity(
                          opacity: 0.3,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Today ${DateFormater().DateFormaterfunction(cityWeatherModel.location!.localtime.toString())}",
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "${cityWeatherModel.current!.tempC!.toInt().toString()}\u00B0",
                                style: const TextStyle(
                                    fontSize: 80, color: Colors.white),
                              ),
                              Text(
                                cityWeatherModel.current!.condition!.text
                                    .toString(),
                                style: const TextStyle(
                                    fontSize: 22, color: Colors.white),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.wind_power),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  const Text(
                                    "Wind     |  ",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  Text(
                                    "${cityWeatherModel.current?.windKph.toString()} Km/h",
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.water_drop),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  const Text(
                                    "Hum        |          ",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  Text(
                                    "${cityWeatherModel.current?.humidity.toString()} %",
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 50,
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForecastViewPage(
                                  cityname: cityWeatherModel.location!.name
                                      .toString(),
                                ),
                              ),
                            );
                          },
                          child: const Text("View Forecast"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.purpleTransparent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 50,
                              vertical: 20,
                            ),
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
