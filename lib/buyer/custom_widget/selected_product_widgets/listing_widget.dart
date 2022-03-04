import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_constant/app_colors.dart';
import '../widgets/custom_widget/custom_text.dart';

class ListingWidget extends StatelessWidget {
  const ListingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Card(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          'assets/images/png/cart_page.png',
                          fit: BoxFit.cover,
                          width: 130,
                          height: 95,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            CustomText(
                              text: 'Round',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: AppColors.primaryColor,
                              alignment: Alignment.topLeft,
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            CustomText(
                              text: 'ABC Pipe',
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: AppColors.secondaryBlackColor,
                              alignment: Alignment.centerLeft,
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            CustomText(
                              text: '\$10/ Feet',
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: AppColors.secondaryBlackColor,
                              alignment: Alignment.centerLeft,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          'assets/images/png/cart_page.png',
                          fit: BoxFit.cover,
                          width: 130,
                          height: 95,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            CustomText(
                              text: 'Round',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: AppColors.primaryColor,
                              alignment: Alignment.topLeft,
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            CustomText(
                              text: 'ABC Pipe',
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: AppColors.secondaryBlackColor,
                              alignment: Alignment.centerLeft,
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            CustomText(
                              text: '\$10/ Feet',
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: AppColors.secondaryBlackColor,
                              alignment: Alignment.centerLeft,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          'assets/images/png/cart_page.png',
                          fit: BoxFit.cover,
                          width: 130,
                          height: 95,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            CustomText(
                              text: 'Round',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: AppColors.primaryColor,
                              alignment: Alignment.topLeft,
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            CustomText(
                              text: 'ABC Pipe',
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: AppColors.secondaryBlackColor,
                              alignment: Alignment.centerLeft,
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            CustomText(
                              text: '\$10/ Feet',
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: AppColors.secondaryBlackColor,
                              alignment: Alignment.centerLeft,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// Widget CustomListingProduct(){
//   String? image ,title, desc , price;
//   return  Card(
//     child: Row(
//       children: [
//         Image.asset(
//           image,
//           fit: BoxFit.cover,
//           width: 130,
//           height: 95,
//         ),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CustomText(
//               text: 'title',
//               fontWeight: FontWeight.w700,
//               fontSize: 16,
//               color: AppColors.primaryColor,
//               alignment: Alignment.topLeft,
//             ),
//             CustomText(
//               text: 'desc',
//               fontWeight: FontWeight.w700,
//               fontSize: 18,
//               color: AppColors.secondaryBlackColor,
//               alignment: Alignment.centerLeft,
//             ),
//             CustomText(
//               text: 'price',
//               fontWeight: FontWeight.w700,
//               fontSize: 18,
//               color: AppColors.secondaryBlackColor,
//               alignment: Alignment.centerLeft,
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }
}
