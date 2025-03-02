import 'package:cached_network_image/cached_network_image.dart';
import 'package:dayme_test_task/features/game/data/models/product.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/theme/app_theme.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isSelected;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.25),
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: product.photoUrl,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
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
        ),
      ),
    );
  }
}
