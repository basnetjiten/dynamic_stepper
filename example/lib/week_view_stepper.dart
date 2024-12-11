import 'package:dynamic_stepper/dynamic_stepper.dart';
import 'package:example/presentation/step_form_cubit/create_task_cubit.dart';
import 'package:example/presentation/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_form_field/custom_form_field.dart';

class WeekViewStepperWidget extends StatefulWidget {
  const WeekViewStepperWidget({super.key});

  @override
  State<WeekViewStepperWidget> createState() => _WeekViewStepperWidgetState();
}

class _WeekViewStepperWidgetState extends State<WeekViewStepperWidget> {
  final List<DynamicStep> _steps = [];
  final CreateTaskCubit _availabilityFormCubit = CreateTaskCubit();

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
  void initState() {
    super.initState();
    _initializeSteps();
  }

  // Initialize the first step and the "Add New Step" button
  void _initializeSteps() {
    _steps.add(_createStep(isAddButton: false));
    _addAddNewStepButton();
  }

  // Create a DynamicStep widget
  DynamicStep _createStep({required bool isAddButton, int? index}) {
    return DynamicStep(
      isActive: true,
      state: isAddButton ? DynamicStepState.action : DynamicStepState.indexed,
      title: isAddButton
          ? ElevatedButton(
              onPressed: _addStep,
              child: const Text('Add Step'),
            )
          : Text('Sunday'),
      stepperContentWidgetBuilder: (int index) {
        return isAddButton
            ? const SizedBox()
            : SizedBox(
                height: 150,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: _images[index].length,
                  itemBuilder: (context, imageIndex) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0,30,5,0),
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
    );
  }

  // Add a new step to the list
  void _addStep() {
    setState(() {
      _availabilityFormCubit.addAnotherAvailable();
      _steps.insert(_steps.length - 1, _createStep(isAddButton: false));
    });
  }

  // Add the "Add New Step" button
  void _addAddNewStepButton() {
    setState(() {
      _steps.add(_createStep(isAddButton: true));
      _availabilityFormCubit.createSteps(_steps.length);
    });
  }

  // Widget for step form
  Widget _stepFormWidget(int index) {
    return BlocConsumer<CreateTaskCubit, CreateTaskState>(
      bloc: _availabilityFormCubit,
      listener: (context, state) {
        state.status.maybeWhen(
            orElse: () {},
            error: (error) {
              print('ERROR $error');
            });
      },
      builder: (context, state) {
        // Using the state directly here, since we no longer use selector
        List<StepContentModel> steps = state.steps;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: [
              _buildStepImage(),
              _buildTitleField(index, steps),
              _buildTimerField(index, steps),
            ],
          ),
        );
      },
    );
  }

  // Step image widget
  Widget _buildStepImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        'https://via.placeholder.com/1024',
        width: 500,
        height: 180,
        fit: BoxFit.fitWidth,
      ),
    );
  }

  // Title input field widget
  Widget _buildTitleField(int index, List<StepContentModel> steps) {
    return CustomFormField(
      hintText: 'Title for Step $index',
      onChanged: (title) {
        final timer = _availabilityFormCubit.stepsModel[index].timer;
        _availabilityFormCubit.updateStep(index, title, timer);
      },
      errorText: _getTitleErrorText(steps, index),
    );
  }

  // Timer input field widget
  Widget _buildTimerField(int index, List<StepContentModel> steps) {
    return CustomFormField(
      hintText: 'Enter Timer for Step $index',
      onChanged: (timer) {
        final title = _availabilityFormCubit.stepsModel[index].title;
        _availabilityFormCubit.updateStep(index, title ?? "", timer);
      },
      errorText: _getTimerErrorText(steps, index),
    );
  }

  // Get error text for the title field
  String? _getTitleErrorText(List<StepContentModel> steps, int index) {
    return steps[index].title?.isEmpty ?? false ? 'Title is required' : null;
  }

  // Get error text for the timer field
  String? _getTimerErrorText(List<StepContentModel> steps, int index) {
    return steps[index].timer?.isEmpty ?? false ? 'Timer is required' : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dynamic Stepper')),
      body: Column(
        children: [
          Expanded(
            child: DynamicStepper(
              isTitleOnlyStepper: true,
              alwaysShowContent: true,
              steps: _steps,
              currentStep: 0,
              onStepDelete: (step) {
                setState(() {
                  _steps.removeAt(step);
                });
              },
              controlsBuilder: (context, details) => const SizedBox(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () {
              _availabilityFormCubit.saveSteps();
            },
            child: const Text('Add Step'),
          ),
          const SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }
}
