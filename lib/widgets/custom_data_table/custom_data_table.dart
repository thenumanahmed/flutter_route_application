import 'package:flutter/material.dart';

import '../../configs/themes/ui_parameters.dart';

import 'action_buttons.dart';

import 'custom_table.dart';

class CustomDataTable extends StatelessWidget {
  const CustomDataTable({
    super.key,
    required this.tableWidth,
    required this.title,
    required this.getDataCell,
    required this.dataColumn,
    required this.list,
    required this.add,
    required this.import,
    required this.export,
    required this.selectionImport,
    required this.selectionDelete,
    required this.searchBy,
  });
  final double tableWidth;
  final String title;
  final List<DataCell> Function(dynamic d, int index) getDataCell;
  final List<DataColumn> dataColumn;
  final List<dynamic> list;
  final Widget add;
  final Widget import;
  final Widget export;

  final Function(List<int> indexes) selectionImport;
  final Function(List<int> indexes) selectionDelete;
  final List<int> Function(String s) searchBy;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ActionButtons(
          title: title,
          add: add,
          import: import,
          export: export,
        ),
        const SizedBox(
          height: defaultPadding / 2,
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: CustomTable(
            selectionImport: selectionImport,
            selectionDelete: selectionDelete,
            dataColumn: dataColumn,
            getDataCell: getDataCell,
            hintText: 'Search $title',
            tableWidth: tableWidth,
            list: list,
            searchBy: searchBy,
          ),
        ),
      ],
    );
  }
}
