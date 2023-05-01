import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../configs/themes/app_color.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    required this.onPress,
    required this.title,
    this.svgSrc,
    this.imageSrc,
    required this.isSelected,
  });
  final Function()? onPress;
  final String? svgSrc;
  final String? imageSrc;
  final String title;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    Widget leadingIcon = const SizedBox.shrink();
    if (svgSrc == null && imageSrc != null) {
      leadingIcon = Image.asset(
        imageSrc!,
        color: Colors.white54,
        height: 16,
      );
    } else if (svgSrc != null && imageSrc == null) {
      leadingIcon = SvgPicture.asset(
        svgSrc!,
        height: 16,
        colorFilter: const ColorFilter.mode(Colors.white54, BlendMode.srcIn),
      );
    }

    return ListTile(
      selectedTileColor: primaryColorLight,
      selected: isSelected,
      onTap: onPress,
      horizontalTitleGap: 0.0,
      leading: leadingIcon,
      title: Text(
        title,
        style: const TextStyle(color: Colors.white54),
      ),
    );
  }
}
