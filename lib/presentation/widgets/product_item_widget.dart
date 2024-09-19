import 'package:flutter/material.dart';
import 'package:productsearch_magic/domain/models/product_model.dart';
import 'package:productsearch_magic/utils/app_route.dart';
import 'package:productsearch_magic/utils/colors.dart';
import 'package:productsearch_magic/utils/text_styles.dart';

class ProductItemWidget extends StatelessWidget {
  final ProductModel item;
  const ProductItemWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.productDetail, arguments: item);
      },
      child: Card(
        elevation: 2,
        surfaceTintColor: AppColors.disabled,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: SizedBox(
                height: 110,
                child: Image.network(
                  'http://via.placeholder.com/350x200',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(item.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.subtitle1),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '\$${item.price}',
                style: AppTextStyles.bodyText1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
