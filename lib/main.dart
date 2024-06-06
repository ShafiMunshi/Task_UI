import 'package:flutter/material.dart';
import 'package:flutter_design/src/view/calendar/calendar.dart';
import 'package:flutter_design/src/view/calendar/calendar_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

  void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme: GoogleFonts.interTextTheme(
                Theme.of(context).textTheme.apply())),

                home: CalendarScreen(),
        
      ),
    );
  }
}
