import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:taxi_admin_panel/constant/api.dart';
import 'package:taxi_admin_panel/model/search_car_list_model.dart';
import 'package:taxi_admin_panel/model/search_driver_list_model.dart';
import 'package:taxi_admin_panel/model/search_vendor_list_model.dart';
import '../model/assigned_drivers_list_model.dart';
import '../model/cab_list_model.dart';
import '../model/car_approved_list_model.dart';
import '../model/car_list_model.dart';
import '../model/driver_approved_list_model.dart';
import '../model/driver_list_model.dart';
import '../model/manual_booking_history_model.dart';
import '../model/package_list_model.dart';
import '../model/profile_view_model.dart';
import '../model/registered_users_model.dart';
import '../model/sub_admin_list_model.dart';
import '../model/vendor_approved_list_model.dart';
import '../model/vendor_list_model.dart';
import 'package:universal_html/html.dart' as html;


class ApiService{

  var box = GetStorage();

  Future adminLogin(String email, password) async {
    var client = http.Client();
    var completeUrl = APIConstants.baseUrl + APIConstants.login;
    var uri = Uri.parse(completeUrl);
    final response = await client.post(uri,body: {
      'email' : email,
      'password' : password
    });
    if(response.statusCode == 200){
      debugPrint(response.body.toString());
      var convertedDataToJson = jsonDecode(response.body);
      return convertedDataToJson;
    }
  }

  Future<ProfileViewModel?> profileView() async {
    var client = http.Client();
    var adminLogin = box.read('adminLogin');
    var params = {'adminId' : '$adminLogin'};
    var completeUrl = APIConstants.baseUrl + APIConstants.profileView;
    var uri = Uri.parse(completeUrl);
    var newUri = uri.replace(queryParameters: params);
    final response = await client.get(newUri);
    if(response.statusCode == 200){
      var json = response.body;
      return profileViewModelFromJson(json);
    }
    return null;
  }

  Future subAdminAdd(String name, contact, email, password, designation) async {
    var client = http.Client();
    var completeUrl = APIConstants.baseUrl + APIConstants.subAdminAdd;
    var uri = Uri.parse(completeUrl);
    final response = await client.post(uri,body: {
      'name' : name,
      'contact' : contact,
      'email' : email,
      'password' : password,
      'designation' : designation
    });
    if(response.statusCode == 200){
      debugPrint(response.body.toString());
      var convertedDataFromJson = jsonDecode(response.body);
      return convertedDataFromJson;
    }
  }

  Future<SubAdminListModel?> subAdminList() async {
    var client = http.Client();
    var completeUrl = APIConstants.baseUrl + APIConstants.subAdminList;
    var uri = Uri.parse(completeUrl);
    final response = await client.get(uri);
    if(response.statusCode == 200){
      debugPrint(response.body.toString());
      var json = response.body;
      return subAdminListModelFromJson(json);
    }else{
      return null;
    }
  }

  Future<VendorListModel?> vendorList() async {
    var client = http.Client();
    var completeUrl = APIConstants.baseUrl + APIConstants.vendorList;
    var uri = Uri.parse(completeUrl);
    final response = await client.get(uri);
    if(response.statusCode == 200){
      debugPrint(response.body.toString());
      var json = response.body;
      return vendorListModelFromJson(json);
    }else{
      return null;
    }
  }

  Future<DriverListModel?> driverList() async {
    var client = http.Client();
    var completeUrl = APIConstants.baseUrl + APIConstants.driverList;
    var uri = Uri.parse(completeUrl);
    final response = await client.get(uri);
    if(response.statusCode == 200){
      debugPrint(response.body.toString());
      var json = response.body;
      return driverListModelFromJson(json);
    }else{
      return null;
    }
  }

  Future<CarListModel?> carList() async {
    var client = http.Client();
    var completeUrl = APIConstants.baseUrl + APIConstants.carList;
    var uri = Uri.parse(completeUrl);
    final response = await client.get(uri);
    if(response.statusCode == 200){
      debugPrint(response.body.toString());
      var json = response.body;
      return carListModelFromJson(json);
    }else{
      return null;
    }
  }

