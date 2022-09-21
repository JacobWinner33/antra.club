import 'package:antra/utilities/nft_card.dart';
import 'package:flutter/material.dart';

class RaveTab extends StatelessWidget {
  const RaveTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const NftCard(
      imagePath: 'assets/images/rave.jpg',
    );
  }
}
