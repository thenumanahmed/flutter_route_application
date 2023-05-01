import 'package:flutter/material.dart';

import '../../responsive.dart';
import '../../configs/themes/ui_parameters.dart';
import '../../functions/custom_dialog.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({
    super.key,
    required this.add,
    required this.import,
    required this.export,
    this.title = '',
  });

  final Widget add;
  final Widget import;
  final Widget export;
  final String title;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomActionButton(
          bgColor: Colors.blue,
          textColor: Colors.white,
          smallTitle: 'Add',
          largeTitle: 'Add $title',
          widget: add,
          showSmall: isMobile,
        ),
        const SizedBox(width: defaultPadding / 2),
        CustomActionButton(
          smallTitle: 'Import',
          largeTitle: 'Import $title',
          widget: add,
          showSmall: isMobile,
        ),
        const SizedBox(width: defaultPadding / 2),
        CustomActionButton(
          smallTitle: 'Export',
          largeTitle: 'Export $title',
          widget: add,
          showSmall: isMobile,
        ),
        // Tooltip(
        //   message: 'Add $title',
        //   child: ElevatedButton(
        //     onPressed: () => customDialog(
        //       context: context,
        //       title: 'Add $title',
        //       widget: add,
        //     ),
        //     child: Text(isMobile ? 'Add' : 'Add $title', style: greyText),
        //   ),
        // ),

        // Tooltip(
        //   message: 'Import $title',
        //   child: ElevatedButton(
        //     onPressed: () => customDialog(
        //       context: context,
        //       title: 'Import $title',
        //       widget: import,
        //     ),
        //     style: whiteElevatedButton,
        //     child: Text(isMobile ? 'Import' : 'Import $title', style: greyText),
        //   ),
        // ),
        // const SizedBox(width: defaultPadding / 2),
        // CustomActionButton(title: title, export: export, isMobile: isMobile)
      ],
    );
  }
}

class CustomActionButton extends StatelessWidget {
  const CustomActionButton({
    super.key,
    required this.smallTitle,
    required this.largeTitle,
    required this.widget,
    required this.showSmall,
    this.textColor = Colors.black87,
    this.bgColor = Colors.white,
  });

  final String smallTitle;
  final String largeTitle;
  final Widget widget;
  final bool showSmall;
  final Color textColor;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: largeTitle,
      child: ElevatedButton(
        onPressed: () => customDialog(
          context: context,
          title: largeTitle.toUpperCase(),
          widget: widget,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: textColor,
        ),
        child: Text(
          showSmall ? smallTitle : largeTitle,
        ),
      ),
    );
  }
}
