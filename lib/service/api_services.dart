import 'dart:convert';

import '../models/get_city_weather.dart';
import '../models/get_ip_geolocation.dart';
import '../models/get_search_city.dart';
import '../models/get_ip.dart';
import 'package:http/http.dart' as http;

import '../models/get_weather.dart';

class ApiServices {
  Future<IpInfoModel?> getmyIp() async {
    try {
      var res = await http.get(Uri.parse('https://api.ipify.org/?format=json'));
      if (res.statusCode == 200) {
        IpInfoModel ipInfoModel = IpInfoModel.fromJson(json.decode(res.body));
        return ipInfoModel;
      } else {
        print("Ip response failed");
      }
    } catch (e) {
      print(e.toString());
    }
    print("Failed Evrything");
    return null;
  }

  // IpInfoModel ipinfomodel=IpInfoModel();
  Future<IpIGeoLocModel?> getIPGeoLocation(String ipaddress) async {
    try {
      var res = await http.get(Uri.parse(
          "https://api.ipgeolocation.io/ipgeo?apiKey=2f058980b09849ac9e9b15b9b744575e&ip=${ipaddress}"));
      if (res.statusCode == 200) {
        IpIGeoLocModel ipGeoLocModel =
            IpIGeoLocModel.fromJson(json.decode(res.body));
        return ipGeoLocModel;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<CityWeatherModel?> getCityWeather(String cityname) async {
    try {
      var res = await http.get(Uri.parse(
          "http://api.weatherapi.com/v1/current.json?key=d771530ea2c04342a4a114808240807&q=${cityname}"));
      if (res.statusCode == 200) {
        CityWeatherModel cityWeatherModel =
            CityWeatherModel.fromJson(json.decode(res.body));
        return cityWeatherModel;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<List<SearchCityModel>?> searchCity(String query) async {
    try {
      var res = await http.get(Uri.parse(
          "http://api.weatherapi.com/v1/search.json?key=d771530ea2c04342a4a114808240807&q=${query}"));
      if (res.statusCode == 200) {
        List<SearchCityModel> searchmodel = List<SearchCityModel>.from(
            json.decode(res.body).map((x) => SearchCityModel.fromJson(x)));
        return searchmodel;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<Map<String, dynamic>?> getForecastData(String cityname) async {
    try {
      var res = await http.get(Uri.parse(
          "http://api.weatherapi.com/v1/forecast.json?key=d771530ea2c04342a4a114808240807&q=${cityname}&days=7"));
      if (res.statusCode == 200) {
        return json.decode(res.body);
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
