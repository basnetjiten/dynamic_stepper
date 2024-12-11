import 'package:flutter/material.dart';

class StepperWithDaysView extends StatefulWidget {
  @override
  _StepperWithDaysViewState createState() => _StepperWithDaysViewState();
}

class _StepperWithDaysViewState extends State<StepperWithDaysView> {
  int _currentStep = 0;

  final List<String> _days = [
    'Day 1',
    'Day 2',
    'Day 3',
    'Day 4',
  ];

  final List<List<String>> _images = [
    [
      'https://via.placeholder.com/150',
      'https://via.placeholder.com/150',
      'https://via.placeholder.com/150',
    ],
    [
      'https://via.placeholder.com/150',
      'https://via.placeholder.com/150',
    ],
    [
      'https://via.placeholder.com/150',
      'https://via.placeholder.com/150',
      'https://via.placeholder.com/150',
      'https://via.placeholder.com/150',
    ],
    [
      'https://via.placeholder.com/150',
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Days Stepper')),
      body: Stepper(
        currentStep: _currentStep,
        onStepTapped: (step) {
          setState(() {
            _currentStep = step;
          });
        },
        onStepContinue: () {
          if (_currentStep < _days.length - 1) {
            setState(() {
              _currentStep++;
            });
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() {
              _currentStep--;
            });
          }
        },
        steps: _days.asMap().entries.map((entry) {
          final index = entry.key;
          final day = entry.value;

          return Step(
            title: Text(day),
            content: SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _images[index].length,
                itemBuilder: (context, imageIndex) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        _images[index][imageIndex],
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            isActive: _currentStep >= index,
            state: _currentStep > index
                ? StepState.complete
                : StepState.indexed,
          );
        }).toList(),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StepperWithDaysView(),
    ),
  );
}
