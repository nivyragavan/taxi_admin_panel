
import 'package:get/get.dart';
import 'package:taxi_admin_panel/model/search_vendor_list_model.dart';
import 'package:taxi_admin_panel/service/api_service.dart';

class SearchVendorListController extends GetxController {
  SearchVendorListModel? searchValueInfo;
  var searchResult = <Datum>[].obs;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  var searchKey = "".obs;
  void hitSearch(val) {
    searchKey.value = val;
    debounce(searchKey, (_) => getData(searchValue: val),
        time: const Duration(milliseconds: 800));
  }

  void getData({searchValue = ""}) async {
    print('searchValue.......................');
    print(searchValue);
    searchValueInfo = await ApiService().searchVendorList(searchValue);
    if (searchValueInfo != null) {
      searchResult.value = searchValueInfo!.body!.data!;
      print('update');
      update();
    }
  }
}
