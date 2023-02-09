import 'package:cerebulb_recruit_portal/theme/theme_service.dart';
import 'package:cerebulb_recruit_portal/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app_binding/app_bindings.dart';
import 'candidate/candidate_list_view.dart';
import 'common_widgets/common_methods.dart';

final getPreferences = GetStorage();

pref() async {
  await GetStorage.init();
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  pref();
  if (readThemePref() == systemDefault) {
    if (SchedulerBinding.instance.window.platformBrightness ==
        Brightness.dark) {
      ThemeService().saveThemeToBox(true);
    } else {
      ThemeService().saveThemeToBox(false);
    }
  }
  runApp(const MyApp()
    // DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) => const MyApp(), // Wrap your app
    // ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CEREBULB RECRUIT PORTAL',
      useInheritedMediaQuery: true,
      debugShowCheckedModeBanner: false,
      initialBinding: AppBinding(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return const CandidateListView();
  }
}
