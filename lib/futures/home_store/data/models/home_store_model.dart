import '../../domain/entity/home_store_entity.dart';
import 'home_store_rating_model.dart';

class HomeStoreModel {
  HomeStoreModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  HomeStoreModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    category = json['category'];
    image = json['image'];
    rating =
        json['rating'] != null
            ? HomeStoreRatingModel.fromJson(json['rating'])
            : null;
  }
  int? id;
  String? title;
  num? price;
  String? description;
  String? category;
  String? image;
  HomeStoreRatingModel? rating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['price'] = price;
    map['description'] = description;
    map['category'] = category;
    map['image'] = image;
    if (rating != null) {
      map['rating'] = rating?.toJson();
    }
    return map;
  }

  HomeStoreEntity toEntity() {
    return HomeStoreEntity(
      id: id ?? 0,
      price: price?.toString() ?? "0",
      image: image ?? "",
      name: title ?? "",
      category: category ?? "",

      rate: rating?.rate ?? 0,
      description: description ?? "",
    );
  }
}
