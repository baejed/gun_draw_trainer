import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gun_draw_trainer/assets/styles.dart';


class TimerPage extends StatefulWidget {

  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();

}

class _TimerPageState extends State<TimerPage> {

  Stopwatch stopwatch = Stopwatch();
  double time = 0;
  Duration duration = Duration();
  Timer? timer;
  int seconds = 0;
  int ms = 0;
  bool starting = false;

  void start() {
    stopwatch.start();
    setState(() {
      starting = true;
    });
    timer = Timer.periodic(Duration(milliseconds: 10), (Timer t) {
      setState(() {
        duration = stopwatch.elapsed;
        seconds = stopwatch.elapsed.inSeconds;
        ms = (stopwatch.elapsed.inMilliseconds%1000/10).toInt();
      });
    });
  }

  void stop() {
    stopwatch.stop();
    stopwatch.reset();
    timer!.cancel();

    setState(() {
      starting = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {

    return (
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (details) => print("holding"),
        onTapUp: (details) => starting ? stop() : start(),
        child: Stack(
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text("$seconds.", style: Styles.txtTime),
                  Text("${ms < 10 ? "0$ms" : ms}", style: Styles.txtTimeMs),
                ],
              )
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    Text("Statistic: 123", style: Styles.txtStats,),
                    Text("Statistic: 123", style: Styles.txtStats,),
                    Text("Statistic: 123", style: Styles.txtStats,),
                    Text("Statistic: 123", style: Styles.txtStats,),
                  ],),
                  Column(children: [
                    Text("Statistic: 123", style: Styles.txtStats,),
                    Text("Statistic: 123", style: Styles.txtStats,),
                    Text("Statistic: 123", style: Styles.txtStats,),
                    Text("Statistic: 123", style: Styles.txtStats,),
                  ],),
                ],
              )
            )
          ],
        ),
      )
    );
  }

}
