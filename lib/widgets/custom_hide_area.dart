import 'package:flutter/material.dart';

import '../configs/themes/app_color.dart';
import '../responsive.dart';
import './curve_icon_button.dart';

enum HidePos { left, right, top, bottom }

class CustomHideArea extends StatelessWidget {
  const CustomHideArea({
    super.key,
    this.hidePos = HidePos.left,
    required this.height,
    this.hideSize = 250,
    this.allwaysHide = true,
    required this.message,
    this.buttonBackground = Colors.white,
    this.buttonForeground = Colors.black54,
    required this.hide,
    required this.main,
  });
  final HidePos hidePos;
  final Widget main;
  final Widget hide;
  final double height;
  final double hideSize;
  final bool allwaysHide;
  final String message;
  final Color buttonBackground;
  final Color buttonForeground;
  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Stack(
        children: [
          Container(
            padding: getPadding(isMobile),
            child: SizedBox(
              height: height,
              width: double.infinity,
              child: main,
            ),
          ),
          SizedBox(
            height: height,
            width: double.infinity,
            child: HiddenArea(
              hidePos: hidePos,
              isMobile: isMobile,
              allwaysHide: allwaysHide,
              message: message,
              buttonBackground: buttonBackground,
              buttonForeground: buttonForeground,
              child: hide,
            ),
          ),
        ],
      ),
    );
  }

  getPadding(bool isMobile) {
    if (isMobile || allwaysHide) return null;
    if (hidePos == HidePos.left) {
      return EdgeInsets.only(left: hideSize);
    } else if (hidePos == HidePos.right) {
      return EdgeInsets.only(right: hideSize);
    } else if (hidePos == HidePos.top) {
      return EdgeInsets.only(top: hideSize);
    } else {
      return EdgeInsets.only(bottom: hideSize);
    }
  }
}

class HiddenArea extends StatefulWidget {
  const HiddenArea({
    super.key,
    required this.isMobile,
    required this.child,
    required this.hidePos,
    required this.allwaysHide,
    required this.message,
    required this.buttonBackground,
    required this.buttonForeground,
  });
  final bool isMobile;
  final Widget child;
  final HidePos hidePos;
  final bool allwaysHide;
  final String message;
  final Color buttonBackground;
  final Color buttonForeground;
  @override
  State<HiddenArea> createState() => _HiddenAreaState();
}

class _HiddenAreaState extends State<HiddenArea> {
  bool showContainer = false;
  final bottomArrow = Icons.keyboard_arrow_down_rounded;
  final topArrow = Icons.keyboard_arrow_up_rounded;
  final rightArrow = Icons.arrow_forward_ios_rounded;
  final leftArrow = Icons.arrow_back_ios_new_rounded;

  void onPress() {
    setState(() {
      showContainer = !showContainer;
    });
  }

  @override
  void initState() {
    if (!widget.isMobile || !widget.allwaysHide) {
      showContainer = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isMobile && !widget.allwaysHide) showContainer = true;

    if (widget.hidePos == HidePos.left) {
      return leftHide();
    } else if (widget.hidePos == HidePos.right) {
      return rightHide();
    } else if (widget.hidePos == HidePos.top) {
      return topHide();
    } else {
      return bottomHide();
    }
  }

  Widget getHideWidget() {
    return showContainer
        ? Container(
            decoration: BoxDecoration(
              boxShadow: kShadow,
            ),
            child: widget.child,
          )
        : const SizedBox.shrink();
  }

  Widget getButton() {
    if (!widget.isMobile && !widget.allwaysHide) {
      return const SizedBox.shrink();
    }

    if (widget.hidePos == HidePos.left) {
      return showContainer == true
          ? getCurveIconButton(rightArrow, CurveDirection.right)
          : getCurveIconButton(leftArrow, CurveDirection.right);
    } else if (widget.hidePos == HidePos.right) {
      return showContainer
          ? getCurveIconButton(rightArrow, CurveDirection.left)
          : getCurveIconButton(leftArrow, CurveDirection.left);
    } else if (widget.hidePos == HidePos.top) {
      return showContainer
          ? getCurveIconButton(topArrow, CurveDirection.bottom)
          : getCurveIconButton(bottomArrow, CurveDirection.bottom);
    } else {
      return showContainer
          ? getCurveIconButton(bottomArrow, CurveDirection.top)
          : getCurveIconButton(topArrow, CurveDirection.top);
    }
  }

  Widget getCurveIconButton(IconData icon, CurveDirection curveDirection) {
    return Tooltip(
      message: widget.message,
      child: CurveIconButton(
        icon: icon,
        onPress: onPress,
        curveDirection: curveDirection,
        background: widget.buttonBackground,
        foreground: widget.buttonForeground,
      ),
    );
  }

  Widget leftHide() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        getHideWidget(),
        getButton(),
      ],
    );
  }

  Widget rightHide() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        getButton(),
        getHideWidget(),
      ],
    );
  }

  Widget topHide() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        getHideWidget(),
        getButton(),
      ],
    );
  }

  Widget bottomHide() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        getButton(),
        getHideWidget(),
      ],
    );
  }
}
