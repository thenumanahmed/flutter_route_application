import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../configs/themes/ui_parameters.dart';
import '../../../configs/themes/app_color.dart';
import '../../../models/recent_file.dart';

class RecentFiles extends StatelessWidget {
  const RecentFiles({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: defaultPadding),
      width: double.infinity,
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColorLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Files',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              columnSpacing: defaultPadding,
              columns: recentFileDataColumn(context),
              rows: List.generate(demoRecentFiles.length,
                  (index) => recentFileDataRow(demoRecentFiles[index])),
            ),
          )
        ],
      ),
    );
  }

  List<DataColumn> recentFileDataColumn(BuildContext context) {
    return [
      DataColumn(
        label: Text(
          'File Name',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'Date',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'Size',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontStyle: FontStyle.italic),
        ),
      )
    ];
  }

  DataRow recentFileDataRow(RecentFile recentFile) {
    return DataRow(
      onLongPress: () {},
      cells: [
        DataCell(
          Row(
            children: [
              SvgPicture.asset(
                recentFile.icon,
                height: 30,
                width: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Text(recentFile.title),
              )
            ],
          ),
        ),
        DataCell(Text(recentFile.date)),
        DataCell(Text(recentFile.size)),
      ],
    );
  }
}
