import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:get/get.dart';
import 'package:taxi_admin_panel/model/assigned_drivers_list_model.dart';
import 'package:taxi_admin_panel/service/api_service.dart';

import '../../constant/style.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/sidebar_widget.dart';
import '../authentication.dart';

class AssignedDriversListPage extends StatefulWidget {
  const AssignedDriversListPage({Key? key}) : super(key: key);

  static const String id = "assigned_drivers_list_page";

  @override
  State<AssignedDriversListPage> createState() =>
      _AssignedDriversListPageState();
}

class _AssignedDriversListPageState extends State<AssignedDriversListPage> {
  AssignedDriversListModel? assignedDriversListModel;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    assignedDriversListModel = await ApiService().assignedDriversList();
    if (assignedDriversListModel != null) {
      setState(() {
        isLoading = true;
      });
      setState(() {
        assignedDriversListModel = assignedDriversListModel;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
        backgroundColor: light,
        appBar: AppBar(
          title: const Text(
            'Admin Panel',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
                onPressed: () {
                  Get.offAll(const AuthenticationPage());
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.black,
                ))
          ],
        ),
        sideBar: SideBarWidget().sidebarMenus(AssignedDriversListPage.id),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: Get.width,
            height: Get.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Assigned Drivers List',
                  size: 20,
                  weight: FontWeight.bold,
                  color: green,
                ),
                const SizedBox(height: 20),
                Expanded(
                    child: ListView(
                  children: [buildAssignedDriversTable()],
                )),
              ],
            ),
          ),
        ));
  }

  buildAssignedDriversTable() {
    return Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: active.withOpacity(.4), width: .5),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 6),
                color: lightGrey.withOpacity(.1),
                blurRadius: 12)
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.only(bottom: 30),
        child: isLoading == false
            ? Center(
                child: CircularProgressIndicator(
                  color: green,
                ),
              )
            : assignedDriversListModel!.body!.assignList!.isEmpty
                ? Image.asset('assets/images/nodatafound.png')
                : Card(
                    child: DataTable2(
                        columnSpacing: 5,
                        horizontalMargin: 12,
                        minWidth: 1000,
                        columns: [
                          DataColumn(
                            label: Text('S:No',
                                style: TextStyle(fontSize: 15, color: green)),
                          ),
                          DataColumn(
                            label: Text('Vendor Name',
                                style: TextStyle(fontSize: 15, color: green)),
                          ),
                          DataColumn(
                            label: Text('Vendor Contact',
                                style: TextStyle(fontSize: 15, color: green)),
                          ),
                          DataColumn(
                              label: Text('Cab Register Number',
                                  style:
                                      TextStyle(fontSize: 15, color: green))),
                          DataColumn(
                              label: Text('Driver Name',
                                  style:
                                      TextStyle(fontSize: 15, color: green))),
                          DataColumn(
                              label: Text('Driver Contact',
                                  style:
                                      TextStyle(fontSize: 15, color: green))),
                        ],
                        rows: List.generate(
                            assignedDriversListModel!.body!.assignList!.length,
                            (index) {
                          var e = assignedDriversListModel!
                              .body!.assignList![index];
                          return DataRow(cells: [
                            DataCell(Text('${index + 1}')),
                            DataCell(Text('${e.vendorName}')),
                            DataCell(Text('${e.vendorContact}')),
                            DataCell(Text('${e.carCarNumber}')),
                            DataCell(Text('${e.driverName}')),
                            DataCell(Text('${e.driverContact}')),
                          ]);
                        })),
                  ));
  }
}
