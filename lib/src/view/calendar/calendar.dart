import 'package:flutter/material.dart';
import 'package:flutter_design/src/constants/app_colors.dart';
import 'package:flutter_design/src/constants/app_icons.dart';
import 'package:flutter_design/src/view/calendar/component.dart';
import 'package:flutter_design/src/widgets/global_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  String selectedMonth = monthList[DateTime.now().month - 1];
  int selectedIndex = DateTime.now().day;

  int selectedMonthIndex = DateTime.now().month - 1;

  int changeMonthDays(String monthName) {
    final monthIndex = monthList.indexOf(monthName) + 1;
    selectedMonthIndex = monthIndex;
    return getNumberOfDaysInMonth(2024, monthIndex);
  }

  @override
  Widget build(BuildContext context) {
    print("build again");
    return Scaffold(
      body: Container(
          padding: EdgeInsets.only(left: 10.w, top: 30.h, right: 10.r),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // month
                  GestureDetector(
                    onTap: () {},
                    child: DropdownButton<String>(
                      underline: Container(),
                      elevation: 0,
                      // dropdownColor: Colors.transparent,
                      icon: const Icon(Icons.keyboard_arrow_down_sharp),

                      onChanged: (val) {
                        setState(() {
                          selectedMonth = val ?? selectedMonth;
                          //changeMonthDays(selectedMonth);
                        });
                      },
                      items: monthList
                          .map((e) => DropdownMenuItem<String>(
                                value: e,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      e,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    siHor(5),
                                    const Text(
                                      "2023",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                    // siHor(10),
                                    //Icon(Icons.keyboard_arrow_down_sharp)
                                  ],
                                ),
                              ))
                          .toList(),
                      value: selectedMonth,
                    ),
                  ),

                  SizedBox(
                    width: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: boxDecoration(),
                          alignment: Alignment.center,
                          child: const Icon(Icons.add, color: Colors.white),
                        ),
                        SvgPicture.asset("assets/icons/Vuesax.svg"),
                        SvgPicture.asset("assets/icons/3dot.svg"),
                      ],
                    ),
                  )
                ],
              ),
              siVer(20),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: changeMonthDays(selectedMonth),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Column(
                        children: [
                          Container(
                            height: 73.h,
                            width: 70.w,
                            decoration:
                                const BoxDecoration(color: Colors.transparent),
                          ),
                          boxedBgContainer("Check-in", "assets/icons/chec+.svg",
                              AppColors.green),
                          boxedBgContainer("Test Prep",
                              "assets/icons/routine.svg", AppColors.red),
                          boxedBgContainer("Review", "assets/icons/review.svg",
                              AppColors.yeallo),
                          boxedBgContainer("Writing",
                              "assets/icons/writing.svg", AppColors.blue),
                          boxedBgContainer("Reading", "assets/icons/book.svg",
                              AppColors.purple),
                        ],
                      );
                    }

                    return Column(
                      children: [
                        // only date bar
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Container(
                            height: 64.h,
                            width: 60.w,
                            // margin: const EdgeInsets.only(left: 1),
                            padding: const EdgeInsets.all(5),
                            decoration: index == selectedIndex
                                ? boxDecoration()
                                : const BoxDecoration(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  getWeekday(
                                      selectedMonthIndex, index, 2024)[0],
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: index == selectedIndex
                                          ? Colors.white
                                          : Colors.grey),
                                ),
                                Text(
                                  index.toString(),
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: index == selectedIndex
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),

                        siVer(10),
                        // table
                        checkboxedContainer(subjectList[index],
                            "assets/icons/chec+.svg", chekedBox[index], index),
                        boxedContainer(subjectList[index], iconList[index]),
                        boxedContainer(subjectList[index], iconList[index]),
                        boxedContainer(subjectList[index], iconList[index]),
                        boxedContainer(subjectList[index], iconList[index]),
                      ],
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }

  Widget boxedContainer(String text, String svgAsset) {
    return Flexible(
      child: Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.only(bottom: 1),
          width: 70.w,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.1))),
          alignment: Alignment.center,
          child: text.isNotEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.w500)),
                    SvgPicture.asset(svgAsset)
                  ],
                )
              : const Center(
                  child: Text("-"),
                )),
    );
  }

  Widget boxedBgContainer(String text, String svgAsset, Color bgColor) {
    BorderRadius borderRadius = BorderRadius.zero;
    EdgeInsets leftColorHeight = EdgeInsets.zero;
    BorderRadius leftColorBorder = BorderRadius.zero;
    ;
    if (text == "Check-in") {
      borderRadius = const BorderRadius.only(topLeft: Radius.circular(12));
      leftColorHeight = const EdgeInsets.only(top: 5);
      leftColorBorder = const BorderRadius.only(topLeft: Radius.circular(12));
    } else if (text == "Reading") {
      borderRadius = const BorderRadius.only(bottomLeft: Radius.circular(12));
      leftColorHeight = const EdgeInsets.only(bottom: 5);
      leftColorBorder =
          const BorderRadius.only(bottomLeft: Radius.circular(12));
    } else {
      borderRadius = BorderRadius.zero;
    }

    return Flexible(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   margin: leftColorHeight,
          //   width: 3,
          //   // color: bgColor,
          //   decoration:
          //       BoxDecoration(color: bgColor, borderRadius: leftColorBorder),
          // ),
          Container(
            // padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.only(bottom: 1),
            width: 70.w,
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: bgColor.withOpacity(0.18),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: leftColorHeight,
                  width: 3,
                 
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: leftColorBorder,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: bgColor),
                    ),
                    SvgPicture.asset(svgAsset)
                  ],
                ),

                siHor(2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget checkboxedContainer(
      String text, String svgAsset, bool isCheckBox, int index) {
    bool isEmpty = text.isEmpty ? true : false;
    isEmpty ? text = '-' : isEmpty;
    bool isSelected = false;

    String checkBoxAsset = isCheckBox ? AppIcons.checkbox : AppIcons.correct;

    return Flexible(
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.only(bottom: 1),
        width: 70.w,
        // height: 100,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.1))),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(text,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w500)),
            if (!isEmpty)
              GestureDetector(
                onTap: () {
                  setState(() {
                    print("tapped");
                    // selected[index] = selected[index];
                    // isCheckBox = true;
                    // checkBoxAsset = "assets/icons/correct.svg";
                    chekedBox[index] = false;
                  });
                },
                child: SvgPicture.asset(checkBoxAsset),
              )
          ],
        ),
      ),
    );
  }
}
