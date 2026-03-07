import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/constants/app_constants.dart';
import 'package:movies/core/utils/extensions/context_extension.dart';

class CustomCarouselSlider extends StatelessWidget {
  const CustomCarouselSlider({
    super.key,
    required this.length,
    required this.itemBuilder,
  });
  final Widget Function(BuildContext, int, int)? itemBuilder;
  final int length;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: AppConstants.avatars.length,
      itemBuilder: itemBuilder,
      options: CarouselOptions(
        enableInfiniteScroll: false,
        autoPlay: false,
        disableCenter: true,
        enlargeCenterPage: true,
        height: context.height * .17,
        enlargeFactor: .6,
        aspectRatio: 2,
        viewportFraction: 0.36,
        initialPage: 6,
      ),
    );
  }
}
