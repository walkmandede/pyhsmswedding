import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pyhsms/app_data/app_colors.dart';
import 'package:pyhsms/modules/home_page/v_home_page.dart';

void superPrint(var content, {var title = 'Super Print'}) {
  String callerFrame = '';

  if (kDebugMode) {
    try {
      final stackTrace = StackTrace.current;
      final frames = stackTrace.toString().split("\n");
      callerFrame = frames[1];
    } catch (e1,e2) {
      debugPrint(e1.toString(), wrapWidth: 1024);
    }

    DateTime dateTime = DateTime.now();
    String dateTimeString =
        '${dateTime.hour} : ${dateTime.minute} : ${dateTime.second}.${dateTime.millisecond}';
    debugPrint('', wrapWidth: 1024);
    debugPrint(
        '- ${title.toString()} - ${callerFrame.split('(').last.replaceAll(')', '')}',
        wrapWidth: 1024);
    debugPrint('____________________________');
    try {
      debugPrint(
          const JsonEncoder.withIndent('  ')
              .convert(const JsonDecoder().convert(content)),
          wrapWidth: 1024);
    } catch (e1,e2) {
      try {
        debugPrint(
            const JsonEncoder.withIndent('  ')
                .convert(const JsonDecoder().convert(jsonEncode(content))),
            wrapWidth: 1024);
      } catch (e1,e2) {
        debugPrint(content.toString());
      }
    }
    debugPrint('____________________________ $dateTimeString');
  }
}


void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    // await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await Future.delayed(const Duration(seconds: 1));
  } catch(e1,e2){
    null;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PYH<3SMS',
        locale: const Locale('en', 'EN'),
        fallbackLocale: const Locale('en', 'US'),
        theme: ThemeData(
          primarySwatch: MaterialColor(AppColors.brown.value, const {
            050: Color.fromRGBO(29, 44, 77, .1),
            100: Color.fromRGBO(29, 44, 77, .2),
            200: Color.fromRGBO(29, 44, 77, .3),
            300: Color.fromRGBO(29, 44, 77, .4),
            400: Color.fromRGBO(29, 44, 77, .5),
            500: Color.fromRGBO(29, 44, 77, .6),
            600: Color.fromRGBO(29, 44, 77, .7),
            700: Color.fromRGBO(29, 44, 77, .8),
            800: Color.fromRGBO(29, 44, 77, .9),
            900: Color.fromRGBO(29, 44, 77, 1),
          }),
          datePickerTheme: DatePickerTheme.of(context).copyWith(
              headerForegroundColor: AppColors.white,
              elevation: 2,
              shadowColor: AppColors.white.withOpacity(0.4)),
          // datePickerTheme: DatePickerThemeData(
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(15),
          //   ),
          //   headerBackgroundColor: AppColors.black,
          //   backgroundColor: AppColors.white,
          //   dayStyle: TextStyle(color: AppColors.white),
          //   weekdayStyle: TextStyle(
          //     color: AppColors.grey,
          //     fontWeight: FontWeight.w700
          //   ),
          //   yearStyle: TextStyle(
          //     color: AppColors.white
          //   ),
          //   headerHelpStyle: TextStyle(
          //     color: AppColors.white
          //   ),
          //   headerHeadlineStyle: TextStyle(
          //     color: AppColors.white,
          //   ),
          //   rangePickerHeaderHelpStyle: TextStyle(
          //     color: AppColors.white
          //   ),
          //   todayForegroundColor: MaterialStateColor.resolveWith((states) => AppColors.primary),
          //   yearForegroundColor: MaterialStateColor.resolveWith((states) => AppColors.white),
          //   dayForegroundColor: MaterialStateColor.resolveWith((states) => AppColors.white),
          // ),
          fontFamily: 'Nunito',
          fontFamilyFallback: const ['Book'],
          useMaterial3: false,
        ),
        home: const HomePage()
    );
  }
}

