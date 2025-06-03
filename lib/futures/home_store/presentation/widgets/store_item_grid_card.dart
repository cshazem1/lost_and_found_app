import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lost_and_found_app/core/theme/app_colors.dart';
import 'package:lost_and_found_app/core/theme/text_style.dart';

class StoreItemGridCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String description;
  final double price;
  final double rate;

  const StoreItemGridCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.price,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(8.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(),
            SizedBox(height: 8.h),
            Text(
              name,
              style: AppTextStyles.bodyLarge,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 6.h),
            Text(
              description,
              style: AppTextStyles.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 6.h),
            Text(
              '\$${price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 6.h),
            _buildRatingRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: Image.network(
        imageUrl,
        height: 140.h,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildRatingRow() {
    return Row(
      children: [
        const Icon(Icons.star, color: AppColors.amber, size: 18),
        SizedBox(width: 4.w),
        Text(rate.toStringAsFixed(1), style: AppTextStyles.bodySmall),
      ],
    );
  }
}
