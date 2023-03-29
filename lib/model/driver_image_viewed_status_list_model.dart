List<DriverImageViewedStatusListModel>? driverImageViewedStatusListModelArray;

class DriverImageViewedStatusListModel {
  DriverImageViewedStatusListModel({
    this.profilePic,
    this.aadharFront,
    this.aadharBack,
    this.licenseFront,
    this.licenseBack,
  });

  bool? profilePic;
  bool? aadharFront;
  bool? aadharBack;
  bool? licenseFront;
  bool? licenseBack;
}
