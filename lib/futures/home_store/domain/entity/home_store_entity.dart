import 'package:equatable/equatable.dart';

class HomeStoreEntity extends Equatable {
  final int id;
  final String name;
  final String image;
  final String price;
  final num rate;
  final String category;
  final String description;

  const HomeStoreEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.rate,
    required this.description,
    required this.category,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    image,
    price,
    rate,
    description,
    category,
  ];
}
