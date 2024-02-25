import 'dart:io';
import 'package:misamoneykeeper_flutter/view/add/category_view.dart';
import 'package:misamoneykeeper_flutter/view/report/report_view.dart';
import 'package:misamoneykeeper_flutter/view/start/splash_view.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';
import 'package:misamoneykeeper_flutter/view/home/home_view.dart';
import 'package:misamoneykeeper_flutter/server/my_http_overrides.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:misamoneykeeper_flutter/view/more/information_view.dart';
import 'package:misamoneykeeper_flutter/view/more/change_password_view.dart';
import 'package:misamoneykeeper_flutter/view/add/add_view.dart';
import 'package:misamoneykeeper_flutter/view/home/addlimit_view.dart';
SharedPreferences? prefs;
void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MiSa MoneyKeeper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: sansBold,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: false,
      ),
      home: CategoryView(),
    );
  }
}
