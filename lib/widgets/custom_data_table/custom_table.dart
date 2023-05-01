import 'package:flutter/material.dart';

import '../../configs/themes/ui_parameters.dart';
import '../custom_scrollable_area.dart';
import '../custom_icon_button.dart';
import '../custom_search_bar.dart';
import './table_header.dart';

class CustomTable extends StatefulWidget {
  const CustomTable({
    super.key,
    required this.selectionImport,
    required this.selectionDelete,
    required this.hintText,
    required this.tableWidth,
    required this.getDataCell,
    required this.dataColumn,
    required this.list,
    required this.searchBy,
  });

  final double tableWidth;
  final String hintText;

  final Function(List<int> indexes) selectionImport;
  final Function(List<int> indexes) selectionDelete;
  final List<DataCell> Function(dynamic d, int index) getDataCell;
  final List<DataColumn> dataColumn;
  final List<dynamic> list;
  final List<int> Function(String s) searchBy;

  @override
  State<CustomTable> createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {
  bool isSelection = false;
  Set<int> selectedRows = <int>{};
  List<int> selectedList = [];
  final TextEditingController searchController = TextEditingController();

  addSelectedRow(int index) {
    final isChanged = selectedRows.add(index);
    isChanged ? setState(() {}) : null;
  }

  removeSelectedRow(int index) {
    if (selectedRows.remove(index) == true) {
      setState(() {});
    }
  }

  addAllSelectedRow() {
    selectedRows.addAll(selectedList);
    setState(() {});
  }

  removeAllSelectedRow() {
    selectedRows.removeAll(selectedList);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: TableHeader.height),
          child: CustomScrollableArea(
            width: widget.tableWidth,
            widget: _getTable(),
          ),
        ),
        TableHeader(
          leadingWidget: Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
              child: CustomSearchBar(
                hintText: widget.hintText,
                controller: searchController,
                onChange: () {
                  setState(() {});
                },
              ),
            ),
          ),
          trailingWidget: isSelection
              ? Row(
                  children: [
                    CustomIconButton(
                      onTap: () => widget.selectionImport(
                        selectedRows.toList(),
                      ),
                      message: 'Import',
                      icon: Icons.keyboard_double_arrow_up,
                    ),
                    CustomIconButton(
                      onTap: () =>
                          widget.selectionDelete(selectedRows.toList()),
                      icon: Icons.delete_forever,
                      message: 'Delete',
                    )
                  ],
                )
              : null,
        ),
      ],
    );
  }

  Widget _getTable() {
    final searchText = searchController.text;

    if (searchText == '') {
      for (int i = 0; i < widget.list.length; i++) {
        selectedList.add(i);
      }
    } else {
      selectedList = widget.searchBy(searchText);
    }

    return DataTable(
      clipBehavior: Clip.hardEdge,
      columns: widget.dataColumn,
      showCheckboxColumn: isSelection,
      onSelectAll: (value) {
        if (value == true) {
          addAllSelectedRow();
        } else if (value == false) {
          removeAllSelectedRow();
        }
      },
      rows: List.generate(widget.list.length, (index) {
        if (!selectedList.contains(index)) return null;
        return _trackDataRow(
          index: index,
          data: widget.list[index],
        );
      }).where((element) => element != null).toList().cast<DataRow>(),
    );
  }

  DataRow _trackDataRow({
    required int index,
    required dynamic data,
  }) {
    return DataRow(
      onLongPress: () {
        setState(() {
          isSelection = !isSelection;
        });
      },
      selected: selectedRows.contains(index),
      cells: widget.getDataCell(data, index),
      onSelectChanged: (v) {
        v == true ? addSelectedRow(index) : removeSelectedRow(index);
      },
    );
  }

  bool shouldSkip(list) {
    return false;
  }
}
