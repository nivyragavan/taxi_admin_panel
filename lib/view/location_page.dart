import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:get/get.dart';
import 'package:taxi_admin_panel/constant/responsiveness.dart';
import 'package:taxi_admin_panel/constant/style.dart';
import 'package:taxi_admin_panel/widgets/custom_text.dart';

import '../widgets/sidebar_widget.dart';
import 'authentication.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({Key? key}) : super(key: key);

  static const String id = "location_page";

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
    sideBar: SideBarWidget().sidebarMenus(LocationPage.id),
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'Location',
              size: 20,
              weight: FontWeight.bold,
              color: green,
            ),
            const SizedBox(height: 20),
            Expanded(
                child: ListView(
                  children: [if (!ResponsiveWidget.isSmallScreen(context))
                    buildLocationTextFieldsLarge()
                  else
                    buildLocationTextFieldsSmall(),],
                )),
          ],
        ),
      ),
    )
    );
  }

  buildLocationTextFieldsLarge() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            cursorColor: green,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                border: const OutlineInputBorder(),
                focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: green)),
                hintText: 'Enter Location'),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            cursorColor: green,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                border: const OutlineInputBorder(),
                focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: green)),
                hintText: 'Enter from pincode'),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            cursorColor: green,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                border: const OutlineInputBorder(),
                focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: green)),
                hintText: 'Enter to pincode'),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            cursorColor: green,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                border: const OutlineInputBorder(),
                focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: green)),
                hintText: 'Select specific place'),
          ),
        ),
      ],
    );
  }

  buildLocationTextFieldsSmall() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                cursorColor: green,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: green)),
                    hintText: 'Enter Location'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                cursorColor: green,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: green)),
                    hintText: 'Enter from pincode'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextField(
                cursorColor: green,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: green)),
                    hintText: 'Enter to pincode'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                cursorColor: green,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: green)),
                    hintText: 'Select specific place'),
              ),
            ),
          ],
        )
      ],
    );
  }
}