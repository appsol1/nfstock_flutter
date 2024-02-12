import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nfstock_test/main.dart';
import 'package:nfstock_test/services/assets_service.dart';

void main() {
  test('Can add/remove favorites', () async {
    final assetService = AssetsService();

    expect(AssetsService.favoriteAssetIds.isEmpty, isTrue);

    assetService.markAsFavorite(123);
    expect(AssetsService.favoriteAssetIds.length, 1);

    assetService.removeFavorite(123);
    expect(AssetsService.favoriteAssetIds.contains(123), isFalse);
  });
}
