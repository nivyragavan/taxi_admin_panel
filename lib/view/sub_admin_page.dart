import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:taxi_admin_panel/constant/responsiveness.dart';
import 'package:taxi_admin_panel/constant/style.dart';
import 'package:taxi_admin_panel/model/sub_admin_list_model.dart';
import 'package:taxi_admin_panel/service/api_service.dart';
import 'package:taxi_admin_panel/widgets/custom_text.dart';

import '../widgets/sidebar_widget.dart';
import 'authentication.dart';

class SubAdminPage extends StatefulWidget {
  const SubAdminPage({Key? key}) : super(key: key);

  static const String id = "subadmin_page";

  @override
  State<SubAdminPage> createState() => _SubAdminPageState();
}

class _SubAdminPageState extends State<SubAdminPage> {
  SubAdminListModel? subAdminListModel;

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  final name = TextEditingController();
  final contact = TextEditingController();
  final designation = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    subAdminListModel = await ApiService().subAdminList();
    if (subAdminListModel != null) {
      setState(() {
        isLoading = true;
      });
      setState(() {
        subAdminListModel = subAdminListModel;
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
        sideBar: SideBarWidget().sidebarMenus(SubAdminPage.id),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: Get.width,
            height: Get.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Sub Admin',
                  size: 20,
                  weight: FontWeight.bold,
                  color: blue,
                ),
                const SizedBox(height: 20),
                Expanded(
                    child: ListView(
                  children: [
                    if (ResponsiveWidget.isLargeScreen(context))
                      buildAddSubAdminLarge(context)
                    else
                      buildAddSubAdminSmall(context),
                    const SizedBox(height: 50),
                    const Divider(thickness: 2),
                    const SizedBox(height: 50),
                    Text(
                      'Sub-Admin List',
                      style: TextStyle(
                          fontSize: 20,
                          color: blue,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    buildSubAdminTable()
                  ],
                ))
              ],
            ),
          ),
        ));
  }

  buildAddSubAdminLarge(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add Sub-Admin',
            style: TextStyle(
                fontSize: 20, color: blue, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: name,
                  cursorColor: blue,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      hintText: "Enter Name",
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: blue))),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: contact,
                  cursorColor: blue,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      hintText: "Enter Phone Number",
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: blue))),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: designation,
                  cursorColor: blue,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      hintText: "Enter Designation",
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: blue))),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: email,
                  cursorColor: blue,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      hintText: "Enter Email Address",
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: blue))),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: password,
                  cursorColor: blue,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      hintText: "Enter Password",
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: blue))),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: blue),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          var data = await ApiService().subAdminAdd(
                              name.text,
                              contact.text,
                              email.text,
                              password.text,
                              designation.text);
                          if (data["statusCode"] == 1) {
                            Fluttertoast.showToast(
                                msg: 'SubAdmin Added Successfully');
                          } else {
                            Fluttertoast.showToast(msg: '${data["message"]}');
                          }
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.30,
                        height: 45,
                        padding: const EdgeInsets.all(10),
                        child: const Center(
                          child: Text(
                            'Submit',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      )))
            ],
          )
        ],
      ),
    );
  }

  buildAddSubAdminSmall(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add Sub-Admin',
          style: TextStyle(
              fontSize: 20, color: blue, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: name,
                cursorColor: blue,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    hintText: "Enter Name",
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: blue))),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                controller: contact,
                cursorColor: blue,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    hintText: "Enter Phone Number",
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: blue))),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: designation,
                cursorColor: blue,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    hintText: "Enter Designation",
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: blue))),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                controller: email,
                cursorColor: blue,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    hintText: "Enter Email Address",
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: blue))),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: password,
                cursorColor: blue,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    hintText: "Enter Password",
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: blue))),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: green),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        if (isLoading) return;
                        setState(() {
                          isLoading = true;
                        });
                        await Future.delayed(const Duration(seconds: 5));
                        setState(() {
                          isLoading = false;
                        });
                        var data = await ApiService().subAdminAdd(
                            name.text,
                            contact.text,
                            email.text,
                            password.text,
                            designation.text);
                        if (data["statusCode"] == 1) {
                          Fluttertoast.showToast(
                              msg: 'SubAdmin Added Successfully');
                        } else {
                          Fluttertoast.showToast(msg: '${data["message"]}');
                        }
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.30,
                      height: 45,
                      padding: const EdgeInsets.all(10),
                      child: isLoading
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 24,
                                ),
                                Text(
                                  'Please Wait',
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white),
                                )
                              ],
                            )
                          : const Center(
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                    )))
          ],
        )
      ],
    );
  }

  buildSubAdminTable() {
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
            : subAdminListModel!.body!.subadminList!.isEmpty
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
                            label: Text('Name',
                                style: TextStyle(fontSize: 15, color: blue)),
                          ),
                          DataColumn(
                            label: Text('Contact',
                                style: TextStyle(fontSize: 15, color: blue)),
                          ),
                          DataColumn(
                              label: Text('Designation',
                                  style:
                                      TextStyle(fontSize: 15, color: blue))),
                          DataColumn(
                              label: Text('Email Address',
                                  style:
                                      TextStyle(fontSize: 15, color: blue))),
                          // DataColumn(
                          //     label: Text('Password',
                          //         style:
                          //             TextStyle(fontSize: 15, color: green)))
                        ],
                        rows: List.generate(
                            subAdminListModel!.body!.subadminList!.length,
                            (index) {
                          var e = subAdminListModel!.body!.subadminList![index];
                          return DataRow(cells: [
                            DataCell(Text('${index + 1}')),
                            DataCell(Text('${e.name}')),
                            DataCell(Text('${e.contact}')),
                            DataCell(Text('${e.designation}')),
                            DataCell(Text('${e.email}')),
                            // DataCell(Text('${e.password}')),
                          ]);
                        })),
                  ));
  }
}
