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
        selectionDelete: selectionDelete,
        title: 'Buses',
        tableWidth: tableWidth,
        dataColumn: getBusDataColumn(context),
        getDataCell: getBusDataCells,
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
      DataCell(
        Row(
          children: [
            CustomIconButton(
              onTap: () => editBus(index),
              message: 'Edit Track',
              icon: Icons.edit,
              color: Colors.blue,
            ),
            CustomIconButton(
              onTap: () => deleteBus(index),
              message: 'Delete Track',
              icon: Icons.delete,
              color: Colors.redAccent,
            ),
          ],
        ),
      ),
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

  void selectionDelete(List<int> indexes) {
    if (kDebugMode) {
      print('Selection Delete : ${indexes.toString()}');
    }
  }

  void editBus(int index) {}

  void deleteBus(int index) {
    final bc = Get.find<BusController>();
    bc.deleteBuses([index]);
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
