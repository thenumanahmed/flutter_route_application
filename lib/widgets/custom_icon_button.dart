import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.onTap,
    this.message = '',
    this.icon,
    this.svgIcon,
    this.color = Colors.black54,
  });

  final IconData? icon;
  final String? svgIcon;
  final String message;
  final Color? color;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      child: IconButton(
        onPressed: onTap,
        icon: _getIcon(),
      ),
    );
  }

  Widget _getIcon() {
    if (icon != null) {
      return Icon(
        icon,
        color: color,
      );
    } else if (svgIcon != null) {
      return SvgPicture.asset(
        svgIcon!,
        colorFilter: ColorFilter.mode(color!, BlendMode.srcIn),
      );
    }
    return const SizedBox.shrink();
  }
}

class CustomSuffixButton extends StatelessWidget {
  const CustomSuffixButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.message = '',
  });

  final IconData icon;
  final String message;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      child: GestureDetector(
        onTap: onTap,
        child: Icon(icon),
      ),
    );
  }
}
