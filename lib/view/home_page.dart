// import 'package:flutter/material.dart';
// import 'package:flutter_admin_scaffold/admin_scaffold.dart';
// import 'package:get/get.dart';
// import 'package:taxi_admin_panel/constant/style.dart';
// import 'package:taxi_admin_panel/view/authentication.dart';
// import 'package:taxi_admin_panel/view/cars/add_car_page.dart';
// import 'package:taxi_admin_panel/view/cars/car_list_page.dart';
// import 'package:taxi_admin_panel/view/dashboard_page.dart';
// import 'package:taxi_admin_panel/view/drivers/add_driver_page.dart';
// import 'package:taxi_admin_panel/view/drivers/driver_list_page.dart';
// import 'package:taxi_admin_panel/view/pricing_page.dart';
// import 'package:taxi_admin_panel/view/package_cab_page.dart';
// import 'package:taxi_admin_panel/view/profile_page.dart';
// import 'package:taxi_admin_panel/view/rides/cancelled_rides_page.dart';
// import 'package:taxi_admin_panel/view/rides/completed_rides_page.dart';
// import 'package:taxi_admin_panel/view/rides/manual_booking_history.dart';
// import 'package:taxi_admin_panel/view/rides/ride_history_page.dart';
// import 'package:taxi_admin_panel/view/rides/rides_in_progress_page.dart';
// import 'package:taxi_admin_panel/view/rides/scheduled_rides_page.dart';
// import 'package:taxi_admin_panel/view/sub_admin_page.dart';
// import 'package:taxi_admin_panel/view/user_page.dart';
// import 'package:taxi_admin_panel/view/vendors/add_vendor_page.dart';
// import 'package:taxi_admin_panel/view/vendors/assigned_drivers_list_page.dart';
// import 'package:taxi_admin_panel/view/vendors/vendor_list_page.dart';
// import 'package:taxi_admin_panel/view/vendors/vendor_wallet_transaction_page.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   static const String id = "home_page";
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   Widget selectedPage = const DashboardPage();
//
//   currentPage(item) {
//     switch (item.route) {
//       case DashboardPage.id:
//         setState(() {
//           selectedPage = const DashboardPage();
//         });
//         break;
//       case ProfilePage.id:
//         setState(() {
//           selectedPage = const ProfilePage();
//         });
//         break;
//       case SubAdminPage.id:
//         setState(() {
//           selectedPage = const SubAdminPage();
//         });
//         break;
//       case PackageAndCabPage.id:
//         setState(() {
//           selectedPage = const PackageAndCabPage();
//         });
//         break;
//       case AddVendorPage.id:
//         setState(() {
//           selectedPage = const AddVendorPage();
//         });
//         break;
//       case VendorListPage.id:
//         setState(() {
//           selectedPage = const VendorListPage();
//         });
//         break;
//       case AssignedDriversListPage.id:
//         setState(() {
//           selectedPage = const AssignedDriversListPage();
//         });
//         break;
//       case VendorWalletTransactionPage.id:
//         setState(() {
//           selectedPage = const VendorWalletTransactionPage();
//         });
//         break;
//       case AddDriverPage.id:
//         setState(() {
//           selectedPage = const AddDriverPage();
//         });
//         break;
//       case DriverListPage.id:
//         setState(() {
//           selectedPage = const DriverListPage();
//         });
//         break;
//       case AddCarPage.id:
//         setState(() {
//           selectedPage = const AddCarPage();
//         });
//         break;
//       case CarListPage.id:
//         setState(() {
//           selectedPage = const CarListPage();
//         });
//         break;
//       case UserPage.id:
//         setState(() {
//           selectedPage = const UserPage();
//         });
//         break;
//       case RidesInProgressPage.id:
//         setState(() {
//           selectedPage = const RidesInProgressPage();
//         });
//         break;
//       case CompletedRidesPage.id:
//         setState(() {
//           selectedPage = const CompletedRidesPage();
//         });
//         break;
//       case CancelledRidesPage.id:
//         setState(() {
//           selectedPage = const CancelledRidesPage();
//         });
//         break;
//       case ScheduledRidesPage.id:
//         setState(() {
//           selectedPage = const ScheduledRidesPage();
//         });
//         break;
//       case RidesHistoryPage.id:
//         setState(() {
//           selectedPage = const RidesHistoryPage();
//         });
//         break;
//       case ManualBookingHistoryPage.id:
//         setState(() {
//           selectedPage = const ManualBookingHistoryPage();
//         });
//         break;
//       case LocationPage.id:
//         setState(() {
//           selectedPage = const LocationPage();
//         });
//         break;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AdminScaffold(
//       backgroundColor: light,
//       appBar: AppBar(
//         title: const Text(
//           'Admin Panel',
//           style: TextStyle(color: Colors.black),
//         ),
//         backgroundColor: lightGreen,
//         actions: [
//           IconButton(
//               onPressed: () {
//                 Get.offAll(AuthenticationPage());
//               },
//               icon: const Icon(Icons.logout,color: Colors.black,))
//         ],
//       ),
//       sideBar: SideBar(
//         backgroundColor: lightGreen,
//         borderColor: const Color(0xFFE7E7E7),
//         iconColor: Colors.black,
//         activeIconColor: light,
//         textStyle:const TextStyle(
//           color: Colors.black,
//           fontSize: 15,
//         ),
//         activeTextStyle:const TextStyle(
//           color: Colors.black,
//           fontSize: 15,
//         ),
//         items: const [
//           AdminMenuItem(
//             title: 'Dashboard',
//             route: DashboardPage.id,
//             icon: Icons.dashboard,
//           ),
//           AdminMenuItem(
//             title: 'Profile',
//             route: ProfilePage.id,
//             icon: Icons.account_circle_outlined,
//           ),
//           AdminMenuItem(
//             title: 'Sub-Admin',
//             route: SubAdminPage.id,
//             icon: Icons.group_add_outlined,
//           ),
//           AdminMenuItem(
//             title: 'Package and Cab',
//             route: PackageAndCabPage.id,
//             icon: Icons.add,
//           ),
//           AdminMenuItem(title: 'Vendors', icon: Icons.person, children: [
//             AdminMenuItem(
//               title: 'Add Vendor',
//               route: AddVendorPage.id,
//               icon: Icons.add,
//             ),
//             AdminMenuItem(
//               title: 'Vendor List',
//               route: VendorListPage.id,
//               icon: Icons.list_rounded,
//             ),
//             AdminMenuItem(
//               title: 'Assigned Driver List',
//               route: AssignedDriversListPage.id,
//               icon: Icons.people,
//             ),
//             AdminMenuItem(
//               title: 'Wallet Transaction',
//               route: VendorWalletTransactionPage.id,
//               icon: Icons.wallet,
//             ),
//           ]),
//           AdminMenuItem(title: 'Drivers', icon: Icons.person, children: [
//             AdminMenuItem(
//               title: 'Add Driver',
//               route: AddDriverPage.id,
//               icon: Icons.add,
//             ),
//             AdminMenuItem(
//               title: 'Driver List',
//               route: DriverListPage.id,
//               icon: Icons.list_rounded,
//             ),
//           ]),
//           AdminMenuItem(title: 'Cars', icon: Icons.drive_eta, children: [
//             AdminMenuItem(
//               title: 'Add Car',
//               route: AddCarPage.id,
//               icon: Icons.add,
//             ),
//             AdminMenuItem(
//               title: 'Car List',
//               route: CarListPage.id,
//               icon: Icons.list_rounded,
//             ),
//           ]),
//           AdminMenuItem(
//             title: 'Users',
//             route: UserPage.id,
//             icon: Icons.group,
//           ),
//           AdminMenuItem(title: 'Rides', icon: Icons.drive_eta, children: [
//             AdminMenuItem(
//               title: 'Rides In Progress',
//               route: RidesInProgressPage.id,
//               icon: Icons.loop_rounded,
//             ),
//             AdminMenuItem(
//               title: 'Completed Rides',
//               route: CompletedRidesPage.id,
//               icon: Icons.check_circle_outlined,
//             ),
//             AdminMenuItem(
//               title: 'Cancelled Rides',
//               route: CancelledRidesPage.id,
//               icon: Icons.cancel_outlined,
//             ),
//             AdminMenuItem(
//               title: 'Scheduled Rides',
//               route: ScheduledRidesPage.id,
//               icon: Icons.schedule_rounded,
//             ),
//             AdminMenuItem(
//               title: 'Rides History',
//               route: RidesHistoryPage.id,
//               icon: Icons.history_toggle_off,
//             ),
//             AdminMenuItem(
//               title: 'Manual Booking History',
//               route: ManualBookingHistoryPage.id,
//               icon: Icons.history,
//             ),
//           ]),
//           AdminMenuItem(
//             title: 'Location',
//             route: LocationPage.id,
//             icon: Icons.location_on,
//           ),
//         ],
//         selectedRoute: HomePage.id,
//         onSelected: (item) {
//           currentPage(item);
//         },
//       ),
//       body: SizedBox(
//         width: Get.width,
//           height: Get.height,
//           child: selectedPage),
//     );
//   }
// }
