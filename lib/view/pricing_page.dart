import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:taxi_admin_panel/constant/responsiveness.dart';
import 'package:taxi_admin_panel/constant/style.dart';
import 'package:taxi_admin_panel/widgets/custom_text.dart';

import '../widgets/sidebar_widget.dart';
import 'authentication.dart';

class PricingPage extends StatelessWidget {
  const PricingPage({Key? key}) : super(key: key);

  static const String id = "pricing_page";

  static final package = TextEditingController();

  static const packageList = [
    'Mini',
    'Sedan',
    'XUV',
    'Rental',
    'Outstation',
    'Tour'
  ];

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
        sideBar: SideBarWidget().sidebarMenus(PricingPage.id),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: Get.width,
            height: Get.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Pricing',
                  size: 20,
                  weight: FontWeight.bold,
                  color: green,
                ),
                const SizedBox(height: 20),
                Expanded(
                    child: ListView(
                  children: [
                    if (!ResponsiveWidget.isSmallScreen(context))
                      buildPricingTextFieldsLarge()
                    else
                      buildPricingTextFieldsSmall(),
                  ],
                )),
              ],
            ),
          ),
        ));
  }

  buildPricingTextFieldsLarge() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: 'Package',
          size: 15,
          weight: FontWeight.bold,
          color: dark,
        ),
        const SizedBox(height: 10,),
        SizedBox(
          width: 500,
          child: TypeAheadFormField(
              textFieldConfiguration: TextFieldConfiguration(
                  controller: package,
                  decoration:  InputDecoration(
                      suffixIcon: Icon(
                        Icons.arrow_drop_down_rounded,
                        size: 40,
                        color: dark,
                      ),
                      hintText: 'Select a package',
                      border: const OutlineInputBorder(),
                      focusedBorder:
                      OutlineInputBorder(borderSide: BorderSide(color: green)),
                      contentPadding: const EdgeInsets.all(15),
                      isDense: true
                  )),
              suggestionsCallback: (pattern) {
                return packageList.where((item) => item
                    .toLowerCase()
                    .contains(pattern.toLowerCase()));
              },
              onSuggestionSelected: (String val) {
                package.text = val;
              },
              itemBuilder: (_, String item) {
                return ListTile(
                  title: Text(item),
                );
              },
              getImmediateSuggestions: true,
              hideSuggestionsOnKeyboardHide: false,
              hideOnEmpty: false,
              noItemsFoundBuilder: (context) => const Padding(
                padding: EdgeInsets.all(8),
                child: Text('No item found'),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Select a category';
                }
                return null;
              }),
        ),
        const SizedBox(height: 15,),
        CustomText(
          text: 'Base Fare',
          size: 15,
          weight: FontWeight.bold,
          color: dark,
        ),
        const SizedBox(height: 10,),
        SizedBox(
          width: 500,
          child: TextField(
            cursorColor: green,
            decoration: InputDecoration(
                isDense:true,
                contentPadding: const EdgeInsets.all(15),
                border: const OutlineInputBorder(),
                focusedBorder:
                    OutlineInputBorder(borderSide: BorderSide(color: green)),
                hintText: 'Enter Base Fare'),
          ),
        ),
        const SizedBox(height: 15,),
        CustomText(
          text: 'Duration Fare (in hrs)',
          size: 15,
          weight: FontWeight.bold,
          color: dark,
        ),
        const SizedBox(height: 10,),
        SizedBox(
          width: 500,
          child: TextField(
            cursorColor: green,
            decoration: InputDecoration(
                isDense:true,
                contentPadding: const EdgeInsets.all(15),
                border: const OutlineInputBorder(),
                focusedBorder:
                    OutlineInputBorder(borderSide: BorderSide(color: green)),
                hintText: 'Enter duration fare in hours'),
          ),
        ),
        const SizedBox(height: 15,),
        CustomText(
          text: 'Distance Fare (in km)',
          size: 15,
          weight: FontWeight.bold,
          color: dark,
        ),
        const SizedBox(height: 10,),
        SizedBox(
          width: 500,
          child: TextField(
            cursorColor: green,
            decoration: InputDecoration(
              isDense:true,
                contentPadding: const EdgeInsets.all(15),
                border: const OutlineInputBorder(),
                focusedBorder:
                    OutlineInputBorder(borderSide: BorderSide(color: green)),
                hintText: 'Enter distance fare in km'),
          ),
        ),
        const SizedBox(height: 20,),
        SizedBox(
          width: 500,
          child: Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: green,
                fixedSize:const Size(100, 35)
              ),
                onPressed: (){}, child: const Text('Add',style: TextStyle(color: Colors.white,letterSpacing: 1,fontWeight: FontWeight.bold),)),
          ),
        )
      ],
    );
  }

  buildPricingTextFieldsSmall() {
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
