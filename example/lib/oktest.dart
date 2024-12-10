import 'package:dynamic_stepper/dynamic_stepper.dart';
import 'package:example/presentation/step_form_cubit/therapist_availability_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:simple_form_field/custom_form_field.dart';

class DynamiccStepper extends StatefulWidget {
  @override
  _DynamiccStepperState createState() => _DynamiccStepperState();
}

class _DynamiccStepperState extends State<DynamiccStepper> {
  List<DynamicStep> _steps = [];
  int _currentStep = 0;
  final TherapistAvailabilityFormCubit _availabilityFormCubit =
      TherapistAvailabilityFormCubit();

  @override
  void initState() {
    super.initState();
    _initializeSteps();
  }

  void _initializeSteps() {
    _steps = List<DynamicStep>.from(_availabilityFormCubit.stepsModel)
      ..add(DynamicStep(
          content: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.red)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    // Adjust corner radius
                    child: Image.network(
                      'https://via.placeholder.com/1024',
                      // Working image link
                      width: 500,
                      height: 180,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Enter Text for Step ${_steps.length}',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Enter Text for Step ${_steps.length}',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          isActive: true));
    _updateAddNewStepButton();
  }

  void _updateAddNewStepButton() {
    // Ensure the "Add New Step" button is always the last step
    _steps.removeWhere((step) => step.title is ElevatedButton);
    _steps.add(
      DynamicStep(
        state: DynamicStepState.action,
        title: ElevatedButton(
          onPressed: _addStep,
          child: const Text('Add Step'),
        ),
        content: const SizedBox.shrink(),
        isActive: true,
      ),
    );
  }

  void _addStep() {
    setState(() {
      _availabilityFormCubit.addAnotherAvailable();
      // Add a new step before refreshing the "Add New Step" button
      _steps.insert(
          _steps.length - 1, // Insert before the "Add New Step" button
          DynamicStep(
              content: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.red)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        // Adjust corner radius
                        child: Image.network(
                          'https://via.placeholder.com/1024',
                          // Working image link
                          width: 500,
                          height: 180,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Enter Text for Step ${_steps.length}',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Enter Text for Step ${_steps.length}',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              isActive: true));
      _currentStep++;
      _updateAddNewStepButton();
      print('STEPPER INDEX $_currentStep');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dynamic Stepper')),
      body: DynamicStepper(
        alwaysShowContent: true,
        steps: _steps,
        currentStep: _currentStep,
        onStepTapped: (step) {},
        controlsBuilder: (context, details) => const SizedBox(),
      ),
    );
  }
}
