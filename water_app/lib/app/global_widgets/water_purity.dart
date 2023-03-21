import 'package:flutter/material.dart';

class WaterPurityContainer extends StatelessWidget {
  final double waterPurityPercentage;

  const WaterPurityContainer({super.key, required this.waterPurityPercentage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
        border: Border.all(width: 2, color: Colors.grey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(10),
                      ),
                      color: _getPurityColor(waterPurityPercentage),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 2),
                    height: 150 * waterPurityPercentage / 100,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(10),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          _getPurityColor(waterPurityPercentage),
                          Colors.transparent,
                        ],
                        stops: const [1.0, 1.5],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getPurityColor(double waterPurityPercentage) {
    if (waterPurityPercentage >= 75) {
      return Colors.green;
    } else if (waterPurityPercentage >= 50) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }
}
