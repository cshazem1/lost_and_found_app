import 'package:flutter/material.dart';
import '../../domain/entity/home_store_entity.dart';
import 'store_item_grid_card.dart';

class StoreItemsGrid extends StatelessWidget {
  final List<HomeStoreEntity> items;

  const StoreItemsGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.55,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        int maxDelay = 800;
        int delay = (index * 200).clamp(0, maxDelay);

        int columnIndex = index % 2;
        // X offset: -0.7 (يسار) للعمود الأول، +0.7 (يمين) للعمود الثاني
        // Y offset: +0.8 (أسفل)
        Offset beginOffset =
            columnIndex == 0 ? Offset(-0.7, 0.8) : Offset(0.7, 0.8);

        return TweenAnimationBuilder<Offset>(
          key: ValueKey(item.name),
          tween: Tween<Offset>(begin: beginOffset, end: Offset.zero),
          duration: Duration(milliseconds: 400),
          curve: Curves.easeOut,
          builder: (context, offset, child) {
            // نحسب إزاحة X و Y منفصلة
            final dx = offset.dx * 70; // تحريك أفقي: 70 بكسل
            final dy =
                offset.dy *
                -50; // تحريك رأسي: 50 بكسل لأعلى (لأن y موجب يعني أسفل، نضرب بـ -1)

            // الشفافية تعتمد على أكبر قيمة بين dx, dy عشان العنصر يبدأ شفاف ويزداد وضوحاً أثناء الحركة
            final opacity =
                1 -
                (offset.dx.abs() > offset.dy.abs()
                    ? offset.dx.abs()
                    : offset.dy.abs());

            return Transform.translate(
              offset: Offset(dx, dy),
              child: Opacity(opacity: opacity.clamp(0.0, 1.0), child: child),
            );
          },
          child: StoreItemGridCard(
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
