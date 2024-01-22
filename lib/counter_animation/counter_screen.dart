import 'package:flutter/material.dart';
import 'package:red_blue_game/counter_animation/circular_ui.dart';
import 'package:red_blue_game/main.dart';
import 'package:red_blue_game/utility.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> with TickerProviderStateMixin {

  late AnimationController controller;

   String get timerString {
    Duration duration = controller.duration! * controller.value;
    return (duration.inSeconds % 60).toString().padLeft(1, '0');
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value).then((value) => {
      Navigator.push(
      context,
          utility.createRoute(
          const MyHomePage()
      ),
      )
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 152, 41, 8),
            Color.fromARGB(255, 11, 111, 204)
          ],
        )),
        child: AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Align(
                        alignment: FractionalOffset.center,
                        child: AspectRatio(
                          aspectRatio: 1.0,
                          child: Stack(
                            children: <Widget>[
                              Positioned.fill(
                                child: AnimatedBuilder(
                                  animation: controller,
                                  builder: (BuildContext context, Widget? child) {
                                    return CustomPaint(
                                        painter: CustomTimerPainter(
                                      animation: controller,
                                      backgroundColor: Colors.blue,
                                      color: Colors.red,
                                    ));
                                  },
                                ),
                              ),
                              Align(
                                alignment: FractionalOffset.center,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Game Starts In".toUpperCase(),
                                      style:const TextStyle(
                                          fontSize: 22.0, color: Colors.white,fontWeight: FontWeight.bold),
                                    ),
                                   const SizedBox(height: 20,),
                                    AnimatedBuilder(
                                        animation: controller,
                                        builder:
                                            (BuildContext context, Widget? child) {
                                          return Text(
                                            timerString,
                                            style:const TextStyle(
                                                fontSize: 150.0,
                                                color: Colors.white),
                                          );
                                        }),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}