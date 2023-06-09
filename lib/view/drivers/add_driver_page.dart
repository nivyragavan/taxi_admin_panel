import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:taxi_admin_panel/constant/responsiveness.dart';
import 'package:taxi_admin_panel/constant/style.dart';
import 'package:taxi_admin_panel/model/driver_image_viewed_status_list_model.dart';
import 'package:taxi_admin_panel/model/driver_list_model.dart';
import 'package:taxi_admin_panel/service/api_service.dart';
import 'package:taxi_admin_panel/widgets/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/sidebar_widget.dart';
import '../authentication.dart';
import '../dashboard_page.dart';

class AddDriverPage extends StatefulWidget {
  const AddDriverPage({Key? key}) : super(key: key);

  static const String id = "add_driver_page";

  @override
  State<AddDriverPage> createState() => _AddDriverPageState();
}

class _AddDriverPageState extends State<AddDriverPage> {
  DriverListModel? driverListModel;
  var isLoading = false;

  List<DriverImageViewedStatusListModel>? driverImageViewedStatusList;
  final formKey = GlobalKey<FormState>();

  final reason = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    driverListModel = await ApiService().driverList();
    if (driverListModel != null) {
      driverImageViewedStatusList = List.filled(
          driverListModel!.body!.driverList!.length,
          DriverImageViewedStatusListModel(
              profilePic: false,
              aadharFront: false,
              aadharBack: false,
              licenseFront: false,
              licenseBack: false));
      setState(() {
        isLoading = true;
      });
    }
    setState(() {
      driverListModel = driverListModel;
    });
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
        sideBar: SideBarWidget().sidebarMenus(DashboardPage.id),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: Get.width,
            height: Get.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Add Driver',
                  size: 20,
                  weight: FontWeight.bold,
                  color: blue,
                ),
                const SizedBox(height: 20),
                Expanded(
                    child: ListView(
                  children: [
                    if (!ResponsiveWidget.isSmallScreen(context))
                      buildAddDriverLarge()
                    else
                      buildAddDriverSmall(),
                  ],
                )),
              ],
            ),
          ),
        ));
  }

  buildAddDriverLarge() {
    return Form(
      key: formKey,
      child: isLoading == false
          ? Center(
              child: CircularProgressIndicator(
                color: blue,
              ),
            )
          : driverListModel!.body!.driverList!.isEmpty
              ? Center(child: Image.asset('assets/images/nodatafound.png'))
              : ListView.separated(
                  padding: const EdgeInsets.all(10),
                  itemCount: driverListModel!.body!.driverList!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var driversList = driverListModel!.body!.driverList![index];
                    var documentStatus =
                        driverListModel!.body!.driverList!.length ==
                                driverImageViewedStatusList!.length
                            ? true
                            : false;
                    DriverImageViewedStatusListModel driversDocuments;
                    if (documentStatus == true) {
                      driversDocuments = driverImageViewedStatusList![index];
                    }
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    const CustomText(
                                      text: 'Name :',
                                      weight: FontWeight.bold,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    CustomText(
                                      text: '${driversList.name}',
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    const CustomText(
                                      text: 'Phone Number :',
                                      weight: FontWeight.bold,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    CustomText(
                                      text: '${driversList.contact}',
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    const CustomText(
                                      text: 'District :',
                                      weight: FontWeight.bold,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    CustomText(
                                      text: '${driversList.district}',
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    const CustomText(
                                      text: 'License Number :',
                                      weight: FontWeight.bold,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    CustomText(
                                      text: '${driversList.licenseNumber}',
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    const CustomText(
                                      text: 'Expiry Date :',
                                      weight: FontWeight.bold,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    CustomText(
                                      text: (DateFormat('dd-MM-yyyy')
                                          .format(driversList.expieryDate!)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    const CustomText(
                                      text: 'Profile Photo :',
                                      weight: FontWeight.bold,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          side: BorderSide(color: blue)),
                                      onPressed: () async{
                                        var profileUrl = driversList.profilePic ?? '';
                                        await launchUrl(Uri.parse(profileUrl));
                                      },
                                      child: const CustomText(text: 'View'),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    const CustomText(
                                      text: 'Aadhaar Front :',
                                      weight: FontWeight.bold,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          side: BorderSide(color: blue)),
                                      onPressed: () async{
                                        var aadhaarFrontUrl = driversList.adharFront ?? '';
                                        await launchUrl(Uri.parse(aadhaarFrontUrl));
                                      },
                                      child: const CustomText(text: 'View'),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    const CustomText(
                                      text: 'Aadhaar Back :',
                                      weight: FontWeight.bold,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          side: BorderSide(color: blue)),
                                      onPressed: () async{
                                        var aadhaarBackUrl = driversList.adharBack ?? '';
                                        await launchUrl(Uri.parse(aadhaarBackUrl));
                                      },
                                      child: const CustomText(text: 'View'),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    const CustomText(
                                      text: 'License Front :',
                                      weight: FontWeight.bold,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          side: BorderSide(color: blue)),
                                      onPressed: () async{
                                        var licenseFrontUrl = driversList.licenseFront ?? '';
                                        await launchUrl(Uri.parse(licenseFrontUrl));
                                      },
                                      child: const CustomText(text: 'View'),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    const CustomText(
                                      text: 'License Back :',
                                      weight: FontWeight.bold,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          side: BorderSide(color: blue)),
                                      onPressed: () async{
                                        var licenseBackUrl = driversList.licenseBack ?? '';
                                        await launchUrl(Uri.parse(licenseBackUrl));
                                      },
                                      child: const CustomText(text: 'View'),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    fixedSize: const Size(250, 40)),
                                onPressed: () async {
                                  var data = await ApiService()
                                      .driverApproval(driversList.id);
                                  print(data);
                                  if (data['statusCode'] == 1) {
                                    Fluttertoast.showToast(
                                        msg: 'Driver Accepted', fontSize: 18);
                                    print('====success====');
                                  } else {
                                    print('====failed====');
                                  }
                                },
                                child: const CustomText(
                                  text: 'Accept',
                                  color: Colors.white,
                                )),
                            SizedBox(
                              width: 250,
                              height: 40,
                              child: TextFormField(
                                  controller: reason,
                                  decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: green)),
                                      hintText: 'Reason of Rejection'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter reason';
                                    }
                                  }),
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    fixedSize: const Size(250, 40)),
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    var data = await ApiService().driverReject(
                                        driversList.id, reason.text);
                                    print(data);
                                    if (data['statusCode'] == 1) {
                                      Fluttertoast.showToast(
                                          msg: 'Driver Rejected', fontSize: 18);
                                      print('====success====');
                                    } else {
                                      print('====failed====');
                                    }
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: 'Please give reason of rejection',
                                        fontSize: 18);
                                  }
                                },
                                child: const CustomText(
                                  text: 'Reject',
                                  color: Colors.white,
                                ))
                          ],
                        ),
                        const SizedBox(height: 10)
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(thickness: 2);
                  },
                ),
    );
  }

  buildAddDriverSmall() {
    return ListView.separated(
        padding: const EdgeInsets.all(10),
        itemCount: driverListModel!.body!.driverList!.length,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemBuilder: (context, index) {
          var driversList = driverListModel!.body!.driverList![index];
          var documentStatus = driverListModel!.body!.driverList!.length ==
                  driverImageViewedStatusList!.length
              ? true
              : false;
          DriverImageViewedStatusListModel driversDocuments;
          if (documentStatus == true) {
            driversDocuments = driverImageViewedStatusList![index];
          }
          return Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const CustomText(
                        text: 'Name :',
                        weight: FontWeight.bold,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CustomText(
                        text: '${driversList.name}',
                      )
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const CustomText(
                        text: 'Phone Number :',
                        weight: FontWeight.bold,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CustomText(
                        text: '${driversList.contact}',
                      )
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const CustomText(
                        text: 'District :',
                        weight: FontWeight.bold,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CustomText(
                        text: '${driversList.district}',
                      )
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const CustomText(
                        text: 'License Number :',
                        weight: FontWeight.bold,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CustomText(
                        text: '${driversList.licenseNumber}',
                      )
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const CustomText(
                        text: 'Expiry Date :',
                        weight: FontWeight.bold,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CustomText(
                        text: '${driversList.expieryDate!.weekday}',
                      )
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const CustomText(
                        text: 'Profile Photo :',
                        weight: FontWeight.bold,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(color: green)),
                        onPressed: () {},
                        child: const CustomText(text: 'View'),
                      )
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const CustomText(
                        text: 'Aadhaar Front :',
                        weight: FontWeight.bold,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(color: blue)),
                        onPressed: () {},
                        child: const CustomText(text: 'View'),
                      )
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const CustomText(
                        text: 'Aadhaar Back :',
                        weight: FontWeight.bold,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(color: blue)),
                        onPressed: () {},
                        child: const CustomText(text: 'View'),
                      )
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const CustomText(
                        text: 'License Front :',
                        weight: FontWeight.bold,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(color: blue)),
                        onPressed: () {},
                        child: const CustomText(text: 'View'),
                      )
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const CustomText(
                        text: 'License Back :',
                        weight: FontWeight.bold,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(color: blue)),
                        onPressed: () {},
                        child: const CustomText(text: 'View'),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      fixedSize: const Size(250, 40)),
                  onPressed: () async {
                    var data =
                        await ApiService().driverApproval(driversList.id);
                    print(data);
                    if (data['statusCode'] == 1) {
                      Fluttertoast.showToast(
                          msg: 'Driver Accepted', fontSize: 18);
                      print('====success====');
                    } else {
                      print('====failed====');
                    }
                  },
                  child: const CustomText(
                    text: 'Accept',
                    color: Colors.white,
                  )),
              const SizedBox(height: 10),
              TextFormField(
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: green)),
                      hintText: 'Reason of Rejection'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter reason';
                    }
                  }),
              const SizedBox(height: 10),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      fixedSize: const Size(250, 40)),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      var data = await ApiService()
                          .driverReject(driversList.id, reason.text);
                      print(data);
                      if (data['statusCode'] == 1) {
                        Fluttertoast.showToast(
                            msg: 'Driver Rejected', fontSize: 18);
                        print('====success====');
                      } else {
                        print('====failed====');
                      }
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Please give reason of rejection', fontSize: 18);
                    }
                  },
                  child: const CustomText(
                    text: 'Reject',
                    color: Colors.white,
                  )),
              const SizedBox(height: 10),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(thickness: 2);
        });
  }
}
