import 'package:flutter/material.dart';

import '../../configs/themes/app_color.dart';
import '../../configs/themes/ui_parameters.dart';

class TableHeader extends StatelessWidget {
  const TableHeader(
      {super.key,
      this.title,
      this.titleText,
      this.leadingIcon,
      this.leadingOnTap,
      this.trailingIcon,
      this.trailingOnTap,
      this.leadingIconData,
      this.trailingIconData,
      this.trailingWidget,
      this.leadingWidget});
  final Widget? title;
  final String? titleText;

  final IconData? leadingIconData;
  final Widget? leadingIcon;
  final Widget? leadingWidget;
  final Function()? leadingOnTap;

  final IconData? trailingIconData;
  final Widget? trailingIcon;
  final Widget? trailingWidget;
  final Function()? trailingOnTap;

  static const height = 55.0;
  @override
  Widget build(BuildContext context) {
    final leading = getLeading();
    final trailing = getTrailing();
    final title = getTitle();

    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(defaultPadding)),
        boxShadow: kShadow,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (leading != null) ...[
            leading,
            kWidthSpace,
          ],
          title,
          if (trailing != null) ...[
            if (leading == null) const Spacer(),
            trailing,
          ],
        ],
      ),
    );
  }

  getTitle() {
    if (titleText != null) {
      return Padding(
        padding: defaultVerticalPadding,
        child: Text(
          titleText!,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
        ),
      );
    } else if (title != null) {
      return title;
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget? getLeading() {
    if (leadingIconData != null) {
      return GestureDetector(
        onTap: leadingOnTap,
        child: Icon(
          leadingIconData,
          size: 16,
        ),
      );
    } else if (leadingIcon != null) {
      return GestureDetector(
        onTap: leadingOnTap,
        child: leadingIcon,
      );
    } else if (leadingWidget != null) {
      return leadingWidget;
    } else {
      return null;
    }
  }

  Widget? getTrailing() {
    if (trailingIconData != null) {
      return GestureDetector(
        onTap: trailingOnTap,
        child: Icon(
          trailingIconData,
          size: 16,
        ),
      );
    } else if (trailingIcon != null) {
      return GestureDetector(
        onTap: trailingOnTap,
        child: trailingIcon,
      );
    } else if (trailingWidget != null) {
      return trailingWidget;
    } else {
      return null;
    }
  }
}
