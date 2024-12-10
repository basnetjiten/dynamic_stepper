import 'package:example/oktest.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());
const String _title = 'Flutter Code Sample';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: DynamiccStepper(),
    );
  }
}


