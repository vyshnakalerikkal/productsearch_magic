import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'favourites.g.dart';

@riverpod
class Favourites extends _$Favourites {
  @override
  Set<String> build() {
    return {};
  }

  void toggleFavorite(String productId) {
    if (state.contains(productId)) {
      state = {...state}..remove(productId);
    } else {
      state = {...state}..add(productId);
    }
  }
}
