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
  Timer? timer; // this is the stopwatch timer
  Timer? holdTimer;
  int seconds = 0;
  int ms = 0;
  bool starting = false;

  bool readyToStart = false;
  bool holding = false;
  bool goStart = true;
  bool getReady = false;

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
    setState(() => getReady = true);

    Future.delayed(Duration(milliseconds: randomMs), () async {
      await AlertPlayer.play();
      setState(() => getReady = false);
      startTimer();
    });

  }

  void stop() {

    if(starting) {
      AlertPlayer.initializePlayer();
    }

    stopwatch.stop();
    stopwatch.reset();
    timer?.cancel();

    setState(() {
      starting = false;
    });
  }

  void restart() {
    stop();

    setState(() {
      ms = 0;
      seconds = 0;
    });
  }

  void onHold() {

    int holdTime = 1; // the time needed to hold to start the timer (seconds)

    setState(() {
      holding = true;
      readyToStart= false;
    });

    holdTimer = Timer(Duration(seconds: holdTime), () {
      setState(() {
        readyToStart = true;
      });
    });
  }

  void onTapUp() {

    holdTimer?.cancel();

    if(!starting && readyToStart) {
      start();
    }else {
      stop();
    }

    setState(() {
      holding = false;
      readyToStart = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {

    return (
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (details) => onHold(),
        onTapUp: (details) => onTapUp(),
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
                      Text(
                        getReady ? "Ready..." :"$seconds.",
                        style: holding 
                          ? readyToStart
                            ? Styles.txtTimeGreen 
                            : Styles.txtTimeDarker
                          : Styles.txtTime,
                      ),
                      Text(
                        getReady ? "" : "${ms < 10 ? "0$ms" : ms}", 
                        style: holding 
                          ? readyToStart 
                            ? Styles.txtTimeMsGreen
                            : Styles.txtTimeMsDarker
                          : Styles.txtTimeMs
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(onPressed: restart, icon: Icon(Icons.refresh), color: Colors.white,),
                      IconButton(onPressed: () {}, icon: Icon(Icons.delete), color: Colors.white),
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
