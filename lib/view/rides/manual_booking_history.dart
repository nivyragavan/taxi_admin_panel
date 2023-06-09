import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:taxi_admin_panel/constant/style.dart';
import 'package:taxi_admin_panel/model/manual_booking_history_model.dart';
import 'package:taxi_admin_panel/service/api_service.dart';
import 'package:taxi_admin_panel/widgets/custom_text.dart';

import '../../widgets/sidebar_widget.dart';
import '../authentication.dart';

class ManualBookingHistoryPage extends StatefulWidget {
  const ManualBookingHistoryPage({Key? key}) : super(key: key);

  static const String id = "manual_booking_history_page";

  @override
  State<ManualBookingHistoryPage> createState() =>
      _ManualBookingHistoryPageState();
}

class _ManualBookingHistoryPageState extends State<ManualBookingHistoryPage> {
  ManualBookingHistoryModel? manualBookingHistoryModel;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    manualBookingHistoryModel = await ApiService().manualBookingHistory();
    if (manualBookingHistoryModel != null) {
      setState(() {
        isLoading = true;
      });
      setState(() {
        manualBookingHistoryModel = manualBookingHistoryModel;
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
        sideBar: SideBarWidget().sidebarMenus(ManualBookingHistoryPage.id),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: Get.width,
            height: Get.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Manual Booking History',
                  size: 20,
                  weight: FontWeight.bold,
                  color: blue,
                ),
                const SizedBox(height: 20),
                Expanded(
                    child: ListView(
                  children: [buildManualBookingHistoryTable()],
                )),
              ],
            ),
          ),
        ));
  }

  buildManualBookingHistoryTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
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
              : manualBookingHistoryModel!.body!.bookedRides!.isEmpty
                  ? Center(child: Image.asset('assets/images/nodatafound.png'))
                  : Card(
                      child: DataTable2(
                          columnSpacing: 5,
                          horizontalMargin: 12,
                          minWidth: 1000,
                          columns: [
                            DataColumn(
                              label: Text('S:No',
                                  style: TextStyle(fontSize: 15, color: blue)),
                            ),
                            DataColumn(
                              label: Text('Added by',
                                  style: TextStyle(fontSize: 15, color: blue)),
                            ),
                            DataColumn(
                              label: Text('Name',
                                  style: TextStyle(fontSize: 15, color: blue)),
                            ),
                            DataColumn(
                              label: Text('Contact',
                                  style: TextStyle(fontSize: 15, color: blue)),
                            ),
                            DataColumn(
                              label: Text('Pickup Location',
                                  style: TextStyle(fontSize: 15, color: blue)),
                            ),
                            DataColumn(
                              label: Text('Drop Location',
                                  style: TextStyle(fontSize: 15, color: blue)),
                            ),
                            DataColumn(
                              label: Text('Package',
                                  style: TextStyle(fontSize: 15, color: blue)),
                            ),
                            DataColumn(
                              label: Text('Rental Hour',
                                  style: TextStyle(fontSize: 15, color: blue)),
                            ),
                            DataColumn(
                              label: Text('Cab Type',
                                  style: TextStyle(fontSize: 15, color: blue)),
                            ),
                            DataColumn(
                              label: Text('Pickup Date',
                                  style: TextStyle(fontSize: 15, color: blue)),
                            ),
                            DataColumn(
                              label: Text('Drop Date',
                                  style: TextStyle(fontSize: 15, color: blue)),
                            ),
                            DataColumn(
                              label: Text('Status',
                                  style: TextStyle(fontSize: 15, color: blue)),
                            ),
                          ],
                          rows: List.generate(
                              manualBookingHistoryModel!
                                  .body!.bookedRides!.length, (index) {
                            var e = manualBookingHistoryModel!
                                .body!.bookedRides![index];
                            return DataRow(cells: [
                              DataCell(Text('${index + 1}')),
                              DataCell(Text(
                                  '${e.subadmin!.name} , ${e.subadmin!.phonenumber}')),
                              DataCell(Text('${e.name}')),
                              DataCell(Text('${e.phonenumber}')),
                              DataCell(Text('${e.pickupLocation}')),
                              DataCell(Text('${e.dropLocation}')),
                              DataCell(Text('${e.package}')),
                              DataCell(Text('${e.rentalhour}')),
                              DataCell(Text('${e.cab}')),
                              DataCell(Text(DateFormat('dd-MM-yyyy')
                                  .format(e.pickupDate!))),
                              DataCell(Text(DateFormat('dd-MM-yyyy')
                                  .format(e.pickupDate!))),
                              DataCell(Text('${e.tripStatus}')),
                            ]);
                          })),
                    )),
    );
  }
}
