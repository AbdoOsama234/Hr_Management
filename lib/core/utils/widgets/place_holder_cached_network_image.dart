import 'package:flutter/material.dart';

class PlaceHolderCachedNetworkImage extends StatelessWidget {
  const PlaceHolderCachedNetworkImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