  Future vendorApproval(id) async {
    debugPrint('====API called====');
    var vendorId = id;
    var client = http.Client();
    var completeUrl = APIConstants.baseUrl + APIConstants.vendorApproval;
    var uri = Uri.parse(completeUrl);
    debugPrint('$uri');
    final response = await client
        .post(uri, body: {"vendorId": "$vendorId", "status": "confirmed"});
    var convertedDataToJson = jsonDecode(response.body);
    return convertedDataToJson;
  }

  Future vendorReject( id,String reason) async {
    debugPrint('====API called====');
    var vendorId = id;
    var client = http.Client();
    var completeUrl = APIConstants.baseUrl + APIConstants.vendorApproval;
    var uri = Uri.parse(completeUrl);
    debugPrint('$uri');
    final response = await client.post(uri, body: {
      "vendorId": "$vendorId",
      "status": "rejected",
      "reason": reason
    });
    var convertedDataToJson = jsonDecode(response.body);
    return convertedDataToJson;
  }

  Future driverApproval(id) async {
    debugPrint('====API called====');
    var driverId = id;
    var client = http.Client();
    var completeUrl = APIConstants.baseUrl + APIConstants.driverApproval;
    var uri = Uri.parse(completeUrl);
    debugPrint('$uri');
    final response = await client
        .post(uri, body: {"driverId": "$driverId", "status": "confirmed"});
    var convertedDataToJson = jsonDecode(response.body);
    return convertedDataToJson;
  }

  Future driverReject(id, String reason) async {
    debugPrint('====API called====');
    var driverId = id;
    var client = http.Client();
    var completeUrl = APIConstants.baseUrl + APIConstants.driverApproval;
    var uri = Uri.parse(completeUrl);
    debugPrint('$uri');
    final response = await client.post(uri, body: {
      "driverId": "$driverId",
      "status": "rejected",
      "reason": reason
    });
    var convertedDataToJson = jsonDecode(response.body);
    return convertedDataToJson;
  }

  Future carApproval(id) async {
    debugPrint('====API called====');
    var carId = id;
    var client = http.Client();
    var completeUrl = APIConstants.baseUrl + APIConstants.carApproval;
    var uri = Uri.parse(completeUrl);
    debugPrint('$uri');
    final response = await client
        .post(uri, body: {"carId": "$carId", "status": "confirmed"});
    var convertedDataToJson = jsonDecode(response.body);
    return convertedDataToJson;
  }

  Future carReject(id, String reason) async {
    debugPrint('====API called====');
    var carId = id;
    var client = http.Client();
    var completeUrl = APIConstants.baseUrl + APIConstants.carApproval;
    var uri = Uri.parse(completeUrl);
    debugPrint('$uri');
    final response = await client.post(uri, body: {
      "carId": "$carId",
      "status": "rejected",
      "reason": reason
    });
    var convertedDataToJson = jsonDecode(response.body);
    return convertedDataToJson;
  }

  Future<VendorApprovedList?> vendorApprovedList() async {
    var client = http.Client();
    var completeUrl = APIConstants.baseUrl + APIConstants.vendorApprovedList;
    var uri = Uri.parse(completeUrl);
    final response = await client.get(uri);
    if(response.statusCode == 200){
      debugPrint(response.body.toString());
      var json = response.body;
      return vendorApprovedListFromJson(json);
    }else{
      return null;
    }
  }

  Future<DriverApprovedList?> driverApprovedList() async {
    var client = http.Client();
    var completeUrl = APIConstants.baseUrl + APIConstants.driverApprovedList;
    var uri = Uri.parse(completeUrl);
    final response = await client.get(uri);
    if(response.statusCode == 200){
      debugPrint(response.body.toString());
      var json = response.body;
      return driverApprovedListFromJson(json);
    }else{
      return null;
    }
  }

  Future<CarApprovedList?> carApprovedList() async {
    var client = http.Client();
    var completeUrl = APIConstants.baseUrl + APIConstants.carApprovedList;
    var uri = Uri.parse(completeUrl);
    final response = await client.get(uri);
    if(response.statusCode == 200){
      debugPrint(response.body.toString());
      var json = response.body;
      return carApprovedListFromJson(json);
    }else{
      return null;
    }
  }

