import 'package:flutter/material.dart';
import 'package:taxi_admin_panel/constant/style.dart';


class RevenueInfo extends StatelessWidget {
  final String? title;
  final String? amount;

  const RevenueInfo({Key? key, this.title, this.amount}) : super(key: key);

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
                text: "\u{20B9} $amount",
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ])),
    );
  }
}
