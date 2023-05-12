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

class MemberTable extends StatelessWidget {
  const MemberTable({super.key});

  @override
  Widget build(BuildContext context) {
    final uc = Get.find<UsersController>();
    final avaliableWidth = Responsive.avaliableWidth(context);
    final tableWidth =
        avaliableWidth >= 650.0 ? (avaliableWidth - defaultPadding * 4) : 650.0;
    return Obx(
      () => CustomDataTable(
        add: const AddUser(userType: UserType.member),
        import: const Text('Import'),
        export: const Text('Export'),
        selectionImport: selectionImport,
        selectionDelete: (indexes) => selectionDelete(context, indexes),

        title: 'Members',
        tableWidth: tableWidth,
        dataColumn: getMemberDataColumn(context),
        getDataCell: (data, index) => getMemberDataCells(context, data, index),
        searchBy: searchByName,
        // ignore: invalid_use_of_protected_member
        list: uc.members.value,
      ),
    );
  }

  List<DataColumn> getMemberDataColumn(BuildContext context) {
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

  List<DataCell> getMemberDataCells(
    BuildContext context,
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
            onTap: () => customDialog(
              context: context,
              title: 'EDIT DRIVER',
              widget:
                  EditUser(index: index, user: data, userType: UserType.member),
            ),
            message: 'Edit Member',
            icon: Icons.edit,
            color: Colors.blue,
          ),
          CustomIconButton(
            onTap: () => deleteMember(context, index),
            message: 'Delete Member',
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
      customSnackbar(ctx, value, 'Deleted Users');
    });
  }

  void editMember(int index) {}

  void deleteMember(BuildContext context, int index) {
    final uc = Get.find<UsersController>();
    uc.deleteUser(context, index, UserType.member);
  }

  List<int> searchByName(String s) {
    List<int> list = [];
    final bc = Get.find<UsersController>();
    for (int i = 0; i < bc.members.length; i++) {
      if (bc.members[i].username.capitalize!.contains(s.capitalize!) ||
          bc.members[i].email.capitalize!.contains(s.capitalize!) ||
          bc.members[i].phoneNo.capitalize!.contains(s.capitalize!)) {
        list.add(i);
      }
    }
    return list;
  }
}
