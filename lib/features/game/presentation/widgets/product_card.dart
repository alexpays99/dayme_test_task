import 'package:flutter/material.dart';
import '../../../../core/constants/assets.dart';
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
      child: Card(
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(product.photoUrl),
                Positioned(
                  right: 8,
                  top: 8,
                  child: isSelected
                      ? GameImageAssets.activeLike.svg
                      : GameImageAssets.defaultLike.svg,
                ),
              ],
            ),
            Text(product.name),
          ],
        ),
      ),
    );
  }
}
