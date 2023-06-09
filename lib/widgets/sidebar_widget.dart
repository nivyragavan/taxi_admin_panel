import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:get/get.dart';
import 'package:taxi_admin_panel/constant/style.dart';
import 'package:taxi_admin_panel/view/cars/add_car_page.dart';
import 'package:taxi_admin_panel/view/cars/car_list_page.dart';
import 'package:taxi_admin_panel/view/dashboard_page.dart';
import 'package:taxi_admin_panel/view/drivers/add_driver_page.dart';
import 'package:taxi_admin_panel/view/drivers/driver_list_page.dart';
import 'package:taxi_admin_panel/view/pricing_page.dart';
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

class SideBarWidget{
  sidebarMenus(selectedRoute){
    return SideBar(
      backgroundColor: yellow,
      iconColor: black,
      activeIconColor: grey,
      textStyle:  TextStyle(
        color: black,
        fontSize: 15,
      ),
      activeTextStyle: TextStyle(
        color: grey,
        fontSize: 15,
      ),
      activeBackgroundColor: blue,
      borderColor: Colors.grey,
      items: const [
        AdminMenuItem(
          title: 'Dashboard',
          route: DashboardPage.id,
          icon: Icons.dashboard,
        ),
        AdminMenuItem(
          title: 'Profile',
          route: ProfilePage.id,
          icon: Icons.account_circle_outlined,
        ),
        AdminMenuItem(
          title: 'Sub-Admin',
          route: SubAdminPage.id,
          icon: Icons.group_add_outlined,
        ),
        AdminMenuItem(
          title: 'Package and Cab',
          route: PackageAndCabPage.id,
          icon: Icons.add,
        ),
        AdminMenuItem(title: 'Vendors', icon: Icons.person, children: [
          AdminMenuItem(
            title: 'Add Vendor',
            route: AddVendorPage.id,
            icon: Icons.add,
          ),
          AdminMenuItem(
            title: 'Vendor List',
            route: VendorListPage.id,
            icon: Icons.list_rounded,
          ),
          AdminMenuItem(
            title: 'Assigned Driver List',
            route: AssignedDriversListPage.id,
            icon: Icons.people,
          ),
          AdminMenuItem(
            title: 'Wallet Transaction',
            route: VendorWalletTransactionPage.id,
            icon: Icons.wallet,
          ),
        ]),
        AdminMenuItem(title: 'Drivers', icon: Icons.person, children: [
          AdminMenuItem(
            title: 'Add Driver',
            route: AddDriverPage.id,
            icon: Icons.add,
          ),
          AdminMenuItem(
            title: 'Driver List',
            route: DriverListPage.id,
            icon: Icons.list_rounded,
          ),
        ]),
        AdminMenuItem(title: 'Cars', icon: Icons.drive_eta, children: [
          AdminMenuItem(
            title: 'Add Car',
            route: AddCarPage.id,
            icon: Icons.add,
          ),
          AdminMenuItem(
            title: 'Car List',
            route: CarListPage.id,
            icon: Icons.list_rounded,
          ),
        ]),
        AdminMenuItem(
          title: 'Users',
          route: UserPage.id,
          icon: Icons.group,
        ),
        AdminMenuItem(title: 'Rides', icon: Icons.drive_eta, children: [
          AdminMenuItem(
            title: 'Rides In Progress',
            route: RidesInProgressPage.id,
            icon: Icons.loop_rounded,
          ),
          AdminMenuItem(
            title: 'Completed Rides',
            route: CompletedRidesPage.id,
            icon: Icons.check_circle_outlined,
          ),
          AdminMenuItem(
            title: 'Cancelled Rides',
            route: CancelledRidesPage.id,
            icon: Icons.cancel_outlined,
          ),
          AdminMenuItem(
            title: 'Scheduled Rides',
            route: ScheduledRidesPage.id,
            icon: Icons.schedule_rounded,
          ),
          AdminMenuItem(
            title: 'Rides History',
            route: RidesHistoryPage.id,
            icon: Icons.history_toggle_off,
          ),
          AdminMenuItem(
            title: 'Manual Booking History',
            route: ManualBookingHistoryPage.id,
            icon: Icons.history,
          ),
        ]),
        AdminMenuItem(
          title: 'Pricing',
          route: PricingPage.id,
          icon: Icons.payments,
        ),
      ],
      footer: Container(
          width: double.infinity,
          height: 100,
          color: yellow,
          child: Image.asset('assets/icons/logo.png',
          )),
      selectedRoute: selectedRoute,
      onSelected: (item) {
        Get.toNamed(item.route!);
      },
    );
  }
}