import 'package:productsearch_magic/domain/models/product_model.dart';
import 'package:productsearch_magic/domain/providers/repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'productlist.g.dart';

@riverpod
class Productlist extends _$Productlist {
  int _currentPage = 1;
  List<ProductModel> ttl = [];

  @override
  Future<List<ProductModel>> build() async {
    return [];
  }

  Future<void> getProductList() async {
    if (_currentPage == 1) {
      state = const AsyncValue.loading();
    }

    try {
      Map<String, String> arg = {
        'limit': '10',
        'page': _currentPage.toString()
      };
      final res =
          await AsyncValue.guard(() => AppRepository().getItemList(arg));

      state = _currentPage == 1
          ? AsyncData(res.value ?? [])
          : AsyncData((state.value ?? []) + (res.value ?? []));
      setLocally();
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }

  void setLocally() {
    _currentPage++;
    ttl = state.value ?? [];
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      state = AsyncData(ttl);
    } else {
      var list = ttl
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      state = AsyncData(list);
    }
  }


  
}
