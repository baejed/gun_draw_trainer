import 'package:flutter/material.dart';
import 'package:gun_draw_trainer/controllers/alert_player.dart';
import 'package:gun_draw_trainer/res/styles.dart';
import 'package:gun_draw_trainer/components/header.dart';
import 'package:gun_draw_trainer/pages/timer_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    AlertPlayer.initializePlayer();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.light(primary: Color(0xFF212529), surface: Color(0xFF6C757D)),
        useMaterial3: true,
        fontFamily: "Roboto"
      ),
      home: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF212529), Color(0xFF495057)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const MyHomePage(title: 'Gun Draw Practice'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: GunDrawTrainerHeader(title: Text(widget.title, style: Styles.txtHeading)),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: TimerPage(),
      )
    );
  }
}
