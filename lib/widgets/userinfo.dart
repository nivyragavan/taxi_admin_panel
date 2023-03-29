import 'package:flutter/material.dart';
import 'package:taxi_admin_panel/constant/style.dart';


class UserInfo extends StatelessWidget {
  final String? title;
  final String? count;

  const UserInfo({Key? key, this.title, this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            TextSpan(
                text: "$title \n\n",
                style: TextStyle(color: dark, fontSize: 16)),
            TextSpan(
                text: "$count",
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ])),
    );
  }
}
