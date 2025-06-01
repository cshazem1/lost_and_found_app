import 'package:flutter/material.dart';
import '../../domain/entity/home_store_entity.dart';
import 'store_item_card.dart';

class StoreItemsList extends StatelessWidget {
  final List<HomeStoreEntity> items;

  const StoreItemsList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        Offset beginOffset = Offset(1, 0.3);
        return TweenAnimationBuilder<Offset>(
          key: ValueKey(item.name),
          tween: Tween<Offset>(begin: beginOffset, end: Offset.zero),
          duration: Duration(milliseconds: 400),
          curve: Curves.easeOut,
          builder: (context, offset, child) {
            return Transform.translate(
              offset: Offset(offset.dx * 70, offset.dy * -50),

              child: Opacity(
                opacity:
                    1 -
                    (offset.dx.abs() > offset.dy.abs()
                        ? offset.dx.abs()
                        : offset.dy.abs()),
                child: child,
              ),
            );
          },
          child: StoreItemCard(
            imageUrl: item.image,
            name: item.name,
            description: item.description,
            price: double.tryParse(item.price) ?? 0.0,
            rate: double.tryParse(item.rate.toString()) ?? 0.0,
          ),
        );
      },
    );
  }
}
