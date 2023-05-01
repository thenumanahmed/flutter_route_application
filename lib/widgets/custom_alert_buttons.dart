import 'package:flutter/material.dart';

import '../configs/themes/custom_text_styles.dart';
import '../configs/themes/ui_parameters.dart';

class CustomAlertButton extends StatelessWidget {
  const CustomAlertButton(
      {super.key, required this.onTap, required this.title});
  final Function() onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: whiteElevatedButton,
          child: const Text(
            'Cacel',
            style: TextStyle(color: Colors.black87),
          ),
        ),
        kWidthSpace,
        ElevatedButton(
          onPressed: onTap,
          child: Text(
            title,
          ),
        ),
      ],
    );
  }
}
