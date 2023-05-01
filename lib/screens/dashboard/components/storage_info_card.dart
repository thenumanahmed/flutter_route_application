import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../configs/themes/ui_parameters.dart';
import '../../../configs/themes/app_color.dart';

class StorageInfoCard extends StatelessWidget {
  const StorageInfoCard({
    super.key,
    required this.svgSrc,
    required this.title,
    required this.amountOfFiles,
    required this.noOfFile,
  });
  final String svgSrc;
  final String title;
  final double amountOfFiles;
  final int noOfFile;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: defaultPadding),
      padding: defaultEdgePadding,
      decoration: BoxDecoration(
        border: Border.all(color: primaryColorLight.withOpacity(0.1)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(svgSrc),
          kWidthSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              Text(
                '$noOfFile Files',
                style: Theme.of(context).textTheme.labelMedium,
              )
            ],
          ),
          const Spacer(),
          Text('${amountOfFiles.toStringAsFixed(1)} GB')
        ],
      ),
    );
  }
}
