import 'package:dashboard_route_app/models/bus.dart';
import 'package:dashboard_route_app/screens/buses/components/add_bus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../configs/themes/ui_parameters.dart';
import '../../../controllers/bus_controller.dart';
import '../../../responsive.dart';
import '../../../widgets/custom_data_table/custom_data_table.dart';
import '../../../widgets/custom_icon_button.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final bc = Get.find<BusController>();
    final avaliableWidth = Responsive.avaliableWidth(context);
    final tableWidth =
        avaliableWidth >= 650.0 ? (avaliableWidth - defaultPadding * 4) : 650.0;

    return Obx(
      () => CustomDataTable(
        add: const AddBus(),
        import: const Text('Add'),
        export: const Text('Add'),
        selectionImport: selectionImport,
        selectionDelete: (indexes) => selectionDelete(context, indexes),
        title: 'Buses',
        tableWidth: tableWidth,
        dataColumn: getBusDataColumn(context),
        getDataCell: (data, index) => getBusDataCells(context, data, index),
        searchBy: bc.searchByName,
        // ignore: invalid_use_of_protected_member
        list: bc.buses.value,
      ),
    );
  }

  List<DataColumn> getBusDataColumn(BuildContext context) {
    return [
      const DataColumn(
        label: Text(
          'Number Plate',
        ),
      ),
      const DataColumn(
        label: Text(
          'Model No',
        ),
      ),
      const DataColumn(
        label: Text(
          'Is Working',
        ),
      ),
      const DataColumn(
        label: Text(
          'Operations',
        ),
      ),
    ];
  }

  List<DataCell> getBusDataCells(
    BuildContext context,
    dynamic data,
    int index,
  ) {
    final bus = data as Bus;
    return [
      DataCell(
        Text(bus.numberPlate, softWrap: true),
      ),
      DataCell(Text(bus.modelNo.toString())),
      DataCell(Text(bus.isWorking ? "Yes" : "No")),
      DataCell(Row(
        children: [
          CustomIconButton(
            onTap: () => editBus(context, index),
            message: 'Edit Track',
            icon: Icons.edit,
            color: Colors.blue,
          ),
          CustomIconButton(
            onTap: () => deleteBus(context, index),
            message: 'Delete Track',
            icon: Icons.delete,
            color: Colors.redAccent,
          ),
        ],
      )),
    ];
  }

  void add() {
    if (kDebugMode) {
      print('Add');
    }
  }

  void import() {
    if (kDebugMode) {
      print('Import');
    }
  }

  void export() {
    if (kDebugMode) {
      print('Export');
    }
  }

  void selectionImport(List<int> indexes) {
    if (kDebugMode) {
      print('Selection Import : ${indexes.toString()}');
    }
  }

  void selectionDelete(BuildContext ctx, List<int> indexes) {
    Get.find<BusController>().deleteBuses(ctx, indexes);
  }

  void editBus(BuildContext context, int index) {}

  void deleteBus(BuildContext context, int index) {
    final bc = Get.find<BusController>();
    bc.deleteBuses(context, [index]);
  }

  List<int> searchByName(String s) {
    List<int> list = [];
    final bc = Get.find<BusController>();
    for (int i = 0; i < bc.buses.length; i++) {
      if (bc.buses[i].numberPlate.capitalize!.contains(s.capitalize!)) {
        list.add(i);
      }
    }
    return list;
  }
}
