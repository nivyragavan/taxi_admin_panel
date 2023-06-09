import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:get/get.dart';
import 'package:taxi_admin_panel/constant/style.dart';
import 'package:taxi_admin_panel/widgets/custom_text.dart';

import '../../widgets/sidebar_widget.dart';
import '../authentication.dart';

class RidesHistoryPage extends StatelessWidget {
  const RidesHistoryPage({Key? key}) : super(key: key);

  static const String id = "rides_history_page";

  static final DataTableSource dataTableSource = MyData();

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
        backgroundColor: light,
        appBar: AppBar(
          title: const Text(
            'Admin Panel',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: yellow,
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
        sideBar: SideBarWidget().sidebarMenus(RidesHistoryPage.id),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: Get.width,
            height: Get.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Rides History',
                  size: 20,
                  weight: FontWeight.bold,
                  color: blue,
                ),
                const SizedBox(height: 20),
                Expanded(
                    child: ListView(
                  children: [buildRidesHistoryTable()],
                )),
              ],
            ),
          ),
        ));
  }

  buildRidesHistoryTable() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
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
        child: PaginatedDataTable(
          columns: [
            DataColumn(
                label:
                    Text('S:No', style: TextStyle(fontSize: 15, color: blue))),
            DataColumn(
                label:
                    Text('From', style: TextStyle(fontSize: 15, color: blue))),
            DataColumn(
                label:
                    Text('To', style: TextStyle(fontSize: 15, color: blue))),
            DataColumn(
                label: Text('User Id',
                    style: TextStyle(fontSize: 15, color: blue))),
            DataColumn(
                label: Text('Driver Id',
                    style: TextStyle(fontSize: 15, color: blue))),
            DataColumn(
                label: Text('Booking Id',
                    style: TextStyle(fontSize: 15, color: blue))),
            DataColumn(
                label: Text('Pickup Location',
                    style: TextStyle(fontSize: 15, color: blue))),
            DataColumn(
                label: Text('Drop Location',
                    style: TextStyle(fontSize: 15, color: blue))),
            DataColumn(
                label: Text('Package',
                    style: TextStyle(fontSize: 15, color: blue))),
            DataColumn(
                label:
                    Text('Cab', style: TextStyle(fontSize: 15, color: blue))),
            DataColumn(
                label: Text('Start OTP',
                    style: TextStyle(fontSize: 15, color: blue))),
            DataColumn(
                label: Text('End OTP',
                    style: TextStyle(fontSize: 15, color: blue))),
            DataColumn(
                label:
                    Text('KM', style: TextStyle(fontSize: 15, color: blue))),
            DataColumn(
                label: Text('Payment Method',
                    style: TextStyle(fontSize: 15, color: blue))),
            DataColumn(
                label: Text('Payment',
                    style: TextStyle(fontSize: 15, color: blue)))
          ],
          source: dataTableSource,
          columnSpacing: 30,
          horizontalMargin: 40,
          arrowHeadColor: blue,
        ),
      ),
    );
  }
}

class MyData extends DataTableSource {
  final List<Map<String, dynamic>> data = List.generate(
      20,
      (index) => {
            "S:No": index + 1,
            "From": "25/05/2023",
            "To": "31/05/2023",
            "userid": "User001",
            "driverid": "Driver001",
            "bookingid": "ABCD1234",
            "pickup": "Coimbatore",
            "drop": "Kodaikanal",
            "package": "Tour",
            "cab": "SUV",
            "startotp": "123456",
            "endotp": "098765",
            "km": "1000",
            "paymentmethod": "UPI",
            "payment": "20,000"
          });

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(data[index]["S:No"].toString())),
      DataCell(Text(data[index]["From"])),
      DataCell(Text(data[index]["To"])),
      DataCell(Text(data[index]["userid"])),
      DataCell(Text(data[index]["driverid"])),
      DataCell(Text(data[index]["bookingid"])),
      DataCell(Text(data[index]["pickup"])),
      DataCell(Text(data[index]["drop"])),
      DataCell(Text(data[index]["package"])),
      DataCell(Text(data[index]["cab"])),
      DataCell(Text(data[index]["startotp"])),
      DataCell(Text(data[index]["endotp"])),
      DataCell(Text(data[index]["km"])),
      DataCell(Text(data[index]["paymentmethod"])),
      DataCell(Text(data[index]["payment"]))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
