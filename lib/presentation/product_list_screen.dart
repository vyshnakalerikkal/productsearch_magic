import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:productsearch_magic/domain/providers/riverpod/favourites.dart';
import 'package:productsearch_magic/domain/providers/riverpod/productlist.dart';
import 'package:productsearch_magic/utils/colors.dart';
import 'package:productsearch_magic/utils/images.dart';
import 'package:productsearch_magic/domain/models/product_model.dart';
import 'package:productsearch_magic/presentation/widgets/product_item_widget.dart';
import 'package:productsearch_magic/utils/text_styles.dart';

class ProductListScreen extends ConsumerStatefulWidget {
  const ProductListScreen({super.key});

  @override
  ConsumerState<ProductListScreen> createState() => ProductListScreenState();
}

class ProductListScreenState extends ConsumerState<ProductListScreen> {
  final ScrollController _scrollController = ScrollController();
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(productlistProvider.notifier).getProductList();
    });
    // Listen to scroll events for infinite scrolling
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        ref.read(productlistProvider.notifier).getProductList();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productListAsyncValue = ref.watch(productlistProvider);
    ref.watch(favouritesProvider);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUserWidget(),
              const SizedBox(height: 16),
              _buildSearchBar(),
              const SizedBox(height: 16),
              Expanded(
                child: productListAsyncValue.when(
                  data: (products) {
                    return _buildProductList(products);
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stack) =>
                      Center(child: Text('Error: ${error.toString()}')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserWidget() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: AssetImage(AppImages.imgUser),
        ),
        Text(
          'Hey Vyshna!',
          style: AppTextStyles.headline1,
        ),
        Text(
          'Lets order some food and have a delicious day',
          style: AppTextStyles.caption,
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Search for products...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        filled: true,
        fillColor: AppColors.white,
      ),
      onChanged: (query) {
        ref.read(productlistProvider.notifier).searchProducts(query);
      },
    );
  }

  Widget _buildProductList(List<ProductModel> products) {
    return products.isEmpty
        ? const Center(child: Text('No products found'))
        : GridView.builder(
            controller: _scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductItemWidget(
                item: products[index],
              );
            },
          );
  }
}
