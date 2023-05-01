import 'package:flutter/material.dart';

import '../configs/themes/app_color.dart';
import 'custom_data_table/table_header.dart';
import 'custom_hide_area.dart';
import 'custom_list/custom_list.dart';

class HeaderListArea extends StatelessWidget {
  const HeaderListArea({
    super.key,
    required this.tableHeader,
    required this.customList,
    required this.body,
    required this.height,
    this.message = '',
    this.hideSize = 250,
    this.hidePos = HidePos.left,
    this.alwaysHide = false,
  });
  final TableHeader tableHeader;

  final CustomList customList;
  final Widget body;
  final double height;
  final double hideSize;
  final HidePos hidePos;
  final bool alwaysHide;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: const EdgeInsets.symmetric(vertical: defaultPadding),
        width: double.infinity,
        decoration: BoxDecoration(
          color: secondaryColorLight,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: TableHeader.height),
              child: CustomHideArea(
                height: height - TableHeader.height,
                hideSize: hideSize,
                hidePos: hidePos,
                allwaysHide: alwaysHide,
                message: message,
                hide: customList,
                main: body,
              ),
            ),
            tableHeader,
          ],
        ));
  }
}
