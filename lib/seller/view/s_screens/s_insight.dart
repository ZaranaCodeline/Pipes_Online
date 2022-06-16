import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/seller/common/s_color_picker.dart';
import 'package:pipes_online/seller/view_model/time_filter_dropdown.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';

class LineChartPage extends StatefulWidget {
  // String dropDown;

  LineChartPage({
    Key? key,
  }) : super(key: key);
  @override
  State<LineChartPage> createState() => _LineChartPageState();
}

class _LineChartPageState extends State<LineChartPage> {
  String? dropdownValue = 'Last Week';
  String? formattedDateTime;
  TimeFilterController timeFilterController = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // dropdownValue = widget.dropDown;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      onChanged: (String? val) {
                        setState(() {
                          print('VAL >>> $val');
                          dropdownValue = val;
                          timeFilterController.dropDownValue = dropdownValue!;
                        });
                      }),
                ],
              ),
            ),
            LineChartWidget(),
          ],
        ),
      ),
    );
  }
}

var date = DateTime.now();
List months = [
  'jan',
  'feb',
  'mar',
  'apr',
  'may',
  'jun',
  'jul',
  'aug',
  'sep',
  'oct',
  'nov',
  'dec'
];
var now = new DateTime.now();
var current_mon = now.month;
var monName = months[current_mon - 1];

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
              ),
              borderData: FlBorderData(
                show: false,
                border: Border.all(color: const Color(0xff37434d), width: 1),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    FlSpot(0, 1),
                    FlSpot(2.5, 1),
                    FlSpot(3.4, 3),
                    FlSpot(5.5, 3.2),
                    FlSpot(6.5, 5.5),
                    FlSpot(9, 6),
                    FlSpot(10, 8),
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
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '1 $monName';
              case 2:
                return '2 $monName';
              case 4:
                return '3 $monName';
              case 6:
                return '4 $monName';
              case 8:
                return '5 $monName';
              case 10:
                return '6 $monName';
              case 12:
                return '7 $monName';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      );
}
