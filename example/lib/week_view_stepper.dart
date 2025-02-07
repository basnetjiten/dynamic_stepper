import 'package:dynamic_stepper/dynamic_stepper.dart';
import 'package:example/dynamic_stepper_widget.dart';
import 'package:example/presentation/step_form_cubit/create_task_cubit.dart';
import 'package:flutter/material.dart';
import 'package:simple_form_field/colors/app_colors.dart';

class WeekViewStepperWidget extends StatefulWidget {
  const WeekViewStepperWidget({super.key});

  @override
  State<WeekViewStepperWidget> createState() => _WeekViewStepperWidgetState();
}

class _WeekViewStepperWidgetState extends State<WeekViewStepperWidget> {
  late final List<DynamicStep> _steps;
  final CreateTaskCubit _availabilityFormCubit = CreateTaskCubit();

  final List<String> _days = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Monday',
    'Tuesday',
    'Wednesday',
  ];

  final List<List<String>> _images = [
    [
      'https://via.placeholder.com/150',
      'https://via.placeholder.com/150',
      'https://via.placeholder.com/150',
      'https://via.placeholder.com/150',
      'https://via.placeholder.com/150',
    ],
    [
      'https://via.placeholder.com/150',
      'https://via.placeholder.com/150',
      'https://via.placeholder.com/150',
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
      'https://via.placeholder.com/150',
    ],
    [
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
    ],
    [
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
    ],
  ];

  @override
  void initState() {
    super.initState();

    _steps = List<DynamicStep>.generate(
        10,
        (index) => DynamicStep(
              stepperIcon: _days[index] == 'Wednesday'
                  ? const Icon(Icons.abc)
                  : Container(
                height: 100,width: 100,color: AppColors.textDarkGrey,
                  child:Text(_days[index])),
              state: DynamicStepState.indexed,
              stepperContentWidgetBuilder: (int index) {
                if (_days[index] == 'Wednesday') {
                  return null;
                }
                return SizedBox(
                  height: _days[index] == 'Wednesday' ? 0 : 150,
                  child: _days[index] == 'Wednesday'
                      ? const SizedBox()
                      : ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: _images[index].length,
                          itemBuilder: (context, imageIndex) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0, 30, 5, 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  _images[index][imageIndex],
                                  width: 108,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                );
              },
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dynamic Stepper')),
      body: Column(
        children: [
          Expanded(
            child: DynamicStepperWidget(

              enableSwipeAction: false,
              isTitleOnlyStepper: true,
              showContent: true,
              steps: _steps,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
