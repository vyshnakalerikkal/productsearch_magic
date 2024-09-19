import 'package:productsearch_magic/domain/models/product_model.dart';
import 'package:productsearch_magic/data/api_service.dart';

abstract class UseCases {
  Future<List<ProductModel>> getItemList(Map<String, dynamic> params);
}

class AppRepository implements UseCases {
  final provider = ApiService();

  @override
  Future<List<ProductModel>> getItemList(Map<String, dynamic> params) async {
    final res = await provider.getData('/api/productlist', params: params);
    List<ProductModel> data = [];
    if (res != null) {
      data = res
          .map((e) => ProductModel.fromJson(e))
          .toList()
          .cast<ProductModel>();
    }
    return data;
  }
}
