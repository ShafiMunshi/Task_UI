import 'package:flutter/material.dart';
import 'package:flutter_design/src/constants/app_colors.dart';
import 'package:flutter_design/src/constants/app_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

SizedBox siVer(int height) {
  return SizedBox(height: height * 1.0.h);
}

SizedBox siHor(int width) {
  return SizedBox(width: width * 1.0.w);
}

BoxDecoration boxDecoration() {
  return BoxDecoration(borderRadius: border(), color: AppColors.primaryColor);
}

boldText(String text, {int size = 20}) {
  return Text(
    text,
    style: TextStyle(fontSize: size * 1.0.sp, fontWeight: FontWeight.bold),
  );
}

int getNumberOfDaysInMonth(int year, int month) {
  return DateTime(year, month + 1, 0).day;
}

String getWeekday(int monthIndex, int day, int year) {
  DateFormat format = DateFormat('yyyy-MM-dd');
  DateTime date = format.parse('$year-$monthIndex-$day');
  String weekday = DateFormat('EEEE').format(date);
  return weekday;
}
