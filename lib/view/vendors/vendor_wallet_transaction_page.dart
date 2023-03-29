import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:get/get.dart';
import 'package:taxi_admin_panel/constant/style.dart';
import 'package:taxi_admin_panel/widgets/custom_text.dart';

import '../../widgets/sidebar_widget.dart';
import '../authentication.dart';

class VendorWalletTransactionPage extends StatelessWidget {
  const VendorWalletTransactionPage({Key? key}) : super(key: key);

  static const String id = "vendor_wallet_transaction_page";

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
        sideBar: SideBarWidget().sidebarMenus(VendorWalletTransactionPage.id),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: Get.width,
            height: Get.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Vendor Wallet Transaction',
                  size: 20,
                  weight: FontWeight.bold,
                  color: green,
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.topLeft,
                  child: buildSearchBar(),
                ),
                const SizedBox(height: 20),
                Expanded(
                    child: ListView(
                  children: [buildVendorWalletTable()],
                )),
              ],
            ),
          ),
        ));
  }

  buildSearchBar() {
    return SizedBox(
      width: 300,
      height: 40,
      child: TextField(
        cursorColor: green,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: green)),
          suffixIcon: Icon(Icons.search, color: green),
          hintText: "Search by ID",
        ),
      ),
    );
  }

  buildVendorWalletTable() {
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
                    Text('Id', style: TextStyle(fontSize: 15, color: green))),
            DataColumn(
                label:
                    Text('Name', style: TextStyle(fontSize: 15, color: green))),
            DataColumn(
                label:
                    Text('Date', style: TextStyle(fontSize: 15, color: green))),
            DataColumn(
                label: Text('Booking Id',
                    style: TextStyle(fontSize: 15, color: green))),
            DataColumn(
                label: Text('Transaction Type',
                    style: TextStyle(fontSize: 15, color: green))),
            DataColumn(
                label: Text('Amount',
                    style: TextStyle(fontSize: 15, color: green)))
          ],
          source: dataTableSource,
          // columnSpacing: 30,
          horizontalMargin: 40,
          arrowHeadColor: green,
        ),
      ),
    );
  }
}

class MyData extends DataTableSource {
  final List<Map<String, dynamic>> data = List.generate(
      20,
      (index) => {
            "id": index + 1,
            "name": "Nivy",
            "date": "31/05/2022 3:45 PM",
            "bookingid": "ABCD1234",
            "transactiontype": "Wallet",
            "amount": "-200"
          });

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(data[index]["id"].toString())),
      DataCell(Text(data[index]["name"])),
      DataCell(Text(data[index]["date"])),
      DataCell(Text(data[index]["bookingid"])),
      DataCell(Text(data[index]["transactiontype"])),
      DataCell(Text(data[index]["amount"]))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
