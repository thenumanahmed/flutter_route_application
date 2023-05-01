import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../configs/themes/app_color.dart';
import '../../../configs/themes/ui_parameters.dart';
import '../../../models/my_file.dart';
import '../../../widgets/progress_line.dart';

class FileInfoCard extends StatelessWidget {
  const FileInfoCard({
    super.key,
    required this.info,
  });
  final CloudStorageInfo info;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: defaultEdgePadding,
      decoration: BoxDecoration(
        color: secondaryColorLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(defaultPadding * 0.75),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: info.color.withOpacity(0.1)),
                child: SvgPicture.asset(
                  info.svgSrc,
                  colorFilter: ColorFilter.mode(info.color, BlendMode.srcIn),
                ),
              ),
              const Icon(
                Icons.more_vert,
                color: Colors.white54,
              ),
            ],
          ),
          Text(info.title),
          ProgressLine(
            percentage: info.percentage,
            color: info.color,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${info.numOfFiles} files',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Colors.white70),
              ),
              Text(
                '${info.totalStorage} GB',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }
}