  Future<SearchVendorListModel?> searchVendorList(String searchValue) async{
    var client = http.Client();
    var params = {'search':searchValue};
    var completeUrl = APIConstants.baseUrl + APIConstants.searchVendorList;
    var uri = Uri.parse(completeUrl);
    var finalUrl = uri.replace(queryParameters: params);
    final response = await client.get(finalUrl);
    if(response.statusCode == 200){
      debugPrint(response.body.toString());
      var json = response.body;
      return searchVendorListModelFromJson(json);
    } else{
      return null;
    }
  }

  Future<SearchDriverListModel?> searchDriverList(String searchValue) async{
    var client = http.Client();
    var params = {'search':searchValue};
    var completeUrl = APIConstants.baseUrl + APIConstants.searchDriverList;
    var uri = Uri.parse(completeUrl);
    var finalUrl = uri.replace(queryParameters: params);
    final response = await client.get(finalUrl);
    if(response.statusCode == 200){
      debugPrint(response.body.toString());
      var json = response.body;
      return searchDriverListModelFromJson(json);
    } else{
      return null;
    }
  }

  Future<SearchCarListModel?> searchCarList(String searchValue) async{
    var client = http.Client();
    var params = {'search':searchValue};
    var completeUrl = APIConstants.baseUrl + APIConstants.searchCarList;
    var uri = Uri.parse(completeUrl);
    var finalUrl = uri.replace(queryParameters: params);
    final response = await client.get(finalUrl);
    if(response.statusCode == 200){
      debugPrint(response.body.toString());
      var json = response.body;
      return searchCarListModelFromJson(json);
    } else{
      return null;
    }
  }

  Future approvedVendorDownload(String fromDate, toDate) async {
    var client = http.Client();
    var params = {'date1': fromDate, 'date2': toDate};
    var completeUrl = APIConstants.baseUrl + APIConstants.vendorExport;
    var uri = Uri.parse(completeUrl);
    var newUri = uri.replace(queryParameters: params);
    final response = await client.get(newUri);
    debugPrint('=====new uri = $newUri ========');
    debugPrint(response.body);
    debugPrint('StatusCode: ${response.statusCode}');
    if (response.statusCode == 200) {
      debugPrint(response.body.toString());
      var convertedDataToJson = json.decode(response.body);
      vendorDownloadFile(convertedDataToJson['body']['fileDataVendor']);
      return convertedDataToJson;
    }
  }

  Future<void> vendorDownloadFile(data) async {
    debugPrint('data////////');
    debugPrint(data);
    final anchor =
    html.AnchorElement(href: 'data:application/octet-stream;base64,$data')
      ..target = 'blank';
    // add the name
    anchor.download = 'Vendor List.xlsx';
    // trigger download
    html.document.body!.append(anchor);
    anchor.click();
    anchor.remove();
  }

  Future approvedDriverDownload(String fromDate, toDate) async {
    var client = http.Client();
    var params = {'date1': fromDate, 'date2': toDate};
    var completeUrl = APIConstants.baseUrl + APIConstants.driverExport;
    var uri = Uri.parse(completeUrl);
    var newUri = uri.replace(queryParameters: params);
    final response = await client.get(newUri);
    debugPrint(response.body);
    debugPrint('StatusCode: ${response.statusCode}');
    if (response.statusCode == 200) {
      debugPrint(response.body.toString());
      var convertedDataToJson = json.decode(response.body);
      driverDownloadFile(convertedDataToJson['body']['fileDataDriver']);
      return convertedDataToJson;
    }
  }

  Future<void> driverDownloadFile(data) async {
    debugPrint('data////////');
    debugPrint(data);
    final anchor =
    html.AnchorElement(href: 'data:application/octet-stream;base64,$data')
      ..target = 'blank';
    // add the name
    anchor.download = 'Driver List.xlsx';
    // trigger download
    html.document.body!.append(anchor);
    anchor.click();
    anchor.remove();
  }

