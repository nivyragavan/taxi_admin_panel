import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxi_admin_panel/view/authentication.dart';
import 'package:taxi_admin_panel/view/cars/add_car_page.dart';
import 'package:taxi_admin_panel/view/cars/car_list_page.dart';
import 'package:taxi_admin_panel/view/dashboard_page.dart';
import 'package:taxi_admin_panel/view/drivers/add_driver_page.dart';
import 'package:taxi_admin_panel/view/drivers/driver_list_page.dart';
import 'package:taxi_admin_panel/view/home_page.dart';
import 'package:taxi_admin_panel/view/location_page.dart';
import 'package:taxi_admin_panel/view/package_cab_page.dart';
import 'package:taxi_admin_panel/view/profile_page.dart';
import 'package:taxi_admin_panel/view/rides/cancelled_rides_page.dart';
import 'package:taxi_admin_panel/view/rides/completed_rides_page.dart';
import 'package:taxi_admin_panel/view/rides/manual_booking_history.dart';
import 'package:taxi_admin_panel/view/rides/ride_history_page.dart';
import 'package:taxi_admin_panel/view/rides/rides_in_progress_page.dart';
import 'package:taxi_admin_panel/view/rides/scheduled_rides_page.dart';
import 'package:taxi_admin_panel/view/sub_admin_page.dart';
import 'package:taxi_admin_panel/view/user_page.dart';
import 'package:taxi_admin_panel/view/vendors/add_vendor_page.dart';
import 'package:taxi_admin_panel/view/vendors/assigned_drivers_list_page.dart';
import 'package:taxi_admin_panel/view/vendors/vendor_list_page.dart';
import 'package:taxi_admin_panel/view/vendors/vendor_wallet_transaction_page.dart';
import 'package:url_strategy/url_strategy.dart';
import 'constant/style.dart';

void main() {
  GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

   var box = GetStorage();

  @override
  Widget build(BuildContext context) {
    var adminLogin = box.read("adminLogin");
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Dashboard',
      theme: ThemeData(
        scaffoldBackgroundColor: light,
        textTheme: GoogleFonts.mulishTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.black),
        primarySwatch: Colors.grey,
      ),
      // initialRoute: AuthenticationPage.id,
      routes:{
        AuthenticationPage.id :(context) => const AuthenticationPage(),
        HomePage.id : (context) =>  const HomePage(),
        DashboardPage.id : (context) => const DashboardPage(),
        ProfilePage.id : (context) => const ProfilePage(),
        SubAdminPage.id : (context) =>const SubAdminPage(),
        PackageAndCabPage.id : (context) => const PackageAndCabPage(),
        AddVendorPage.id : (context) => const AddVendorPage(),
        VendorListPage.id : (context) => const VendorListPage(),
        AssignedDriversListPage.id : (context) => const AssignedDriversListPage(),
        VendorWalletTransactionPage.id : (context) => const VendorWalletTransactionPage(),
        AddDriverPage.id : (context) => const AddDriverPage(),
        DriverListPage.id : (context) => const DriverListPage(),
        AddCarPage.id : (context) => const AddCarPage(),
        CarListPage.id : (context) => const CarListPage(),
        UserPage.id : (context) => const UserPage(),
        RidesInProgressPage.id : (context) => const RidesInProgressPage(),
        CompletedRidesPage.id : (context) => const CompletedRidesPage(),
        CancelledRidesPage.id : (context) => const CancelledRidesPage(),
        ScheduledRidesPage.id : (context) => const ScheduledRidesPage(),
        RidesHistoryPage.id : (context) => const RidesHistoryPage(),
        ManualBookingHistoryPage.id : (context) => const ManualBookingHistoryPage(),
        LocationPage.id : (context) => const LocationPage()
      },
      home: adminLogin == null ? AuthenticationPage() : const DashboardPage(),
    );
  }
}
