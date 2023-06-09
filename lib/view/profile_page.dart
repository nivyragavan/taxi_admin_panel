import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:get/get.dart';
import 'package:taxi_admin_panel/constant/style.dart';
import 'package:taxi_admin_panel/controller/profile_controller.dart';
import 'package:taxi_admin_panel/view/authentication.dart';
import 'package:taxi_admin_panel/widgets/custom_text.dart';
import 'package:taxi_admin_panel/widgets/sidebar_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  static const String id = "profile_page";

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
        backgroundColor: light,
        appBar: AppBar(
          title:  Text(
            'Admin Panel',
            style: TextStyle(color: black),
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
        sideBar: SideBarWidget().sidebarMenus(ProfilePage.id),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: Get.width,
            height: Get.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomText(
                  text: 'Profile',
                  size: 20,
                  weight: FontWeight.bold,
                  color: blue,
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: buildProfile(),
                ),
              ],
            ),
          ),
        ));
  }

  Obx buildProfile() {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(color: blue),
        );
      }
      return SingleChildScrollView(
        child: SizedBox(
          width: 500,
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: CustomText(
                        text: "Name :",
                        color: blue,
                        weight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: controller.nameController,
                      cursorColor: blue,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          border: const OutlineInputBorder(),
                          hintText: "Enter your name",
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: blue))),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  SizedBox(
                    width: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: CustomText(
                        text: "Phone Number :",
                        color: blue,
                        weight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: controller.phoneController,
                      cursorColor: blue,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          border: const OutlineInputBorder(),
                          hintText: "Enter your phone number",
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: blue))),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  SizedBox(
                    width: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: CustomText(
                        text: "Email :",
                        color: blue,
                        weight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: controller.emailController,
                      cursorColor: blue,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          border: const OutlineInputBorder(),
                          hintText: "Enter your email address",
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: blue))),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  SizedBox(
                    width: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: CustomText(
                        text: "Password :",
                        color: blue,
                        weight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: controller.passwordController,
                      cursorColor: blue,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          border: const OutlineInputBorder(),
                          hintText: "Enter your password",
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: blue))),
                    ),
                  ),
                ],
              ),
              // const SizedBox(height: 30),
              // ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //         backgroundColor: green, padding: const EdgeInsets.all(15)),
              //     onPressed: () {},
              //     child: const Text(
              //       "Update",
              //       style: TextStyle(fontSize: 15, color: Colors.white),
              //     ))
            ],
          ),
        ),
      );
    });
    // });
  }
}
