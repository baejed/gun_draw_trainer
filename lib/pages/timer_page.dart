import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gun_draw_trainer/controllers/alert_player.dart';
import 'package:gun_draw_trainer/res/styles.dart';

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
  bool readyToStart = false;

  Future<void> startTimer() async {
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

  void start() {

    int randomMs = 1500 + Random().nextInt(1500);

    Future.delayed(Duration(milliseconds: randomMs), () async {
      await AlertPlayer.play();
      startTimer();
    });

  }

  void stop() {
    AlertPlayer.initializePlayer();
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text("$seconds.", style: Styles.txtTime),
                      Text("${ms < 10 ? "0$ms" : ms}", style: Styles.txtTimeMs),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.refresh), color: Colors.white,),
                      IconButton(onPressed: () {}, icon: Icon(Icons.delete), color: Colors.red[600]),
                    ],
                  )
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
