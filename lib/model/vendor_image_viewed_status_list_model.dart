List<VendorImageViewedStatusListModel>? vendorImageViewedStatusListModelArray;

class VendorImageViewedStatusListModel {
  VendorImageViewedStatusListModel({
    this.ownerAadharFront,
    this.ownerAadharBack,
    this.panCard,
    this.passbook,
    this.rentalAgreement1,
    this.rentalAgreement2,
  });
  bool? ownerAadharFront;
  bool? ownerAadharBack;
  bool? panCard;
  bool? passbook;
  bool? rentalAgreement1;
  bool? rentalAgreement2;
}