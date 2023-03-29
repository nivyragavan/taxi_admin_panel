import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:taxi_admin_panel/constant/responsiveness.dart';
import 'package:taxi_admin_panel/constant/style.dart';
import 'package:taxi_admin_panel/model/package_list_model.dart';
import 'package:taxi_admin_panel/service/api_service.dart';
import 'package:taxi_admin_panel/widgets/custom_text.dart';

import '../model/cab_list_model.dart';
import '../widgets/sidebar_widget.dart';
import 'authentication.dart';

class PackageAndCabPage extends StatefulWidget {
  const PackageAndCabPage({Key? key}) : super(key: key);

  static const String id = "package_cab_page";

  @override
  State<PackageAndCabPage> createState() => _PackageAndCabPageState();
}

class _PackageAndCabPageState extends State<PackageAndCabPage> {
  final package = TextEditingController();

  final cab = TextEditingController();

  PackageListModel? packageListModel;

  CabListModel? cabListModel;

  bool isPackageLoading = true;

  bool isCabLoading = true;

  @override
  void initState() {
    super.initState();
    getPackageData();
    getCabData();
  }

  void getPackageData() async {
    packageListModel = await ApiService().packageList();
    if (packageListModel != null) {
      setState(() {
        isPackageLoading = true;
      });
      setState(() {
        packageListModel = packageListModel;
      });
    }
  }

