import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nfstock_test/services/currency_service.dart';

class AssetView extends StatelessWidget {
  final Asset asset;
  final bool isFavorite;
  final Function onFavorite;
  const AssetView({super.key, required this.asset, this.isFavorite = false, required this.onFavorite});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: [
          Row(children: [
            SvgPicture.asset('assets/icons/${asset.iconName}.svg', width: 40),
            const SizedBox(width: 16),
            Expanded(child: Text(asset.tag, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500))),
            Column(
              children: [
                Text(asset.price.toString(), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500))
              ],
            ),
            IconButton(
                onPressed: () => onFavorite.call(),
                icon: Icon(isFavorite ? Icons.star : Icons.star_border_outlined, color: Colors.grey.shade400))
          ]),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              height: 1,
              color: Colors.grey.shade200,
            ),
          )
        ],
      ),
    );
  }
}
