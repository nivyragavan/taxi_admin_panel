import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:taxi_admin_panel/constant/responsiveness.dart';
import 'package:taxi_admin_panel/model/vendor_image_viewed_status_list_model.dart';
import 'package:taxi_admin_panel/model/vendor_list_model.dart';
import 'package:taxi_admin_panel/service/api_service.dart';
import 'package:taxi_admin_panel/widgets/custom_text.dart';

import '../../constant/style.dart';
import '../../widgets/sidebar_widget.dart';
import '../authentication.dart';

class AddVendorPage extends StatefulWidget {
  const AddVendorPage({Key? key}) : super(key: key);

  static const String id = "add_vendor_page";

  @override
  State<AddVendorPage> createState() => _AddVendorPageState();
}

class _AddVendorPageState extends State<AddVendorPage> {
  VendorListModel? vendorListModel;
  var isLoading = false;

  List<VendorImageViewedStatusListModel>? vendorImageViewedStatusList;
  final formKey = GlobalKey<FormState>();

  final reason = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    vendorListModel = await ApiService().vendorList();
    if (vendorListModel != null) {
      vendorImageViewedStatusList = List.filled(
          vendorListModel!.body!.vendorList!.length,
          VendorImageViewedStatusListModel(
              ownerAadharFront: false,
              ownerAadharBack: false,
              panCard: false,
              passbook: false,
              rentalAgreement1: false,
              rentalAgreement2: false));
      setState(() {
        isLoading = true;
      });
    }
    setState(() {
      vendorListModel = vendorListModel;
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
        sideBar: SideBarWidget().sidebarMenus(AddVendorPage.id),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: Get.width,
            height: Get.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Add Vendor',
                  size: 20,
                  weight: FontWeight.bold,
                  color: green,
                ),
                const SizedBox(height: 20),
                Expanded(
                    child: ListView(
                  children: [
                    if (!ResponsiveWidget.isSmallScreen(context))
                      buildAddVendorLarge()
                    else
                      buildAddVendorSmall(),
                  ],
                )),
              ],
            ),
          ),
        ));
  }

  buildAddVendorLarge() {
    return Form(
      key: formKey,
      child: isLoading == false
          ? Center(
              child: CircularProgressIndicator(
                color: green,
              ),
            )
          : vendorListModel!.body!.vendorList!.isEmpty
              ? Center(child: Image.asset('assets/images/nodatafound.png'))
              : ListView.separated(
                  padding: const EdgeInsets.all(10),
                  itemCount: vendorListModel!.body!.vendorList!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var vendorsList = vendorListModel!.body!.vendorList![index];
                    var documentStatus =
                        vendorListModel!.body!.vendorList!.length ==
                                vendorImageViewedStatusList!.length
                            ? true
                            : false;
                    VendorImageViewedStatusListModel vendorsDocuments;
                    if (documentStatus == true) {
                      vendorsDocuments = vendorImageViewedStatusList![index];
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
                                      text: '${vendorsList.name}',
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
                                      text: '${vendorsList.contact}',
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
                                      text: 'Aadhaar Back :',
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
                                      text: 'Pan Card :',
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
                                      text: 'Passbook :',
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
                                      text: 'Rental agreement 1st page :',
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
                                      text: 'Rental agreement 2nd page :',
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
                                      .vendorApproval(vendorsList.id);
                                  print(data);
                                  if (data['statusCode'] == 1) {
                                    Fluttertoast.showToast(
                                        msg: 'Vendor Accepted', fontSize: 18);
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
                                    var data = await ApiService().vendorReject(
                                        vendorsList.id, reason.text);
                                    print(data);
                                    if (data['statusCode'] == 1) {
                                      Fluttertoast.showToast(
                                          msg: 'Vendor Rejected', fontSize: 18);
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

  buildAddVendorSmall() {
    return Form(
      key: formKey,
      child: isLoading == false
          ? Center(
              child: CircularProgressIndicator(
                color: green,
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: vendorListModel!.body!.vendorList!.length,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemBuilder: (context, index) {
                var vendorsList = vendorListModel!.body!.vendorList![index];
                var documentStatus =
                    vendorListModel!.body!.vendorList!.length ==
                            vendorImageViewedStatusList!.length
                        ? true
                        : false;
                VendorImageViewedStatusListModel vendorsDocuments;
                if (documentStatus == true) {
                  vendorsDocuments = vendorImageViewedStatusList![index];
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
                              text: '${vendorsList.name}',
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
                              text: '${vendorsList.contact}',
                            )
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(
                              text: 'Aadhaar Front :',
                              weight: FontWeight.bold,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(
                              text: 'Aadhaar Back :',
                              weight: FontWeight.bold,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(
                              text: 'Pan Card :',
                              weight: FontWeight.bold,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(
                              text: 'Passbook :',
                              weight: FontWeight.bold,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(
                              text: 'Rental agreement 1st page :',
                              weight: FontWeight.bold,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(
                              text: 'Rental agreement 2nd page :',
                              weight: FontWeight.bold,
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
                    const SizedBox(height: 10),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            fixedSize: const Size(250, 40)),
                        onPressed: () async {
                          var data =
                              await ApiService().vendorApproval(vendorsList.id);
                          print(data);
                          if (data['statusCode'] == 1) {
                            Fluttertoast.showToast(
                                msg: 'Vendor Accepted', fontSize: 18);
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
                                .vendorReject(vendorsList.id, reason.text);
                            print(data);
                            if (data['statusCode'] == 1) {
                              Fluttertoast.showToast(
                                  msg: 'Vendor Rejected', fontSize: 18);
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
                        )),
                    const SizedBox(height: 10),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(thickness: 2);
              }),
    );
  }
}
