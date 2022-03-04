import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import '../app_constant/app_colors.dart';
import '../custom_widget/selected_product_widgets/listing_review_tab_bar.dart';
import '../custom_widget/widgets/custom_widget/custom_text.dart';

class SellerReviewWidget extends StatelessWidget {
  const SellerReviewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _showPopupMenu() {
      final RenderBox renderBox = context.findRenderObject() as RenderBox;
      final offset = renderBox.localToGlobal(Offset.zero);
      //*calculate the start point in this case, below the button
      final left = offset.dx;
      final top = offset.dy + renderBox.size.height;
      //*The right does not indicates the width
      final right = left + renderBox.size.width;
      final bottom = offset.dx;
      showMenu<String>(
        context: context,
        color: AppColors.primaryColor,
        position: RelativeRect.fromLTRB(25,-2,25,25),
        //position where you want to show the menu on screen
        items: [
          PopupMenuItem<String>(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height : Get.height * 0.04,
                  ),
                  CustomText(
                    text: 'Contact to seller',
                    color: AppColors.commonWhiteTextColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                  ),
                ],
              ),
            ),
            value: '1',
          ),
          PopupMenuItem<String>(
            child: Column(
              children: [
               SizedBox(
                  height: Get.height * 0.008,
                ),
                Center(
                  child: CustomText(
                    text: '\$5',
                    color: AppColors.commonWhiteTextColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 35,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.008,
                ),
              ],
            ),
            value: '2',
          ),
          PopupMenuItem<String>(
            child: Container(
              height: Get.height * 0.08,
              width: Get.width * 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.commonWhiteTextColor,
                ),
                child: CustomText(
                  textAlign: TextAlign.center,
                  text: 'Get Contact details',
                  alignment: Alignment.center,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: AppColors.secondaryBlackColor,
                ),
              ),
            ),
            value: '3',
          ),
          PopupMenuItem<String>(
            child: Center(
                child: SizedBox(
                  height: Get.height * 0.008,
                )
            ),
            value: '4',
          ),
          PopupMenuItem<String>(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColors.commonWhiteTextColor,
                    ),
                  ),
                  CustomText(
                    text:
                        ' By this subscription\n you can call and chat\n with seller at any time.',
                    color: AppColors.commonWhiteTextColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
              value: '5'),
          PopupMenuItem<String>(
            child: Center(
              child: SizedBox(
                height: Get.height * 0.01,
              )
            ),
            value: '6',
          ),
        ],
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Card(
                margin: EdgeInsets.only(top: 0, bottom: 10),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          overflow: Overflow.visible,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    height: 90,
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius:
                                            const BorderRadius.vertical(
                                          bottom: Radius.circular(25),
                                        )),
                                  ),
                                )
                              ],
                            ),
                            Positioned(
                              top: 0.0,
                              child: Container(
                                width: 200,
                                height: 52,
                              ),
                            ),
                            Positioned(
                              top: 43.0,
                              child: Container(
                                height: 80.0,
                                width: 80.0,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Color(0xffE8E8E8), width: 1.0)),
                                child: Image.asset(
                                  'assets/images/png/cat_1.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Positioned(
                                top: 15,
                                left: 0,
                                child: BackButton(
                                  color: AppColors.commonWhiteTextColor,
                                )),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: Get.height * 0.049,
                    ),
                    CustomText(
                        text: 'Jan Doe',
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: AppColors.secondaryBlackColor),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: '5.0',
                            color: AppColors.secondaryBlackColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                          SmoothStarRating(
                              allowHalfRating: false,
                              onRatingChanged: (v) {
                                // rating = v;
                                // setState(() {});
                              },
                              starCount: 5,
                              // rating: rating,
                              size: 20.0,
                              filledIconData: Icons.blur_off,
                              halfFilledIconData: Icons.blur_on,
                              color: AppColors.starRatingColor,
                              borderColor: AppColors.starRatingColor,
                              spacing: 0.0),
                          SizedBox(
                            width: Get.width * 0.01,
                          ),
                          CustomText(
                              text: '(14 reviews)',
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: AppColors.secondaryBlackColor),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.hintTextColor,
                          width: 0.8,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 80, vertical: 5),
                      child: InkWell(
                        onTap: () {
                          print('Get Contatc Detail');
                          _showPopupMenu();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                width: 27,
                                height: 27,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2,
                                      color: AppColors.starRatingColor),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Icon(
                                  Icons.folder,
                                  color: AppColors.primaryColor,
                                )
                                // SvgPicture.asset('assets/images/folder_icon.svg'),
                                ),
                            const SizedBox(
                              width: 10,
                            ),
                            CustomText(
                                text: 'Get contact details',
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: AppColors.secondaryBlackColor),
                          ],
                        ),
                      ),
                    ),
                    // SizedBox(height: Get.height * 0.02,),
                  ],
                ),
              ),
            ),
            Expanded(flex: 5, child: ListingReviewTabBarWidget()),
          ],
        ),
      ),
    );
  }
}