  Future approvedCarDownload(String fromDate, toDate) async {
    var client = http.Client();
    var params = {'date1': fromDate, 'date2': toDate};
    var completeUrl = APIConstants.baseUrl + APIConstants.carExport;
    var uri = Uri.parse(completeUrl);
    var newUri = uri.replace(queryParameters: params);
    final response = await client.get(newUri);
    debugPrint(response.body);
    debugPrint('StatusCode: ${response.statusCode}');
    if (response.statusCode == 200) {
      debugPrint(response.body.toString());
      var convertedDataToJson = json.decode(response.body);
      driverDownloadFile(convertedDataToJson['body']['fileDataCar']);
      return convertedDataToJson;
    }
  }

  Future<void> carDownloadFile(data) async {
    debugPrint('data////////');
    debugPrint(data);
    final anchor =
    html.AnchorElement(href: 'data:application/octet-stream;base64,$data')
      ..target = 'blank';
    // add the name
    anchor.download = 'Car List.xlsx';
    // trigger download
    html.document.body!.append(anchor);
    anchor.click();
    anchor.remove();
  }

  Future<ManualBookingHistoryModel?> manualBookingHistory() async {
    var client = http.Client();
    var completeUrl = APIConstants.baseUrl + APIConstants.manualBookingHistory;
    var uri = Uri.parse(completeUrl);
    final response = await client.get(uri);
    if(response.statusCode == 200){
      debugPrint(response.body.toString());
      var json = response.body;
      return manualBookingHistoryModelFromJson(json);
    } else{
      return null;
    }
  }

  Future packageAdd(String packageName) async {
    var client = http.Client();
    var completeUrl = APIConstants.baseUrl + APIConstants.packageAdd;
    var uri = Uri.parse(completeUrl);
    final response = await client.post(uri, body: {
      'packageName' : packageName
    });
    if(response.statusCode == 200){
      debugPrint(response.statusCode.toString());
      var convertedDataFromJson = jsonDecode(response.body);
      return convertedDataFromJson;
    }
  }

  Future<PackageListModel?> packageList() async {
    var client = http.Client();
    var completeUrl = APIConstants.baseUrl + APIConstants.packageList;
    var uri = Uri.parse(completeUrl);
    final response = await client.get(uri);
    if(response.statusCode == 200){
      debugPrint(response.body.toString());
      var json = response.body;
      return packageListModelFromJson(json);
    } else{
      return null;
    }
  }

  Future cabAdd(String cabName) async {
    var client = http.Client();
    var completeUrl = APIConstants.baseUrl + APIConstants.cabAdd;
    var uri = Uri.parse(completeUrl);
    final response = await client.post(uri, body: {
      'cabName' : cabName
    });
    if(response.statusCode == 200){
      debugPrint(response.statusCode.toString());
      var convertedDataFromJson = jsonDecode(response.body);
      return convertedDataFromJson;
    }
  }

  Future<CabListModel?> cabList() async {
    var client = http.Client();
    var completeUrl = APIConstants.baseUrl + APIConstants.cabList;
    var uri = Uri.parse(completeUrl);
    final response = await client.get(uri);
    if(response.statusCode == 200){
      debugPrint(response.body.toString());
      var json = response.body;
      return cabListModelFromJson(json);
    } else{
      return null;
    }
  }

  Future<RegisteredUsersListModel?> registeredUsersList() async {
    var client = http.Client();
    var completeUrl = APIConstants.baseUrl + APIConstants.registeredUsersList;
    var uri = Uri.parse(completeUrl);
    final response = await client.get(uri);
    if(response.statusCode == 200){
      debugPrint(response.body.toString());
      var json = response.body;
      return registeredUsersListModelFromJson(json);
    } else{
      return null;
    }
  }

  Future<AssignedDriversListModel?> assignedDriversList() async {
    var client = http.Client();
    var completeUrl = APIConstants.baseUrl + APIConstants.assignedDriversList;
    var uri = Uri.parse(completeUrl);
    final response = await client.get(uri);
    if(response.statusCode == 200){
      debugPrint(response.body.toString());
      var json = response.body;
      return assignedDriversListModelFromJson(json);
    } else{
      return null;
    }
  }
}