import 'package:equatable/equatable.dart';

class HomeStoreEntity extends Equatable {
  final int id;
  final String name;
  final String image;
  final String price;

  const HomeStoreEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  @override
  List<Object?> get props => [id, name, image, price];
}