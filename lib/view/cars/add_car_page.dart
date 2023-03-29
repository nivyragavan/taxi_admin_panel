import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:taxi_admin_panel/constant/responsiveness.dart';
import 'package:taxi_admin_panel/constant/style.dart';
import 'package:taxi_admin_panel/model/car_image_viewed_status_list_model.dart';
import 'package:taxi_admin_panel/model/car_list_model.dart';
import 'package:taxi_admin_panel/service/api_service.dart';
import 'package:taxi_admin_panel/widgets/custom_text.dart';
import '../../widgets/sidebar_widget.dart';
import '../authentication.dart';

class AddCarPage extends StatefulWidget {
  const AddCarPage({Key? key}) : super(key: key);

  static const String id = "add_car_page";

  @override
  State<AddCarPage> createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  CarListModel? carListModel;
  var isLoading = false;

  List<CarImageViewedStatusListModel>? carImageViewedStatusList;
  final formKey = GlobalKey<FormState>();

  final reason = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    carListModel = await ApiService().carList();
    if (carListModel != null) {
      carImageViewedStatusList = List.filled(
          carListModel!.body!.carList!.length,
          CarImageViewedStatusListModel(
              frontImage: false,
              chaseImage: false,
              rcFront: false,
              rcBack: false,
              insurance: false,
              fc: false));
      setState(() {
        isLoading = true;
      });
    }
    setState(() {
      carListModel = carListModel;
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
        sideBar: SideBarWidget().sidebarMenus(AddCarPage.id),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: Get.width,
            height: Get.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Add Car',
                  size: 20,
                  weight: FontWeight.bold,
                  color: green,
                ),
                const SizedBox(height: 20),
                Expanded(
                    child: ListView(
                  children: [
                    if (!ResponsiveWidget.isSmallScreen(context))
                      buildAddCarLarge()
                    else
                      buildAddCarSmall(),
                  ],
                )),
              ],
            ),
          ),
        ));
  }

  buildAddCarLarge() {
    return Form(
      key: formKey,
      child: isLoading == false
          ? Center(
              child: CircularProgressIndicator(
                color: green,
              ),
            )
          : carListModel!.body!.carList!.isEmpty
              ? Center(child: Image.asset('assets/images/nodatafound.png'))
              : ListView.separated(
                  padding: const EdgeInsets.all(10),
                  itemCount: carListModel!.body!.carList!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var carsList = carListModel!.body!.carList![index];
                    var documentStatus = carListModel!.body!.carList!.length ==
                            carImageViewedStatusList!.length
                        ? true
                        : false;
                    CarImageViewedStatusListModel carsDocuments;
                    if (documentStatus == true) {
                      carsDocuments = carImageViewedStatusList![index];
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
                                      text: 'Register NUmber :',
                                      weight: FontWeight.bold,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    CustomText(
                                      text: '${carsList.carNumber}',
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
                                      text: 'Model :',
                                      weight: FontWeight.bold,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    CustomText(
                                      text: '${carsList.model}',
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
                                      text: 'Car Front Image :',
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
                                      text: 'Car Chassis Image :',
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
                                      text: 'RC Front :',
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
                                      text: 'RC Back :',
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
                                      text: 'Insurance :',
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
                                      text: 'FC Copy :',
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
                                      .carApproval(carsList.id);
                                  print(data);
                                  if (data['statusCode'] == 1) {
                                    Fluttertoast.showToast(
                                        msg: 'Car Accepted', fontSize: 18);
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
                                    var data = await ApiService()
                                        .carReject(carsList.id, reason.text);
                                    print(data);
                                    if (data['statusCode'] == 1) {
                                      Fluttertoast.showToast(
                                          msg: 'Car Rejected', fontSize: 18);
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

  buildAddCarSmall() {
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
              itemCount: carListModel!.body!.carList!.length,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemBuilder: (context, index) {
                var carsList = carListModel!.body!.carList![index];
                var documentStatus = carListModel!.body!.carList!.length ==
                        carImageViewedStatusList!.length
                    ? true
                    : false;
                CarImageViewedStatusListModel carsDocuments;
                if (documentStatus == true) {
                  carsDocuments = carImageViewedStatusList![index];
                }
                return Column(
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            const CustomText(
                              text: 'Register NUmber :',
                              weight: FontWeight.bold,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            CustomText(
                              text: '${carsList.carNumber}',
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
                              text: 'Model :',
                              weight: FontWeight.bold,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            CustomText(
                              text: '${carsList.model}',
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
                              text: 'Car Front Image :',
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
                              text: 'Car Chassis Image :',
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
                              text: 'RC Front :',
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
                              text: 'RC Back :',
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
                              text: 'Insurance :',
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
                              text: 'FC Copy :',
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
                    const SizedBox(height: 10),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            fixedSize: const Size(250, 40)),
                        onPressed: () async {
                          var data =
                              await ApiService().carApproval(carsList.id);
                          print(data);
                          if (data['statusCode'] == 1) {
                            Fluttertoast.showToast(
                                msg: 'Car Accepted', fontSize: 18);
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
                                .carReject(carsList.id, reason.text);
                            print(data);
                            if (data['statusCode'] == 1) {
                              Fluttertoast.showToast(
                                  msg: 'Car Rejected', fontSize: 18);
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
