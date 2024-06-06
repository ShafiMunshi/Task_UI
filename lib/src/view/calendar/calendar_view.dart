import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_design/src/constants/app_colors.dart';
import 'package:flutter_design/src/constants/app_icons.dart';
import 'package:flutter_design/src/view/calendar/component.dart';
import 'package:flutter_design/src/widgets/global_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarMain extends StatefulWidget {
  const CalendarMain({super.key});

  @override
  State<CalendarMain> createState() => _CalendarMainState();
}

class _CalendarMainState extends State<CalendarMain> {
  String selectedMonth = monthList[DateTime.now().month - 1];
  int selectedIndex = DateTime.now().day;
  int selectedMonthIndex = DateTime.now().month - 1;
  DateTime userSelectedDay = DateTime.now();

  int changeMonthDays(String monthName) {
    final monthIndex = monthList.indexOf(monthName) + 1;
    selectedMonthIndex = monthIndex;
    return getNumberOfDaysInMonth(2024, monthIndex);
  }

  @override
  Widget build(BuildContext context) {
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
                      SvgPicture.asset(AppIcons.calendar),
                      GestureDetector(
                          onTap: () {},
                          child: SvgPicture.asset(AppIcons.thrreDot)),
                    ],
                  ),
                ),
              ],
            ),
            siVer(10),
            TableCalendar(
              headerVisible: false,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: userSelectedDay,
              availableCalendarFormats: {CalendarFormat.month: "Month"},
              weekNumbersVisible: false,
              calendarStyle: CalendarStyle(
                selectedTextStyle: const TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.white),
                selectedDecoration: BoxDecoration(color: AppColors.purple),
                defaultTextStyle: const TextStyle(fontWeight: FontWeight.w600),
                todayTextStyle: const TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.white),
                holidayTextStyle: const TextStyle(fontWeight: FontWeight.w600),
                // withinRangeTextStyle:  TextStyle(fontWeight: FontWeight.w600),
                weekendTextStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              selectedDayPredicate: (day) {
                return isSameDay(userSelectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                print("selected day: ${selectedDay}");
                setState(() {
                  userSelectedDay = selectedDay;
                  // focusedDay = selectedDay; // update `_focusedDay` here as well
                });
              },
            ),
            siVer(20),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: changeMonthDays(selectedMonth) + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return Column(
                      children: [
                        Container(
                          height: 73.h,
                          width: 70.w,
                          decoration: BoxDecoration(color: Colors.transparent),
                        ),

                        Container(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            "15:00",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            "15:30",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            "16:00",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            "16:30",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        // boxedBgContainer("Check-in", "assets/icons/chec+.svg",
                        //     AppColors.green),
                        // boxedBgContainer("Test Prep", "assets/icons/routine.svg",
                        //     AppColors.red),
                        // boxedBgContainer("Review", "assets/icons/review.svg",
                        //     AppColors.yeallo),
                        // boxedBgContainer("Writing", "assets/icons/writing.svg",
                        //     AppColors.blue),
                        // boxedBgContainer(
                        //     "Reading", "assets/icons/book.svg", AppColors.purple),
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
                          height: 75.h,
                          width: 60.w,
                          // margin: const EdgeInsets.only(left: 1),
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          decoration: index == selectedIndex
                              ? boxDecoration()
                              : const BoxDecoration(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                getWeekday(selectedMonthIndex, index, 2024)
                                    .substring(0, 3),
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: index == selectedIndex
                                        ? Colors.white
                                        : Colors.grey),
                              ),
                              Text(
                                index.toString(),
                                style: TextStyle(
                                    fontSize: 26.sp,
                                    fontWeight: FontWeight.w700,
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
                      // checkboxedContainer(subjectList[index],
                      //     "assets/icons/chec+.svg", chekedBox[index], index),
                      // boxedContainer(subjectList[index], iconList[index]),
                      // boxedContainer(subjectList[index], iconList[index]),
                      // boxedContainer(subjectList[index], iconList[index]),
                      // boxedContainer(subjectList[index], iconList[index]),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
