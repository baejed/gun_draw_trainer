import 'package:flutter/material.dart';

class GunDrawTrainerHeader extends StatelessWidget{
  const GunDrawTrainerHeader({super.key, required this.title});

  final Text title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            title
          ],
        ),
      ),
    );
  }

}