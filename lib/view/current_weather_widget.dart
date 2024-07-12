// import 'package:flutter/material.dart';
// import 'package:first_app/model/weather/current_weather_model.dart';
// import 'package:first_app/model/weather/weather_data.dart';
// import 'package:first_app/utils/custom_colors.dart';
//
// class CurrentWeatherWidget extends StatelessWidget {
//   final WeatherDataCurrent weatherDataCurrent;
//   const CurrentWeatherWidget({Key? key, required this.weatherDataCurrent})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         //temp area
//         temperatureAreaWidget(),
//
//         //more details - windspeed , humidity , clouds
//         currentWeatherMoreDetailsWidget(),
//       ],
//     );
//   }
//
//   Widget currentWeatherMoreDetailsWidget() {
//     return Container();
//   }
//
//   Widget temperatureAreaWidget() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         Image.asset(
//           'assets/weather/50n.png',
//           height: 80,
//           width: 80,
//         ),
//         Container(
//           height: 50,
//           width: 1,
//           color: CustomColors.dividerLine,
//         ),
//         RichText(
//             text: TextSpan(children: [
//           TextSpan(
//               text:
//                   "${weatherDataCurrent.currentWeather.temperature!.toInt()}°",
//               style: const TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 60,
//                   color: CustomColors.textColorBlack)),
//         ]))
//       ],
//     );
//   }
// }
