import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:red_blue_game/counter_animation/counter_screen.dart';
import 'package:red_blue_game/cubit/height1_cubit.dart';
import 'package:red_blue_game/cubit/height2_cubit.dart';
import 'package:red_blue_game/utility.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a blue toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const CounterScreen());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isEnabled = true;
  final height1_cubit = Height1Cubit();
  final height2_cubit = Height2Cubit();

  bool isTouched(double height) {
    if (height >= MediaQuery.of(context).size.height - 10) {
      print('bandhogya');

      return true;
    }
    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      height1_cubit.defualtHight(context);
      height2_cubit.defualtHight(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          height1_cubit.gameOver(context);
          height2_cubit.gameOver(context);
          // Navigator.push(
          //   context,
          //   utility.createRoute(const MyHomePage()),
          // );
        },
        child: const Icon(Icons.threesixty_rounded),
      ),
      body: Center(
        child: Column(
          children: [
            BlocBuilder<Height1Cubit, double>(
              bloc: height1_cubit,
              builder: (BuildContext context, state) {
                return GestureDetector(
                    onTap: () {
                      if (isTouched(state)) {
                        height1_cubit.gameOver(context);
                        height2_cubit.gameOver(context);
                        utility.openCustomDialog(context, 1);
                      }
                      height1_cubit.increaseHeight();
                      height2_cubit.decreaseHeight();
                    },
                    child: Stack(children: [
                      Container(color: Colors.red, height: state),
                      Positioned(
                          top: 50,
                          right: 152,
                          child: RotatedBox(
                            quarterTurns: 2,
                            child: Text(
                              'player 1'.toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 22),
                            ),
                          ))
                    ]));
              },
            ),
            BlocBuilder<Height2Cubit, double>(
                bloc: height2_cubit,
                builder: (BuildContext context, state) {
                  return GestureDetector(
                    onTap: () {
                      if (isTouched(state)) {
                        height1_cubit.gameOver(context);
                        height2_cubit.gameOver(context);
                        utility.openCustomDialog(context, 2);
                      }
                      height2_cubit.increaseHeight();
                      height1_cubit.decreaseHeight();
                    },
                    child: Stack(children: [
                      BlocBuilder<Height2Cubit, double>(
                        bloc: height2_cubit,
                        builder: (BuildContext context, state) {
                          return Container(color: Colors.blue, height: state);
                        },
                      ),
                      Positioned(
                          bottom: 50,
                          right: 152,
                          child: Text(
                            'player 2'.toUpperCase(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 22),
                          ))
                    ]),
                  );
                })
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
