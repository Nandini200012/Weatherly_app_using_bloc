import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/bloc/weather_bloc_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget getWeatherIcon(int code) {
    switch (code) {
      case > 200 && <= 300:
        // thunderstrom
        return Image.asset('assets/Imagepng/thunder.png');
      case >= 300 && < 400:
        // light rain
        return Image.asset(
          'assets/Imagepng/sunSlowRain.png',
          scale: 10.5,
        );
      case >= 500 && < 600:
        // rain
        return Image.asset('assets/Imagepng/heavyRain.png');
      case >= 600 && < 700:
        // snow
        return Image.asset('assets/Imagepng/Snoww.png');
      case >= 700 && < 800:
        // fuzz cloud mist
        return Image.asset('assets/Imagepng/Mist.png');
      case == 800:
        // sunny
        return Image.asset('assets/Imagepng/Sunny.png');
      case > 800 && <= 804:
        // cloudy
        return Image.asset(
          'assets/Imagepng/sunn.png',
        );

      default:
        return Image.asset('assets/Imagepng/Sunny.png');
    }
  }
String getGreeting(){  
  final String message;
  int hours=DateTime.now().hour;
if(hours>=1 && hours<=12 ){
 message="Good Morning";

}else if(hours>=12 && hours<=16){
   message="Good Afternoon";
}
else if(hours>=16 && hours<=21){
  message="Good Evening";
}
else if(hours>=21 && hours<=24){
  message="Good Night";
}else{
  message= "Good Day";
}
return message;
}
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 1.2 * kToolbarHeight, 20, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(3, -0.3),
                child: Container(
                  height: 300,
                  width: 230,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.deepPurple),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-3, -0.3),
                child: Container(
                  height: 300,
                  width: 230,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.deepPurple),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, -1.2),
                child: Container(
                  height: 280,
                  width: 600,
                  decoration: const BoxDecoration(color: Colors.orange),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ),
              BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
                builder: (context, state) {
                  if (state is WeatherBlocSuccess) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '📍${state.weather.areaName}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            getGreeting(),
                            style: const TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Center(
                              child: getWeatherIcon(
                                  state.weather.weatherConditionCode!)
                              //     Image.asset(
                              //   'assets/Imagepng/sunSlowRain.png',scale:10.5,

                              // ),

                              ),
                          Center(
                            child: Text(
                              '${state.weather.temperature!.celsius!.round()}℃',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 50,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Center(
                            child: Text(
                              state.weather.weatherMain!.toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Center(
                            child: Text(
                              DateFormat('EEEE dd -')
                                  .add_jm()
                                  .format(state.weather.date!),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/Imagepng/sunn.png',
                                scale: 15,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Sunrise',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    DateFormat()
                                        .add_jm()
                                        .format(state.weather.sunrise!),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  Image.asset(
                                    'assets/Imagepng/moonn.png',
                                    scale: 18,
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Sunset',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        DateFormat()
                                            .add_jm()
                                            .format(state.weather.sunset!),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Image.asset(
                                'assets/Imagepng/hightemp.png',
                                scale: 20,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Temp Max',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    "${state.weather.tempMax!.celsius!.round().toString()}℃",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(
                                    width: 60,
                                  ),
                                  Image.asset(
                                    'assets/Imagepng/lowtemp.png',
                                    scale: 10,
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Temp Min',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        "${state.weather.tempMin!.celsius!.round().toString()}℃",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                            child: Divider(
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

