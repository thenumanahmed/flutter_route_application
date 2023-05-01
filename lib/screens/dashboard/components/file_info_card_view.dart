import 'package:flutter/material.dart';

import '../../../configs/themes/ui_parameters.dart';
import '../../../models/my_file.dart';
import './file_info_card.dart';

class FileInfoCardView extends StatelessWidget {
  const FileInfoCardView({
    super.key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 16 / 3,
  });
  final int crossAxisCount;
  final double childAspectRatio;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: 4,
      itemBuilder: (context, index) => FileInfoCard(
        info: demoMyFiles[index],
      ),
    );
  }
}
