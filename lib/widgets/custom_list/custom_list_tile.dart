import 'package:flutter/material.dart';

import '../../configs/themes/ui_parameters.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.index,
    required this.isSelected,
    required this.selection,
    this.onLongPress,
    this.onTap,
    required this.tile,
  });
  final int index;
  final bool isSelected;
  final bool selection;
  final Widget tile;
  final Function()? onLongPress;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        color: getTileColor(),
        padding: getTilePadding(),
        width: double.infinity,
        child: Row(
          children: [
            SizedBox(
              width: 30,
              height: 20,
              child: getIndexCheckBox(),
            ),
            kHalfWidthSpace,
            tile,
          ],
        ),
      ),
    );
  }

  Widget getIndexCheckBox() {
    return selection
        ? Checkbox(
            value: isSelected,
            onChanged: (val) => onTap!(),
          )
        : Text(
            '#${index + 1}',
            style: const TextStyle(color: Colors.black),
          );
  }

  EdgeInsets getTilePadding() {
    return const EdgeInsets.symmetric(
      horizontal: defaultPadding,
      vertical: defaultPadding / 2,
    );
  }

  Color getTileColor() {
    return isSelected ? const Color.fromARGB(255, 155, 211, 248) : Colors.white;
  }
}
