import 'package:dashboard_route_app/controllers/routes_controller.dart';
import 'package:dashboard_route_app/widgets/custom_data_table/custom_data_table.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../configs/themes/ui_parameters.dart';
import '../../../functions/custom_dialog.dart';
// import '../../../functions/custom_scafold.dart';
import '../../../functions/custom_snackbar.dart';
import '../../../models/route.dart';
import '../../../responsive.dart';
import '../../../models/route.dart' as r;
import '../../../widgets/custom_icon_button.dart';
import 'add_route.dart';
import 'edit_route.dart';

class RouteTable extends StatelessWidget {
  const RouteTable({super.key});

  @override
  Widget build(BuildContext context) {
    final rc = Get.find<RouteController>();
    final avaliableWidth = Responsive.avaliableWidth(context);
    final tableWidth =
        avaliableWidth >= 650.0 ? (avaliableWidth - defaultPadding * 4) : 650.0;

    return Obx(() {
      rc.routeState.value;
      rc.updateScreen.value;
      rc.morning.value;
      rc.evening.value;
      rc.speacial.value;
      return CustomDataTable(
        key: UniqueKey(),
        tableWidth: tableWidth,
        title: getTitle(rc.routeState.value),
        getDataCell: (dynamic, index) =>
            getRouteDataCells(dynamic, index, context),
        dataColumn: getRouteDataColumn(context),
        list: getList(rc),
        add: const AddRoute(),
        import: const AddRoute(),
        export: const AddRoute(),
        selectionImport: (r) {},
        selectionDelete: (index) {
          print('HI');
          rc.selectionDelete(index).then(
              (value) => customSnackbar(context, value, 'Deleted Routes'));
        },
        searchBy: rc.searchByName,
      );
    });
  }

  String getTitle(RouteType r) {
    if (r == RouteType.morning) {
      return "Morning Route";
    } else if (r == RouteType.evening) {
      return "Evening Route";
    } else {
      return "Speacial Route";
    }
  }

  List<r.Route> getList(RouteController rc) {
    if (rc.routeState.value == RouteType.morning) {
      return rc.morning;
    } else if (rc.routeState.value == RouteType.evening) {
      return rc.evening;
    } else {
      return rc.speacial;
    }
  }

  List<DataColumn> getRouteDataColumn(BuildContext context) {
    return [
      const DataColumn(
        label: Text(
          'Route',
        ),
      ),
      const DataColumn(
        label: Text(
          'Track',
        ),
      ),
      const DataColumn(
        label: Text(
          'Driver',
        ),
      ),
      const DataColumn(
        label: Text(
          'Bus',
        ),
      ),
      const DataColumn(
        label: Text(
          'Operations',
        ),
      ),
    ];
  }

  List<DataCell> getRouteDataCells(
      dynamic data, int index, BuildContext context) {
    final route = data as r.Route;
    final rc = Get.find<RouteController>();

    return [
      DataCell(
        Text(route.name, softWrap: true),
      ),
      DataCell(Text(route.trackName)),
      DataCell(Text(route.driverName)),
      DataCell(Text(route.busNumber)),
      DataCell(Row(
        children: [
          CustomIconButton(
            onTap: () => customDialog(
              context: context,
              title: 'Edit Route'.toUpperCase(),
              widget: EditRoute(rIndex: index),
            ),
            message: 'Edit Route',
            icon: Icons.edit,
            color: Colors.blue,
          ),
          CustomIconButton(
            onTap: () => rc.selectionDelete([index]),
            message: 'Delete Route',
            icon: Icons.delete,
            color: Colors.redAccent,
          ),
        ],
      )),
    ];
  }
}
