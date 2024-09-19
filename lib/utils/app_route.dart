import 'package:flutter/material.dart';
import 'package:productsearch_magic/domain/models/product_model.dart';
import 'package:productsearch_magic/presentation/product_detail_screen.dart';
import 'package:productsearch_magic/presentation/product_list_screen.dart';

class AppRoutes {
  static const appInit = '/appinit';
  static const productDetail = '/Productdetailsscreen';
}

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.appInit:
      return MaterialPageRoute(
        builder: (context) => const ProductListScreen(),
      );

    case AppRoutes.productDetail:
      return MaterialPageRoute(
        builder: (context) =>
            ProductDetailsScreen(product: settings.arguments as ProductModel),
      );

    default:
      return MaterialPageRoute(
        builder: (context) => const ProductListScreen(),
      );
  }
}
