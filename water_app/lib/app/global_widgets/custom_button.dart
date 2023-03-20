import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double? height;
  final double? width;
  final VoidCallback? callbackFunction;
  final String data;
  final Color color;
  const CustomButton(
      {Key? key,
      required this.data,
      this.callbackFunction,
      required this.color,
      this.height,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: height,
        width: width,
        child: ElevatedButton(
          onPressed: callbackFunction,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Theme.of(context).colorScheme.primary.withOpacity(0.5);
              }
              return color; // Use the component's default.
            }),
            // fixedSize: Size.fromWidth(width)
          ),
          child: Text(
            "$data",
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
