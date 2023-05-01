import 'package:flutter/material.dart';

import '../configs/themes/custom_text_styles.dart';

void customDialog({
  required BuildContext context,
  required String title,
  required Widget widget,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        title,
        style: headerText,
      ),
      // contentPadding: EdgeInsets.symmetric(horizontal: defaultPadding),
      content: widget,
    ),
  );
}
