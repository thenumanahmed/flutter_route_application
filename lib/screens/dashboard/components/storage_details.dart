import 'package:flutter/material.dart';

import '../../../configs/themes/app_color.dart';
import '../../../configs/themes/ui_parameters.dart';
import './chart.dart';
import './storage_info_card.dart';

class StorageDetails extends StatelessWidget {
  const StorageDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: defaultEdgePadding,
      decoration: BoxDecoration(
        color: secondaryColorLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Storage Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: defaultPadding),
          Chart(),
          const StorageInfoCard(
            svgSrc: "assets/icons/Documents.svg",
            title: "Documents",
            amountOfFiles: 1.3,
            noOfFile: 1328,
          ),
          const StorageInfoCard(
            svgSrc: "assets/icons/media.svg",
            title: "Media Files",
            amountOfFiles: 15.3,
            noOfFile: 1328,
          ),
          const StorageInfoCard(
            svgSrc: "assets/icons/folder.svg",
            title: "Other Files",
            amountOfFiles: 1.3,
            noOfFile: 1328,
          ),
          const StorageInfoCard(
            svgSrc: "assets/icons/unknown.svg",
            title: "Unknown",
            amountOfFiles: 1.3,
            noOfFile: 1328,
          ),
        ],
      ),
    );
  }
}
