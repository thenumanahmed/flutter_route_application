// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../configs/themes/ui_parameters.dart';
import '../../../../controllers/users_controller.dart';
import '../../../../functions/custom_dialog.dart';
import '../../../../functions/custom_snackbar.dart';
import '../../../../models/users.dart';
import '../../../../responsive.dart';
import '../../../../widgets/custom_data_table/custom_data_table.dart';
import '../../../../widgets/custom_icon_button.dart';
import '../operations/add_user.dart';
import '../operations/edit_user.dart';

class AdminTable extends StatelessWidget {
  const AdminTable({super.key});

  @override
  Widget build(BuildContext context) {
    final uc = Get.find<UsersController>();
    final avaliableWidth = Responsive.avaliableWidth(context);
    final tableWidth =
        avaliableWidth >= 650.0 ? (avaliableWidth - defaultPadding * 4) : 650.0;
    return Obx(
      () => CustomDataTable(
        add: const AddUser(userType: UserType.admin),
        import: const Text('Import'),
        export: const Text('Export'),
        selectionImport: selectionImport,
        selectionDelete: (indexes) => selectionDelete(context, indexes),
        title: 'Admins',
        tableWidth: tableWidth,
        dataColumn: getAdminDataColumn(context),
        getDataCell: (data, index) => getAdminDataCells(context, data, index),
        searchBy: searchByName,
        list: uc.admins.value,
      ),
    );
  }

  List<DataColumn> getAdminDataColumn(BuildContext context) {
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

  List<DataCell> getAdminDataCells(
    BuildContext context,
    dynamic data,
    int index,
  ) {
    final admin = data as User;
    return [
      DataCell(
        Text(admin.username, softWrap: true),
      ),
      DataCell(Text(admin.email)),
      DataCell(Text(admin.phoneNo)),
      DataCell(Text(admin.isBlocked ? "Yes" : "No")),
      DataCell(Row(
        children: [
          CustomIconButton(
            onTap: () => customDialog(
              context: context,
              title: 'EDIT ADMIN',
              widget:
                  EditUser(index: index, user: data, userType: UserType.admin),
            ),
            message: 'Edit Admin',
            icon: Icons.edit,
            color: Colors.blue,
          ),
          CustomIconButton(
            onTap: () => deleteAdmin(context, index),
            message: 'Delete Admin',
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
    Get.find<UsersController>()
        .deleteUsers(ctx, indexes, UserType.admin)
        .then((value) {
      customSnackbar(ctx, value, 'Deleted Admins');
    });
  }

  void editAdmin(int index) {}

  void deleteAdmin(BuildContext context, int index) {
    final uc = Get.find<UsersController>();
    print('call');
    uc.deleteUser(context, index, UserType.admin);
  }

  List<int> searchByName(String s) {
    List<int> list = [];
    final bc = Get.find<UsersController>();
    for (int i = 0; i < bc.admins.length; i++) {
      if (bc.admins[i].username.capitalize!.contains(s.capitalize!) ||
          bc.admins[i].email.capitalize!.contains(s.capitalize!) ||
          bc.admins[i].phoneNo.capitalize!.contains(s.capitalize!)) {
        list.add(i);
      }
    }
    return list;
  }
}
