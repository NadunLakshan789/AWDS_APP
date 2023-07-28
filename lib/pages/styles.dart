import 'package:flutter/material.dart';
import 'package:qr_generator_tutorial/ui/Colors.dart';

class Styles {
  static AppBar appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      //leadingWidth: 30,
      titleSpacing: 0,
      backgroundColor: white,
      foregroundColor: Colors.black,
      leading: Padding(
        padding: const EdgeInsets.only(left: 22),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 24,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      title: const Text('Back'),
    );
  }

  static var defaultPadding =
      const EdgeInsets.symmetric(horizontal: 35, vertical: 0);
}
