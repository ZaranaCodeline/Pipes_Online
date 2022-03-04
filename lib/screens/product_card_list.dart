import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../custom_widget/custom_home_page_widget/custom_product_card.dart';

class ProductCardList extends StatelessWidget {
  ProductCardList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: GridView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: 6,
            scrollDirection: Axis.vertical,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 3/4,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                child: CustomProductCard(
                  img: Image.asset('assets/images/pro_1.png'),
                  title: 'ABS',
                  desc: 'ABC Pipe',
                  price: '\$10/ Feet',
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
