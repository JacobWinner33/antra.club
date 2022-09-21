import 'package:antra/utilities/nft_card.dart';
import 'package:flutter/material.dart';

class TrendingTab extends StatelessWidget {
  const TrendingTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Nothing yet');
      },
      child: const NftCard(
        imagePath: 'assets/images/trending.jpg',
      ),
    );
  }
}
