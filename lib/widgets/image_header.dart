import 'package:flutter/material.dart';

class FixedHeader extends SliverPersistentHeaderDelegate {

  final double height;

  FixedHeader(this.height);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(height: height, color: Colors.white);
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

}

class HeaderWithImage extends SliverPersistentHeaderDelegate {

  final String imageUrl;
  final String heroImage;
  final String heroTag;
  final double maxHeight;
  final double minHeight;
  final Widget actionPanel;
  final Widget embossedPanel;
  final double embossPanelOffset;

  HeaderWithImage({
    @required this.maxHeight,
    @required this.actionPanel,
    this.minHeight = 80,
    this.heroImage,
    this.imageUrl,
    this.heroTag,
    this.embossedPanel,
    this.embossPanelOffset = -16
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        _renderImage(),
        if (actionPanel != null) Positioned(
          top: 0,
          child: actionPanel
        ),
        if (embossedPanel != null) Positioned(
            bottom: embossPanelOffset,
            child: embossedPanel
          )
      ],
    );
  }

  Widget _renderImage() {
    if (imageUrl != null) {
      return Image.network(imageUrl, fit: BoxFit.cover);
    } else {
      return Hero(
        tag: heroTag,
        child: Image.network(heroImage, fit: BoxFit.cover)
      );
    }
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

}