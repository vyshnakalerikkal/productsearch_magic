import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:productsearch_magic/domain/models/product_model.dart';
import 'package:productsearch_magic/domain/providers/riverpod/favourites.dart';
import 'package:productsearch_magic/utils/colors.dart';
import 'package:productsearch_magic/utils/text_styles.dart';

class ProductDetailsScreen extends ConsumerWidget {
  final ProductModel product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(favouritesProvider).contains(product.id);

    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.network(
                    'http://via.placeholder.com/350x200',
                    fit: BoxFit.fitWidth,
                    width: double.maxFinite,
                  ),
                  Positioned(
                      bottom: 10,
                      right: 20,
                      child: FloatingActionButton(
                          backgroundColor: Colors.white,
                          onPressed: () {
                            ref
                                .read(favouritesProvider.notifier)
                                .toggleFavorite(product.id);
                          },
                          child: isFavorite
                              ? const Icon(Icons.favorite)
                              : const Icon(Icons.favorite_border_outlined)))
                ],
              ),
              Expanded(child: section()),
            ],
          ),
        ));
  }

  Widget section() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: AppTextStyles.headline1,
          ),
          const SizedBox(height: 16.0),
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In "
            "rutrum at ex non eleifend. Aenean sed eros a purus "
            "gravida scelerisque id in orci. Mauris elementum id "
            "nibh et dapibus. Maecenas lacinia volutpat magna",
            textAlign: TextAlign.justify,
            style: AppTextStyles.bodyText2.copyWith(color: AppColors.black),
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              const Text(
                'Price : ',
                style: AppTextStyles.subtitle1,
              ),
              Text(
                (product.price ?? 00.00).toStringAsFixed(2),
                style: AppTextStyles.headline2,
              )
            ],
          )
        ],
      ),
    );
  }
}
