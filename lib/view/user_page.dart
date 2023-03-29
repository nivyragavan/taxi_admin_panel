import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:get/get.dart';
import 'package:taxi_admin_panel/constant/style.dart';
import 'package:taxi_admin_panel/service/api_service.dart';
import 'package:taxi_admin_panel/widgets/custom_text.dart';

import '../model/registered_users_model.dart';
import '../widgets/sidebar_widget.dart';
import 'authentication.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  static const String id = "user_page";

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  RegisteredUsersListModel? registeredUsersListModel;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    registeredUsersListModel = await ApiService().registeredUsersList();
    if(registeredUsersListModel != null){
      setState(() {
        isLoading = true;
      });
      setState(() {
        registeredUsersListModel = registeredUsersListModel;
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
    sideBar: SideBarWidget().sidebarMenus(UserPage.id),
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'Users',
              size: 20,
              weight: FontWeight.bold,
              color: green,
            ),
            const SizedBox(height: 20),
            Expanded(
                child: ListView(
                  children: [buildUsersTable()],
                )),
          ],
        ),
      ),
    )
    );
  }

  buildUsersTable() {
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
            : registeredUsersListModel!.body!.userlist!.isEmpty
            ? Center(child: Image.asset('assets/images/nodatafound.png'))
            : Card(
          child: DataTable2(
              columnSpacing: 5,
              horizontalMargin: 12,
              minWidth: 1000,
              columns: [
                DataColumn(
                  label: Text('S:No', style: TextStyle(fontSize: 15, color: green)),
                ),
                DataColumn(
                  label: Text('Name', style: TextStyle(fontSize: 15, color: green)),
                ),
                DataColumn(
                  label: Text('Contact', style: TextStyle(fontSize: 15, color: green)),
                ),
                DataColumn(
                    label: Text('Email',
                        style: TextStyle(fontSize: 15, color: green))),
              ],
              rows: List.generate(
                  registeredUsersListModel!.body!.userlist!.length,
                      (index) {
                    var e = registeredUsersListModel!.body!.userlist![index];
                    return DataRow(cells: [
                      DataCell(Text('${index + 1}')),
                      DataCell(Text('${e.name}')),
                      DataCell(Text('${e.contact}')),
                      DataCell(Text('${e.email}')),
                    ]);
                  })),
        ));
  }
}