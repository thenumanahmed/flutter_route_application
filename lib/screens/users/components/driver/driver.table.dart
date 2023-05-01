import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../configs/themes/ui_parameters.dart';
import '../../../../controllers/users_controller.dart';
import '../../../../models/users.dart';
import '../../../../responsive.dart';
import '../../../../widgets/custom_data_table/custom_data_table.dart';
import '../../../../widgets/custom_icon_button.dart';
import 'add_driver.dart';

class DriverTable extends StatelessWidget {
  const DriverTable({super.key});

  @override
  Widget build(BuildContext context) {
    final uc = Get.find<UsersController>();
    final avaliableWidth = Responsive.avaliableWidth(context);
    final tableWidth =
        avaliableWidth >= 650.0 ? (avaliableWidth - defaultPadding * 4) : 650.0;
    return Obx(
      () => CustomDataTable(
        add: const AddDriver(),
        import: const Text('Import'),
        export: const Text('Export'),
        selectionImport: selectionImport,
        selectionDelete: selectionDelete,
        title: 'Drivers',
        tableWidth: tableWidth,
        dataColumn: getDriverDataColumn(context),
        getDataCell: getDriverDataCells,
        searchBy: searchByName,
        // ignore: invalid_use_of_protected_member
        list: uc.drivers.value,
      ),
    );
  }

  List<DataColumn> getDriverDataColumn(BuildContext context) {
    return [
      const DataColumn(
        label: Text(
          'Username',
        ),
      ),
      const DataColumn(
        label: Text(
          'Email',
        ),
      ),
      const DataColumn(
        label: Text(
          'Phone No',
        ),
      ),
      const DataColumn(
        label: Text(
          'Blocked',
        ),
      ),
      const DataColumn(
        label: Text(
          'Operations',
        ),
      ),
    ];
  }

  List<DataCell> getDriverDataCells(
    dynamic data,
    int index,
  ) {
    final member = data as User;
    return [
      DataCell(
        Text(member.username, softWrap: true),
      ),
      DataCell(Text(member.email)),
      DataCell(Text(member.password)),
      DataCell(Text(member.isBlocked ? "Yes" : "No")),
      DataCell(Row(
        children: [
          CustomIconButton(
            onTap: () => editDriver(index),
            message: 'Edit Driver',
            icon: Icons.edit,
            color: Colors.blue,
          ),
          CustomIconButton(
            onTap: () => deleteDriver(index),
            message: 'Delete Driver',
            icon: Icons.delete,
            color: Colors.redAccent,
          ),
        ],
      )),
    ];
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

  void editDriver(int index) {}

  void deleteDriver(int index) {
    final uc = Get.find<UsersController>();
    uc.deleteUser(index, UserType.driver);
  }

  List<int> searchByName(String s) {
    List<int> list = [];
    final bc = Get.find<UsersController>();
    for (int i = 0; i < bc.drivers.length; i++) {
      if (bc.drivers[i].username.capitalize!.contains(s.capitalize!) ||
          bc.drivers[i].email.capitalize!.contains(s.capitalize!) ||
          bc.drivers[i].phoneNo.capitalize!.contains(s.capitalize!)) {
        list.add(i);
      }
    }
    return list;
  }
}
