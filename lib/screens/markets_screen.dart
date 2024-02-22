import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nfstock_test/common/constants.dart';
import 'package:nfstock_test/common/strings.dart';
import 'package:nfstock_test/models/asset.dart';
import 'package:nfstock_test/services/assets_service.dart';
import 'package:nfstock_test/widgets/asset_view.dart';

class MarketsScreen extends StatefulWidget {
  const MarketsScreen({super.key});

  @override
  State<MarketsScreen> createState() => _MarketsScreenState();
}

class _MarketsScreenState extends State<MarketsScreen> {
  String selectedButton = "all";
  final allAssets = AssetsService().getAssets();
  List<Asset> filteredAssets = [];
  List favAssetIds = AssetsService.favoriteAssetIds;

  List<Asset> get favoriteAssets => allAssets.where((element) => favAssetIds.contains(element.id)).toList();

  Color getButtonColor(String type) => selectedButton == type ? Constants.primaryColor : Colors.white54;

  onSearch(String value) {
    final query = value.toLowerCase();
    setState(() {
      filteredAssets = value.isEmpty
          ? selectedButton == 'all'
              ? allAssets
              : favoriteAssets
          : (selectedButton == 'all' ? allAssets : favoriteAssets)
              .where(
                  (element) => element.tag.toLowerCase().contains(query) || element.name.toLowerCase().contains(query))
              .toList();
    });
  }

  fetchFavorites() async {
    await AssetsService().initFavorites();
    setState(() {
      favAssetIds = AssetsService.favoriteAssetIds;
    });
  }

  @override
  void initState() {
    super.initState();
    filteredAssets = allAssets;
    fetchFavorites();
  }

  @override
  Widget build(BuildContext context) {
    final allBtnColor = getButtonColor('all');
    final favBtnColor = getButtonColor('fav');

    return Scaffold(
      backgroundColor: Constants.primaryColor,
      appBar: AppBar(centerTitle: true, title: const Text(Strings.markets)),
      body: Column(children: [
        Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: CupertinoSearchTextField(
              placeholder: Strings.searchBarHintText,
              placeholderStyle: const TextStyle(fontSize: 14, color: CupertinoColors.inactiveGray),
              backgroundColor: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              onChanged: onSearch,
            )),
        SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    border: Border.fromBorderSide(BorderSide(color: Colors.white))),
                child: CupertinoSlidingSegmentedControl(
                  children: {
                    "all": Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: Row(children: [
                          Icon(Icons.trending_up, color: allBtnColor),
                          const SizedBox(width: 8),
                          Text(Strings.all, style: TextStyle(color: allBtnColor))
                        ])),
                    "fav": Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: Row(children: [
                          Icon(Icons.star_border_outlined, color: favBtnColor),
                          const SizedBox(width: 8),
                          Text(Strings.favorites, style: TextStyle(color: favBtnColor))
                        ]))
                  },
                  groupValue: selectedButton,
                  onValueChanged: (String? key) {
                    setState(() {
                      selectedButton = key!;
                      filteredAssets = key == "all" ? allAssets : favoriteAssets;
                    });
                  },
                  backgroundColor: Colors.transparent,
                  thumbColor: Colors.white,
                  padding: EdgeInsets.zero,
                  // borderColor: Colors.white,
                ),
              ),
            ),
            Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
                margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
                padding: const EdgeInsets.only(top: 16, left: 20, right: 8),
                child: Column(
                    children: filteredAssets.map((e) {
                  final isFavorite = favAssetIds.contains(e.id);
                  return AssetView(
                      asset: e,
                      isFavorite: isFavorite,
                      onFavorite: () {
                        isFavorite ? AssetsService().removeFavorite(e.id) : AssetsService().markAsFavorite(e.id);
                        setState(() {
                          favAssetIds = AssetsService.favoriteAssetIds;
                          if (selectedButton == 'fav') {
                            filteredAssets = favoriteAssets;
                          }
                        });
                      });
                }).toList()))
          ],
        ))
      ]),
    );
  }
}
