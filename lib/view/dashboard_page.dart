import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:taxi_admin_panel/constant/responsiveness.dart';
import 'package:taxi_admin_panel/constant/style.dart';
import 'package:taxi_admin_panel/view/authentication.dart';
import 'package:taxi_admin_panel/widgets/custom_text.dart';
import 'package:taxi_admin_panel/widgets/info_card.dart';
import 'package:taxi_admin_panel/widgets/info_card_small.dart';
import 'package:taxi_admin_panel/widgets/revenue_info.dart';
import 'package:taxi_admin_panel/widgets/sidebar_widget.dart';
import 'package:taxi_admin_panel/widgets/userinfo.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  static const String id = "dashboard_page";

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<Map<String, String>> availableDriersInfo = [
    {
      "id": "001",
      "name": "nivy",
      "email": "nivy@gmail.com",
      "phone": "6382136565",
      "location": "thiruvarur",
      "rating": "4.5",
      "action": "block"
    },
    {
      "id": "002",
      "name": "priya",
      "email": "priya@gmail.com",
      "phone": "7867997754",
      "location": "coimbatore",
      "rating": "4.7",
      "action": "block"
    },
    {
      "id": "003",
      "name": "arun",
      "email": "arun@gmail.com",
      "phone": "6382136556",
      "location": "cbe",
      "rating": "4.3",
      "action": "block"
    },
  ];

  final List<RevenueChartData> revenueChartData = [
    RevenueChartData('Mon', 20),
    RevenueChartData('Tues', 30),
    RevenueChartData('Wed', 10),
    RevenueChartData('Thurs', 40),
    RevenueChartData('Fri', 20),
    RevenueChartData('Sat', 50),
    RevenueChartData('Sun', 60)
  ];

  final DataTableSource dataTableSource = MyData();

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
        backgroundColor: light,
        appBar: AppBar(
          title:  Text(
            'Admin Panel',
            style: TextStyle(color:black),
          ),
          backgroundColor: yellow,
          actions: [
            IconButton(
                onPressed: () {
                  Get.offAll(const AuthenticationPage());
                },
                icon: Icon(
                  Icons.logout,
                  color: black,
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
                  text: 'Dashboard',
                  size: 20,
                  weight: FontWeight.bold,
                  color: blue,
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: [
                      if (ResponsiveWidget.isLargeScreen(context))
                        buildOverviewCardsLargeScreen(context)
                      else
                        buildOverviewCardsSmallScreen(context),
                      if (!ResponsiveWidget.isSmallScreen(context))
                        buildRevenueSectionLarge(context)
                      else
                        buildRevenueSectionSmall(context),
                      if (!ResponsiveWidget.isSmallScreen(context))
                        buildUserSectionLarge(context)
                      else
                        buildUserSectionSmall(context),
                      if (!ResponsiveWidget.isSmallScreen(context))
                        buildDriverSectionLarge(context)
                      else
                        buildDriverSectionSmall(context),
                      CustomText(
                        text: 'Available Drivers',
                        size: 17,
                        weight: FontWeight.bold,
                        color: dark,
                      ),
                      const SizedBox(height: 20),
                      buildAvailableDriversTable()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  buildOverviewCardsLargeScreen(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        InfoCard(
          title: "Rides in progress",
          value: "0",
          onTap: () {},
          topColor: Colors.orange,
        ),
        SizedBox(
          width: width / 64,
        ),
        InfoCard(
          title: "Rides Completed",
          value: "0",
          topColor: Colors.lightGreen,
          onTap: () {},
        ),
        SizedBox(
          width: width / 64,
        ),
        InfoCard(
          title: "Cancelled Rides",
          value: "0",
          topColor: Colors.redAccent,
          onTap: () {},
        ),
        SizedBox(
          width: width / 64,
        ),
        InfoCard(
          title: "Scheduled Rides",
          value: "0",
          onTap: () {},
          topColor: active,
        ),
      ],
    );
  }

  buildOverviewCardsSmallScreen(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 400,
      child: Column(
        children: [
          InfoCardSmall(
            title: "Rides in progress",
            value: "0",
            onTap: () {},
            isActive: true,
          ),
          SizedBox(
            height: width / 64,
          ),
          InfoCardSmall(
            title: "Rides Completed",
            value: "0",
            onTap: () {},
          ),
          SizedBox(
            height: width / 64,
          ),
          InfoCardSmall(
            title: "Cancelled Rides",
            value: "0",
            onTap: () {},
          ),
          SizedBox(
            height: width / 64,
          ),
          InfoCardSmall(
            title: "Scheduled Rides",
            value: "0",
            onTap: () {},
          ),
        ],
      ),
    );
  }

  buildRevenueSectionLarge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 6),
              color: lightGrey.withOpacity(.1),
              blurRadius: 12)
        ],
        border: Border.all(color: lightGrey, width: .5),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomText(
                  text: "Revenue Chart",
                  size: 20,
                  weight: FontWeight.bold,
                  color: dark,
                ),
                SizedBox(
                    width: 600,
                    height: 200,
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      palette: [blue],
                      series: [
                        StackedColumnSeries(
                            dataSource: revenueChartData,
                            xValueMapper: (RevenueChartData ch, _) => ch.x,
                            yValueMapper: (RevenueChartData ch, _) => ch.y)
                      ],
                    ))
              ],
            ),
          ),
          Container(
            width: 1,
            height: 120,
            color: lightGrey,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: const [
                    RevenueInfo(
                      title: "Today\'s revenue",
                      amount: "230",
                    ),
                    RevenueInfo(
                      title: "Last 7 days",
                      amount: "1,100",
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: const [
                    RevenueInfo(
                      title: "Last 30 days",
                      amount: "3,230",
                    ),
                    RevenueInfo(
                      title: "Last 12 months",
                      amount: "11,300",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildUserSectionLarge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 6),
              color: lightGrey.withOpacity(.1),
              blurRadius: 12)
        ],
        border: Border.all(color: lightGrey, width: .5),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomText(
                  text: "User Chart",
                  size: 20,
                  weight: FontWeight.bold,
                  color: dark,
                ),
                SizedBox(
                    width: 600,
                    height: 200,
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      palette: [yellow],
                      series: [
                        StackedColumnSeries(
                            dataSource: revenueChartData,
                            xValueMapper: (RevenueChartData ch, _) => ch.x,
                            yValueMapper: (RevenueChartData ch, _) => ch.y)
                      ],
                    )),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 120,
            color: lightGrey,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: const [
                    UserInfo(
                      title: "Today\'s users",
                      count: "2",
                    ),
                    UserInfo(
                      title: "Last 7 days",
                      count: "10",
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: const [
                    UserInfo(
                      title: "Last 30 days",
                      count: "50",
                    ),
                    UserInfo(
                      title: "Last 12 months",
                      count: "1300",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildDriverSectionLarge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 6),
              color: lightGrey.withOpacity(.1),
              blurRadius: 12)
        ],
        border: Border.all(color: lightGrey, width: .5),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomText(
                  text: "Driver Chart",
                  size: 20,
                  weight: FontWeight.bold,
                  color: dark,
                ),
                SizedBox(
                    width: 600,
                    height: 200,
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      palette: [yellow],
                      series: [
                        StackedColumnSeries(
                            dataSource: revenueChartData,
                            xValueMapper: (RevenueChartData ch, _) => ch.x,
                            yValueMapper: (RevenueChartData ch, _) => ch.y)
                      ],
                    )),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 120,
            color: lightGrey,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: const [
                    UserInfo(
                      title: "Today\'s drivers",
                      count: "2",
                    ),
                    UserInfo(
                      title: "Last 7 days",
                      count: "10",
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: const [
                    UserInfo(
                      title: "Last 30 days",
                      count: "50",
                    ),
                    UserInfo(
                      title: "Last 12 months",
                      count: "1300",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildRevenueSectionSmall(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 6),
              color: lightGrey.withOpacity(.1),
              blurRadius: 12)
        ],
        border: Border.all(color: lightGrey, width: .5),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 260,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomText(
                  text: "Revenue Chart",
                  size: 20,
                  weight: FontWeight.bold,
                  color: dark,
                ),
                SizedBox(
                    width: 600,
                    height: 200,
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      palette: [blue],
                      series: [
                        StackedColumnSeries(
                            dataSource: revenueChartData,
                            xValueMapper: (RevenueChartData ch, _) => ch.x,
                            yValueMapper: (RevenueChartData ch, _) => ch.y)
                      ],
                    )),
              ],
            ),
          ),
          Container(
            width: 120,
            height: 1,
            color: lightGrey,
          ),
          SizedBox(
            height: 260,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: const [
                    RevenueInfo(
                      title: "Today\'s revenue",
                      amount: "230",
                    ),
                    RevenueInfo(
                      title: "Last 7 days",
                      amount: "1,100",
                    ),
                  ],
                ),
                Row(
                  children: const [
                    RevenueInfo(
                      title: "Last 30 days",
                      amount: "3,230",
                    ),
                    RevenueInfo(
                      title: "Last 12 months",
                      amount: "11,300",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildUserSectionSmall(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 6),
              color: lightGrey.withOpacity(.1),
              blurRadius: 12)
        ],
        border: Border.all(color: lightGrey, width: .5),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 260,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomText(
                  text: "User Chart",
                  size: 20,
                  weight: FontWeight.bold,
                  color: dark,
                ),
                SizedBox(
                    width: 600,
                    height: 200,
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      palette: [yellow],
                      series: [
                        StackedColumnSeries(
                            dataSource: revenueChartData,
                            xValueMapper: (RevenueChartData ch, _) => ch.x,
                            yValueMapper: (RevenueChartData ch, _) => ch.y)
                      ],
                    )),
              ],
            ),
          ),
          Container(
            width: 120,
            height: 1,
            color: lightGrey,
          ),
          SizedBox(
            height: 260,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: const [
                    UserInfo(
                      title: "Today\'s users",
                      count: "2",
                    ),
                    UserInfo(
                      title: "Last 7 days",
                      count: "10",
                    ),
                  ],
                ),
                Row(
                  children: const [
                    UserInfo(
                      title: "Last 30 days",
                      count: "50",
                    ),
                    UserInfo(
                      title: "Last 12 months",
                      count: "1300",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildDriverSectionSmall(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 6),
              color: lightGrey.withOpacity(.1),
              blurRadius: 12)
        ],
        border: Border.all(color: lightGrey, width: .5),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 260,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomText(
                  text: "Driver Chart",
                  size: 20,
                  weight: FontWeight.bold,
                  color: dark,
                ),
                SizedBox(
                    width: 600,
                    height: 200,
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      palette: [yellow],
                      series: [
                        StackedColumnSeries(
                            dataSource: revenueChartData,
                            xValueMapper: (RevenueChartData ch, _) => ch.x,
                            yValueMapper: (RevenueChartData ch, _) => ch.y)
                      ],
                    )),
              ],
            ),
          ),
          Container(
            width: 120,
            height: 1,
            color: lightGrey,
          ),
          SizedBox(
            height: 260,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: const [
                    UserInfo(
                      title: "Today\'s drivers",
                      count: "2",
                    ),
                    UserInfo(
                      title: "Last 7 days",
                      count: "10",
                    ),
                  ],
                ),
                Row(
                  children: const [
                    UserInfo(
                      title: "Last 30 days",
                      count: "50",
                    ),
                    UserInfo(
                      title: "Last 12 months",
                      count: "1300",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildAvailableDriversTable() {
    return Card(
      shape: RoundedRectangleBorder(
          side: BorderSide(color: lightGrey),
          borderRadius: BorderRadius.circular(10)),
      child: PaginatedDataTable(
        columns: [
          DataColumn(
              label: Text('Id', style: TextStyle(fontSize: 15, color: blue))),
          DataColumn(
              label:
                  Text('Name', style: TextStyle(fontSize: 15, color: blue))),
          DataColumn(
              label:
                  Text('Email', style: TextStyle(fontSize: 15, color: blue))),
          DataColumn(
              label: Text('Phone Number',
                  style: TextStyle(fontSize: 15, color: blue))),
          DataColumn(
              label: Text('Location',
                  style: TextStyle(fontSize: 15, color: blue))),
          DataColumn(
              label: Text('Ratings',
                  style: TextStyle(fontSize: 15, color: blue))),
        ],
        source: dataTableSource,
        // columnSpacing: 30,
        horizontalMargin: 40,
        arrowHeadColor: green,
      ),
    );
  }
}

class MyData extends DataTableSource {
  final List<Map<String, dynamic>> data = List.generate(
      20,
      (index) => {
            "id": index + 1,
            "name": "Nivy",
            "email": "nivy@gmail.com",
            "number": "6382136965",
            "location": "Coimbatore",
            "ratings": "4.5"
          });

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(data[index]["id"].toString())),
      DataCell(Text(data[index]["name"])),
      DataCell(Text(data[index]["email"])),
      DataCell(Text(data[index]["number"])),
      DataCell(Text(data[index]["location"])),
      DataCell(Row(
        children: [
          const Icon(Icons.star, color: Colors.amber, size: 20),
          const SizedBox(width: 5),
          Text(data[index]["ratings"]),
        ],
      ))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}

class RevenueChartData {
  final String x;
  final int y;

  RevenueChartData(this.x, this.y);
}
