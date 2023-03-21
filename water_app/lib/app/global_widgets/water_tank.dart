import 'package:flutter/material.dart';

class WaterTankCard extends StatelessWidget {
  final double waterLevel;

  const WaterTankCard({super.key, required this.waterLevel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white10,
        border: Border.all(width: 2, color: Colors.grey),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 150 * waterLevel / 100,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    waterLevel >= 90
                        ? Colors.blue
                        : waterLevel >= 50
                            ? Colors.lightBlue
                            : Colors.red,
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.0],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedContainer(
              duration: const Duration(seconds: 2),
              height: 150 * waterLevel / 100,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    waterLevel >= 90
                        ? Colors.blue
                        : waterLevel >= 50
                            ? Colors.lightBlue
                            : Colors.red,
                    Colors.transparent,
                  ],
                  stops: const [0.0, 1.0],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
