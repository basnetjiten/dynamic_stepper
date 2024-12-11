import 'package:example/oktest.dart';
import 'package:example/tab_view.dart';
import 'package:example/week_view_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  // // Lock orientation to portrait only (you can change it to landscape or any other as needed)
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.landscapeRight,
  //   DeviceOrientation.landscapeLeft,
  // ]);

  runApp(const MyApp());
}
const String _title = 'Flutter Code Sample';

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: WeekViewStepperWidget(),
    );
  }
}


