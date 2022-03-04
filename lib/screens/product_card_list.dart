import 'package:flutter/material.dart';

import '../custom_widget/widgets/custom_widget/custom_product_card.dart';

class ProductCardList extends StatelessWidget {
  ProductCardList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 400,

        child: GridView.builder(
          itemCount: 6,
          scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 20,
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
    );
  }
}
