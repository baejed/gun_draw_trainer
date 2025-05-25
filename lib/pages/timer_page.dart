import 'package:flutter/material.dart';
import 'package:gun_draw_trainer/assets/styles.dart';

class TimerPage extends StatefulWidget {

  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();

}

class _TimerPageState extends State<TimerPage> {
  
  @override
  Widget build(BuildContext context) {
    return (
      Stack(
        children: [
          Center(
            child: Text("2:24.13", style: Styles.txtTime,)
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
      )
    );
  }

}
