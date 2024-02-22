import 'package:nfstock_test/common/constants.dart';
import 'package:nfstock_test/models/asset.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssetsService {
  static List<int> favoriteAssetIds = [];

  initFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    favoriteAssetIds = prefs.getStringList(Constants.favoritesStorageKey)?.map((e) => int.parse(e)).toList() ?? [];
  }

  List<Asset> getAssets() => [
        Asset(id: 0, tag: 'USDT', name: 'Tether', iconName: 'tether', price: 0.92761),
        Asset(id: 1, tag: 'BTC', name: 'Bitcoin', iconName: 'bitcoin', price: 27448.70),
        Asset(id: 2, tag: 'ETH', name: 'Ethereum', iconName: 'ethereum', price: 1448.50),
        Asset(id: 3, tag: 'GSPC', name: 'S&P500', iconName: 'sp1', price: 125.4),
        Asset(id: 4, tag: 'AAPL', name: 'Apple', iconName: 'apple14', price: 1021.40)
      ];

  markAsFavorite(int assetId) {
    favoriteAssetIds.add(assetId);
    updateFavoritesStorage();
  }

  removeFavorite(int assetId) {
    favoriteAssetIds.removeWhere((element) => element == assetId);
    updateFavoritesStorage();
  }

  updateFavoritesStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(Constants.favoritesStorageKey, favoriteAssetIds.map((e) => e.toString()).toList());
  }
}
