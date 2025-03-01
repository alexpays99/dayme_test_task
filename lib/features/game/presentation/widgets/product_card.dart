import 'package:flutter/material.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final bool isSelected;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // const Spacer(),
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.network(
                  product.photoUrl,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),

              Text(
                product.name,
                style: AppTextStyles.mariupolBold14.copyWith(
                  color: AppColors.black,
                ),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              isSelected
                  ? GameImageAssets.activeLike.svg
                  : GameImageAssets.defaultLike.svg,
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
