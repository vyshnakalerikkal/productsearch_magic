import 'package:flutter_test/flutter_test.dart';
import 'package:productsearch_magic/domain/providers/riverpod/favourites.dart';

void main() {
  test('FavoritesNotifier toggles favorite status correctly', () {
    final favoritesNotifier = Favourites();

    favoritesNotifier.toggleFavorite('1');
    expect(favoritesNotifier.state.contains('1'), true);

    favoritesNotifier.toggleFavorite('1');
    expect(favoritesNotifier.state.contains('1'), false);
  });
}
