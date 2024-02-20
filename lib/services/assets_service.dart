import 'package:nfstock_test/models/asset.dart';

class AssetsService {
  List<Asset> getAssets() => [
        Asset(id: 0, tag: 'USDT', name: 'Tether', iconName: 'tether', price: 0.92761),
        Asset(id: 1, tag: 'BTC', name: 'Bitcoin', iconName: 'bitcoin', price: 27448.70),
        Asset(id: 2, tag: 'ETH', name: 'Ethereum', iconName: 'ethereum', price: 1448.50),
        Asset(id: 3, tag: 'GSPC', name: 'S&P500', iconName: 'sp1', price: 125.4),
        Asset(id: 4, tag: 'AAPL', name: 'Apple', iconName: 'apple14', price: 1021.40)
      ];

  static List<int> favoriteAssetIds = [];

  markAsFavorite(int assetId) {
    favoriteAssetIds.add(assetId);
  }

  removeFavorite(int assetId) {
    favoriteAssetIds.removeWhere((element) => element == assetId);
  }
}
