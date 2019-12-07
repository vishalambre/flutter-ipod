import 'package:flutter/material.dart';
import 'package:flutter_ipod/main.dart';

class AlbumCard extends StatelessWidget {
  final double currentPage;
  final int index;
  double relativePosition;
  AlbumCard(this.currentPage, this.index) {
    relativePosition = this.index - this.currentPage;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
          height: 200,
          width: 200,
          color: Colors.accents[index],
          child: Image.network(
            imageArray[index],
            fit: BoxFit.cover,
          )),
    );
  }
}
