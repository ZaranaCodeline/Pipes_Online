import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/seller/common/s_color_picker.dart';
import 'package:sizer/sizer.dart';

class LineChartPage extends StatefulWidget {
  @override
  State<LineChartPage> createState() => _LineChartPageState();
}

class _LineChartPageState extends State<LineChartPage> {
  String dropdownValue = 'Last Week';

  @override
  Widget build(BuildContext context) => Container(
        height: Get.height,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: AppColors.commonWhiteTextColor,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10, top: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order Statics',
                      style: TextStyle(
                          color: SColorPicker.fontGrey, fontSize: 10.sp),
                    ),
                    DropdownButton(
                      value: dropdownValue,
                      items: <String>[
                        'Last Week',
                        'Yesterday',
                        'This Week',
                        'This Month'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(color: AppColors.primaryColor),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          print('chart hear...');
                          dropdownValue = newValue!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              LineChartWidget(),
            ],
          ),
        ),
      );
}

class LineChartWidget extends StatelessWidget {
  final List<Color> gradientColors = [
    AppColors.primaryColor,
  ];

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 15.sp),
        height: Get.height / 2.5,
        width: Get.width * 1,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.sp),
          child: LineChart(
            LineChartData(
              minX: 0,
              maxX: 11,
              minY: 0,
              maxY: 9,
              titlesData: LineTitles.getTitleData(),
              gridData: FlGridData(
                show: false,
                // getDrawingHorizontalLine: (value) {
                //   return FlLine(
                //     //color: const Color(0xff37434d),
                //     strokeWidth: 0,
                //   );
                // },
                // //drawVerticalLine: true,
                // getDrawingVerticalLine: (value) {
                //   return FlLine(
                //     //color: const Color(0xff37434d),
                //     strokeWidth: 0,
                //   );
                // },
              ),
              borderData: FlBorderData(
                show: false,
                border: Border.all(color: const Color(0xff37434d), width: 1),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    FlSpot(0, 4),
                    FlSpot(2.6, 2),
                    FlSpot(4.9, 5),
                    FlSpot(6.8, 2.5),
                    FlSpot(8, 4),
                    FlSpot(9.5, 3),
                    FlSpot(11, 4),
                  ],
                  isCurved: true,
                  colors: gradientColors,
                  barWidth: 5,
                  shadow: Shadow(
                      blurRadius: 5,
                      color: AppColors.primaryColor,
                      offset: Offset(0, 4)),
                  dotData: FlDotData(
                    show: true,
                  ),
                  // belowBarData: BarAreaData(
                  //   show: false,
                  //   colors: gradientColors
                  //       .map((color) => color.withOpacity(0.3))
                  //       .toList(),
                  // ),
                ),
              ],
            ),
          ),
        ),
      );
}

class LineTitles {
  static getTitleData() => FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 35,
          /* getTextStyles: (value) =>  TextStyle(
        color: Color(0xff68737d),
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),*/
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '1 Mar';
              case 2:
                return '2 Mar';
              case 4:
                return '3 Mar';
              case 6:
                return '4 Mar';
              case 8:
                return '5 Mar';
              case 10:
                return '6 Mar';
              case 12:
                return '7 Mar';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: false,
          // getTextStyles: (value) => const TextStyle(
          //   color: Color(0xff67727d),
          //   fontWeight: FontWeight.bold,
          //   fontSize: 15,
          // ),
          // getTitles: (value) {
          //   switch (value.toInt()) {
          //     case 1:
          //       return '10k';
          //     case 3:
          //       return '30k';
          //     case 5:
          //       return '50k';
          //   }
          //   return '';
          // },
          // reservedSize: 30,
          // margin: 10,
        ),
      );
}