  void getCabData() async {
    cabListModel = await ApiService().cabList();
    if (cabListModel != null) {
      setState(() {
        isCabLoading = true;
      });
      setState(() {
        cabListModel = cabListModel;
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
        sideBar: SideBarWidget().sidebarMenus(PackageAndCabPage.id),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: Get.width,
            height: Get.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Package and Cab',
                  size: 20,
                  weight: FontWeight.bold,
                  color: green,
                ),
                const SizedBox(height: 20),
                Expanded(
                    child: ListView(
                  children: [
                    if (!ResponsiveWidget.isSmallScreen(context))
                      buildPackageCabLarge()
                    else
                      buildPackageCabSmall()
                  ],
                ))
              ],
            ),
          ),
        ));
  }

  buildPackageCabLarge() {
    return Row(
      children: [
        buildPackageLarge(),
        Container(width: 2, height: 200, color: lightGrey),
        buildCabLarge(),
      ],
    );
  }

  buildPackageCabSmall() {
    return Column(
      children: [
        buildPackageSmall(),
        const SizedBox(height: 10),
        const Divider(thickness: 2),
        const SizedBox(height: 10),
        buildCabSmall(),
      ],
    );
  }

  buildPackageLarge() {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                child: TextField(
                    controller: package,
                    cursorColor: green,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: green)),
                        hintText: 'Enter Package')),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: green, fixedSize: const Size(70, 30)),
                  onPressed: () async {
                    var data = await ApiService().packageAdd(package.text);
                    if (data["statusCode"] == 1) {
                      Fluttertoast.showToast(msg: 'Package added');
                      ApiService().packageList();
                    } else {
                      Fluttertoast.showToast(msg: data["message"]);
                    }
                  },
                  child: const Text(
                    'Add',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: 300,
            height: 200,
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
            child: isPackageLoading == false
                ? Center(
                    child: CircularProgressIndicator(
                      color: green,
                    ),
                  )
                : packageListModel!.body!.packageList!.isEmpty
                    ? Center(
                        child: Image.asset('assets/images/nodatafound.png'))
                    : DataTable2(
                        columnSpacing: 12,
                        horizontalMargin: 12,
                        minWidth: 200,
                        columns: const [
                          DataColumn(label: Text("S:No")),
                          DataColumn(
                            label: Text("Package"),
                          )
                        ],
                        rows: List<DataRow>.generate(
                            packageListModel!.body!.packageList!.length,
                            (index) => DataRow(cells: [
                                  DataCell(CustomText(
                                    text: ('${index + 1}'),
                                    size: 12,
                                    weight: FontWeight.normal,
                                    color: Colors.black,
                                  )),
                                  DataCell(CustomText(
                                    text:
                                        ('${packageListModel!.body!.packageList![index].packageName}'),
                                    weight: FontWeight.normal,
                                    size: 12,
                                    color: Colors.black,
                                  ))
                                ])).toList()),
          )
        ],
      ),
    );
  }

  buildPackageSmall() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child: TextField(
                  cursorColor: green,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: green)),
                      hintText: 'Enter Package')),
            ),
            const SizedBox(width: 20),
            CircleAvatar(
              radius: 20,
              backgroundColor: green,
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add,
                    color: black,
                  )),
            )
          ],
        ),
        const SizedBox(height: 20),
        Container(
          width: 300,
          height: 200,
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
          child: DataTable2(
              columnSpacing: 12,
              horizontalMargin: 12,
              minWidth: 200,
              columns: const [
                DataColumn(label: Text("S:No")),
                DataColumn(
                  label: Text("Package"),
                )
              ],
              rows: List<DataRow>.generate(
                  4,
                  (index) => const DataRow(cells: [
                        DataCell(CustomText(
                          text: ('1'),
                          size: 12,
                          weight: FontWeight.normal,
                          color: Colors.black,
                        )),
                        DataCell(CustomText(
                          text: ('Outstation'),
                          weight: FontWeight.normal,
                          size: 12,
                          color: Colors.black,
                        ))
                      ])).toList()),
        )
      ],
    );
  }

  buildCabLarge() {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                child: TextField(
                    controller: cab,
                    cursorColor: green,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: green)),
                        hintText: 'Enter Cab')),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: green, fixedSize: const Size(70, 30)),
                  onPressed: () async {
                    var data = await ApiService().cabAdd(cab.text);
                    if (data["statusCode"] == 1) {
                      Fluttertoast.showToast(msg: 'Cab added');
                      ApiService().packageList();
                    } else {
                      Fluttertoast.showToast(msg: data["message"]);
                    }
                  },
                  child: const Text(
                    'Add',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: 300,
            height: 200,
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
            child: isCabLoading == false
                ? Center(
                    child: CircularProgressIndicator(
                      color: green,
                    ),
                  )
                : cabListModel!.body!.cabsList!.isEmpty
                    ? Center(
                        child: Image.asset('assets/images/nodatafound.png'))
                    : DataTable2(
                        columnSpacing: 12,
                        horizontalMargin: 12,
                        minWidth: 200,
                        columns: const [
                          DataColumn(label: Text("S:No")),
                          DataColumn(
                            label: Text("Cab"),
                          )
                        ],
                        rows: List<DataRow>.generate(
                            cabListModel!.body!.cabsList!.length,
                            (index) => DataRow(cells: [
                                  DataCell(CustomText(
                                    text: ('${index + 1}'),
                                    size: 12,
                                    weight: FontWeight.normal,
                                    color: Colors.black,
                                  )),
                                  DataCell(CustomText(
                                    text:
                                        ('${cabListModel!.body!.cabsList![index].cabNames}'),
                                    weight: FontWeight.normal,
                                    size: 12,
                                    color: Colors.black,
                                  ))
                                ])).toList()),
          )
        ],
      ),
    );
  }

  buildCabSmall() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child: TextField(
                  cursorColor: green,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: green)),
                      hintText: 'Enter Cab')),
            ),
            const SizedBox(width: 20),
            CircleAvatar(
              radius: 20,
              backgroundColor: green,
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add,
                    color: black,
                  )),
            )
          ],
        ),
        const SizedBox(height: 20),
        Container(
          width: 300,
          height: 200,
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
          child: DataTable2(
              columnSpacing: 12,
              horizontalMargin: 12,
              minWidth: 200,
              columns: const [
                DataColumn(label: Text("S:No")),
                DataColumn(
                  label: Text("Cab Type"),
                )
              ],
              rows: List<DataRow>.generate(
                  4,
                  (index) => const DataRow(cells: [
                        DataCell(CustomText(
                          text: ('1'),
                          size: 12,
                          weight: FontWeight.normal,
                          color: Colors.black,
                        )),
                        DataCell(CustomText(
                          text: ('Sedan'),
                          weight: FontWeight.normal,
                          size: 12,
                          color: Colors.black,
                        ))
                      ])).toList()),
        )
      ],
    );
  }

  buildRentalHoursLarge() {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                child: TextField(
                    cursorColor: green,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: green)),
                        hintText: 'Enter Rental Hours')),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: green, fixedSize: const Size(70, 30)),
                  onPressed: () {},
                  child: const Text(
                    'Add',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: 300,
            height: 200,
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
            child: DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                minWidth: 200,
                columns: const [
                  DataColumn(label: Text("S:No")),
                  DataColumn(
                    label: Text("Rental Hours"),
                  )
                ],
                rows: List<DataRow>.generate(
                    4,
                    (index) => const DataRow(cells: [
                          DataCell(CustomText(
                            text: ('1'),
                            size: 12,
                            weight: FontWeight.normal,
                            color: Colors.black,
                          )),
                          DataCell(CustomText(
                            text: ('1 Hour'),
                            weight: FontWeight.normal,
                            size: 12,
                            color: Colors.black,
                          ))
                        ])).toList()),
          )
        ],
      ),
    );
  }

  buildRentalHoursSmall() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child: TextField(
                  cursorColor: green,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: green)),
                      hintText: 'Enter Rental Hours')),
            ),
            const SizedBox(width: 20),
            CircleAvatar(
              radius: 20,
              backgroundColor: green,
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add,
                    color: black,
                  )),
            )
          ],
        ),
        const SizedBox(height: 20),
        Container(
          width: 300,
          height: 200,
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
          child: DataTable2(
              columnSpacing: 12,
              horizontalMargin: 12,
              minWidth: 200,
              columns: const [
                DataColumn(label: Text("S:No")),
                DataColumn(
                  label: Text("Rental Hours"),
                )
              ],
              rows: List<DataRow>.generate(
                  4,
                  (index) => const DataRow(cells: [
                        DataCell(CustomText(
                          text: ('1'),
                          size: 12,
                          weight: FontWeight.normal,
                          color: Colors.black,
                        )),
                        DataCell(CustomText(
                          text: ('1 Hour'),
                          weight: FontWeight.normal,
                          size: 12,
                          color: Colors.black,
                        ))
                      ])).toList()),
        )
      ],
    );
  }
}
