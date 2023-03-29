List<CarImageViewedStatusListModel>? carImageViewedStatusListModelArray;

class CarImageViewedStatusListModel {
  CarImageViewedStatusListModel({
    this.frontImage,
    this.chaseImage,
    this.rcFront,
    this.rcBack,
    this.insurance,
    this.fc,
  });

  bool? frontImage;
  bool? chaseImage;
  bool? rcFront;
  bool? rcBack;
  bool? insurance;
  bool? fc;
}