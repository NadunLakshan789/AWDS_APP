import 'package:flutter/material.dart';
import 'package:qr_generator_tutorial/ui/Colors.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({required this.buttonText, required this.onPress});

  final String buttonText;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPress,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Text(
            buttonText,
            style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: white),
          ),
        ),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Kyellow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7), // <-- Radius
          ),
        ),
      ),
    );
  }
}
