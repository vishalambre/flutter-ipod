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
      padding: const EdgeInsets.all(8),
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.003)
          ..scale((1 - relativePosition.abs()).clamp(0.2, 0.6) + 0.4)
          ..rotateZ(relativePosition),
        alignment:
            relativePosition < 0 ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.accents[index],
            ),
            child: Image.network(
              imageArray[index],
              fit: BoxFit.cover,
            )),
      ),
    );
  }
}
