import 'package:flutter/material.dart';
import '../custom_widget/widgets/custom_widget/common_category_card.dart';

class CategoriesCardList extends StatelessWidget {
  const CategoriesCardList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          CommonCategoryCard(
            image: Image.asset('assets/images/cat_1.png') ,
            name: ('Plastic'),
          ),
          CommonCategoryCard(
            image: Image.asset('assets/images/cat_1.png') ,
            name: ('Steel'),
          ),
          CommonCategoryCard(
            image: Image.asset('assets/images/cat_1.png') ,
            name: ('Plastic'),
          ),
        ],
      ),
    );
  }
}
