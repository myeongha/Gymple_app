import 'package:flutter/material.dart';

class GreenFitnessImage extends StatelessWidget {
  final int dayNum;
  const GreenFitnessImage({super.key, required this.dayNum});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.green.shade700, width: 4),
          ),
          child: Icon(
            Icons.fitness_center_outlined,
            color: Colors.green.shade700,
            size: 50,
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 3),
          decoration: BoxDecoration(
            color: Colors.green.shade300,
            borderRadius: BorderRadius.circular(5),
          ),
          width: 30,
          child: Text(
            '$dayNum일',
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
