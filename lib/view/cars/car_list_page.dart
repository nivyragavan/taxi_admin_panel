import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:taxi_admin_panel/constant/responsiveness.dart';
import 'package:taxi_admin_panel/constant/style.dart';
import 'package:taxi_admin_panel/controller/car_search_controller.dart';
import 'package:taxi_admin_panel/model/car_approved_list_model.dart';
import 'package:taxi_admin_panel/service/api_service.dart';
import 'package:taxi_admin_panel/widgets/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/sidebar_widget.dart';
import '../authentication.dart';

class CarListPage extends StatefulWidget {
  const CarListPage({Key? key}) : super(key: key);

  static const String id = "car_list_page";

  @override
  State<CarListPage> createState() => _CarListPageState();
}

class _CarListPageState extends State<CarListPage> {
  final fromDate = TextEditingController();
  final toDate = TextEditingController();

  var searchController = Get.put(SearchCarListController());

  CarApprovedList? carApprovedList;
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    carApprovedList = await ApiService().carApprovedList();
    if (carApprovedList != null) {
      setState(() {
        isLoading = true;
      });
      setState(() {
        carApprovedList = carApprovedList;
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
        sideBar: SideBarWidget().sidebarMenus(CarListPage.id),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: Get.width,
            height: Get.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Cars List',
                  size: 20,
                  weight: FontWeight.bold,
                  color: green,
                ),
                const SizedBox(height: 20),
                Expanded(
                    child: ListView(
                  children: [
                    if (!ResponsiveWidget.isSmallScreen(context))
                      buildSearchLarge()
                    else
                      buildSearchSmall(),
                    const SizedBox(height: 20),
                    buildCarsTable()
                  ],
                )),
              ],
            ),
          ),
        ));
  }

  buildSearchLarge() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [buildSearchBar(), buildDownloadButtonLarge()],
    );
  }

  buildSearchSmall() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSearchBar(),
        const SizedBox(height: 15),
        buildDownloadButtonSmall()
      ],
    );
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
          hintText: "Register Number or Model",
        ),
      ),
    );
  }

  buildDownloadButtonLarge() {
    return Row(
      children: [
        SizedBox(
          width: 200,
          height: 40,
          child: TextFormField(
            controller: fromDate,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: green, width: 2)),
                hintText: 'Enter from date'),
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime(2101));
              if (pickedDate != null) {
                print(
                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                String formattedDate =
                    DateFormat('dd-MM-yyyy').format(pickedDate);
                print(
                    formattedDate); //formatted date output using intl package =>  2021-03-16
                //you can implement different kind of Date Format here according to your requirement

                setState(() {
                  fromDate.text =
                      formattedDate; //set output date to TextField value.
                });
              } else {
                print("Date is not selected");
              }
            },
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        SizedBox(
          width: 200,
          height: 40,
          child: TextFormField(
            controller: toDate,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: green, width: 2)),
                hintText: 'Enter to date'),
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime(2101));
              if (pickedDate != null) {
                print(
                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                String formattedDate =
                    DateFormat('dd-MM-yyyy').format(pickedDate);
                print(
                    formattedDate); //formatted date output using intl package =>  2021-03-16
                //you can implement different kind of Date Format here according to your requirement

                setState(() {
                  toDate.text =
                      formattedDate; //set output date to TextField value.
                });
              } else {
                print("Date is not selected");
              }
            },
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: green, fixedSize: const Size(200, 40)),
            onPressed: () {
              ApiService().approvedCarDownload(fromDate.text, toDate.text);
            },
            child: const Text(
              'Download',
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),
      ],
    );
  }

  buildDownloadButtonSmall() {
    return Column(
      children: [
        SizedBox(
          width: 200,
          height: 40,
          child: TextFormField(
            controller: fromDate,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: green, width: 2)),
                hintText: 'Enter from date'),
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime(2101));
              if (pickedDate != null) {
                print(
                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                String formattedDate =
                    DateFormat('dd-MM-yyyy').format(pickedDate);
                print(
                    formattedDate); //formatted date output using intl package =>  2021-03-16
                //you can implement different kind of Date Format here according to your requirement

                setState(() {
                  fromDate.text =
                      formattedDate; //set output date to TextField value.
                });
              } else {
                print("Date is not selected");
              }
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: 200,
          height: 40,
          child: TextFormField(
            controller: toDate,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: green, width: 2)),
                hintText: 'Enter to date'),
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime(2101));
              if (pickedDate != null) {
                print(
                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                String formattedDate =
                    DateFormat('dd-MM-yyyy').format(pickedDate);
                print(
                    formattedDate); //formatted date output using intl package =>  2021-03-16
                //you can implement different kind of Date Format here according to your requirement

                setState(() {
                  toDate.text =
                      formattedDate; //set output date to TextField value.
                });
              } else {
                print("Date is not selected");
              }
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: green, fixedSize: const Size(200, 40)),
            onPressed: () {
              ApiService().approvedCarDownload(fromDate.text, toDate.text);
            },
            child: const Text(
              'Download',
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),
      ],
    );
  }

  buildCarsTable() {
    return GetBuilder<SearchCarListController>(builder: (searchController) {
      print('updateeeeee');
      if (searchController.searchResult.isEmpty) {
        return Center(
          child: CircularProgressIndicator(color: green),
        );
      }
      print('updateeeeee......length');
      print(searchController.searchResult.length);
      print(isLoading);
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
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : searchController.searchResult.isEmpty
                    ? Center(
                        child: Image.asset('assets/images/nodatafound.png'))
                    : Card(
                        child: DataTable2(
                            columnSpacing: 5,
                            horizontalMargin: 12,
                            minWidth: 1000,
                            columns: [
                              DataColumn(
                                label: Text('S:No',
                                    style:
                                        TextStyle(fontSize: 15, color: green)),
                              ),
                              DataColumn(
                                label: Text('Car Register Number',
                                    style:
                                        TextStyle(fontSize: 15, color: green)),
                              ),
                              DataColumn(
                                label: Text('Car Model',
                                    style:
                                        TextStyle(fontSize: 15, color: green)),
                              ),
                              DataColumn(
                                label: Text('Vendor Name',
                                    style:
                                        TextStyle(fontSize: 15, color: green)),
                              ),
                              DataColumn(
                                label: Text('Vendor Contact',
                                    style:
                                        TextStyle(fontSize: 15, color: green)),
                              ),
                              DataColumn(
                                  label: Text('Front Image',
                                      style: TextStyle(
                                          fontSize: 15, color: green))),
                              DataColumn(
                                  label: Text('Chassis Image',
                                      style: TextStyle(
                                          fontSize: 15, color: green))),
                              DataColumn(
                                  label: Text('RC Front',
                                      style: TextStyle(
                                          fontSize: 15, color: green))),
                              DataColumn(
                                  label: Text('RC Back',
                                      style: TextStyle(
                                          fontSize: 15, color: green))),
                              DataColumn(
                                  label: Text('Insurance',
                                      style: TextStyle(
                                          fontSize: 15, color: green))),
                              DataColumn(
                                  label: Text('FC Copy',
                                      style: TextStyle(
                                          fontSize: 15, color: green)))
                            ],
                            rows: List.generate(
                                searchController.searchResult.length, (index) {
                              var e = searchController.searchResult[index];
                              return DataRow(cells: [
                                DataCell(Text('${index + 1}')),
                                DataCell(Text('${e.carNumber}')),
                                DataCell(Text('${e.model}')),
                                DataCell(Text('${e.vendor!.name}')),
                                DataCell(Text('${e.vendor!.contact}')),
                                DataCell(OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        side: BorderSide(color: green)),
                                    onPressed: () async{
                                      var frontImageUrl = e.carFrontPic ?? '';
                                      await launchUrl(Uri.parse(frontImageUrl));
                                    },
                                    child: Icon(Icons.download_rounded,
                                        color: green))),
                                DataCell(OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        side: BorderSide(color: green)),
                                    onPressed: () async{
                                      var chassisImageUrl = e.chassisPic ?? '';
                                      await launchUrl(Uri.parse(chassisImageUrl));
                                    },
                                    child: Icon(Icons.download_rounded,
                                        color: green))),
                                DataCell(OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        side: BorderSide(color: green)),
                                    onPressed: () async{
                                      var rcFrontUrl = e.rcFront ?? '';
                                      await launchUrl(Uri.parse(rcFrontUrl));
                                    },
                                    child: Icon(Icons.download_rounded,
                                        color: green))),
                                DataCell(OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        side: BorderSide(color: green)),
                                    onPressed: () async{
                                      var rcBackUrl = e.rcBack ?? '';
                                      await launchUrl(Uri.parse(rcBackUrl));
                                    },
                                    child: Icon(Icons.download_rounded,
                                        color: green))),
                                DataCell(OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        side: BorderSide(color: green)),
                                    onPressed: () async{
                                      var insuranceUrl = e.insurence ?? '';
                                      await launchUrl(Uri.parse(insuranceUrl));
                                    },
                                    child: Icon(Icons.download_rounded,
                                        color: green))),
                                DataCell(OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        side: BorderSide(color: green)),
                                    onPressed: () async{
                                      var fcUrl = e.fcCopy ?? '';
                                      await launchUrl(Uri.parse(fcUrl));
                                    },
                                    child: Icon(Icons.download_rounded,
                                        color: green))),
                              ]);
                            })),
                      )),
      );
    });
  }
}
