import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';

class CustomCarouselSliderWidget extends StatelessWidget {
  CustomCarouselSliderWidget({
    Key? key,
    required this.image,
  }) : super(key: key);
  String image;

  @override
  Widget build(BuildContext context) {
    final List<String> imageList = [
      'https://firebasestorage.googleapis.com/v0/b/pipesonline-b2a41.appspot.com/o/cart_page.png?alt=media&token=6a4d6e9a-51b3-449a-a2bd-eb54dcec0803',
      'https://firebasestorage.googleapis.com/v0/b/pipesonline-b2a41.appspot.com/o/cart_page.png?alt=media&token=6a4d6e9a-51b3-449a-a2bd-eb54dcec0803',
    ];

    return Container(
        child: Column(
      children: [
        CarouselSlider(
          items: imageList
              .map(
                (e) => Container(
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              )
              .toList(),
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
            viewportFraction: 1,
          ),
        ),
      ],
    ));
  }
}
