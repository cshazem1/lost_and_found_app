class HomeStoreRatingModel {
  HomeStoreRatingModel({
      this.rate, 
      this.count,});

  HomeStoreRatingModel.fromJson(dynamic json) {
    rate = json['rate'];
    count = json['count'];
  }
  double? rate;
  int? count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rate'] = rate;
    map['count'] = count;
    return map;
  }

}