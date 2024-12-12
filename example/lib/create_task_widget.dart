import 'package:dynamic_stepper/dynamic_stepper.dart';
import 'package:example/dynamic_stepper_widget.dart';
import 'package:example/presentation/step_form_cubit/create_task_cubit.dart';
import 'package:example/presentation/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_form_field/custom_form_field.dart';

class CreateTaskWidget extends StatefulWidget {
  const CreateTaskWidget({super.key});

  @override
  State<CreateTaskWidget> createState() => _CreateTaskWidgetWidgetState();
}

class _CreateTaskWidgetWidgetState extends State<CreateTaskWidget>
    with AutomaticKeepAliveClientMixin<CreateTaskWidget> {
  final List<DynamicStep> _steps = [];
  final CreateTaskCubit _createTaskCubit = CreateTaskCubit();

  @override
  void initState() {
    super.initState();
    _initializeSteps();
  }

  // Initialize the first step and the "Add New Step" button
  void _initializeSteps() {
    _steps.add(_createStep(isAddButton: false));
    _createTaskCubit.addNextStep();
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
          : null,
      stepperContentWidgetBuilder: (int stepIndex) {
        return isAddButton ? const SizedBox() : _stepFormWidget(stepIndex);
      },
    );
  }

  // Add a new step to the list
  void _addStep() {
    setState(() {
      _steps.insert(_steps.length - 1, _createStep(isAddButton: false));
      _createTaskCubit.addNextStep();
    });
  }

  // Add the "Add New Step" button
  void _addAddNewStepButton() {
    setState(() => _steps.add(_createStep(isAddButton: true)));
  }

  // Widget for step form
  Widget _stepFormWidget(int index) {
    return BlocConsumer<CreateTaskCubit, CreateTaskState>(
      bloc: _createTaskCubit,
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
    final timer = _createTaskCubit.storedSteps[index].timer;
    return CustomFormField(
      initialValue: timer,
      hintText: 'Title for Step $index',
      onChanged: (title) {
        _createTaskCubit.updateStep(index, title, timer);
      },
      errorText: _getTitleErrorText(steps, index),
    );
  }

  // Timer input field widget
  Widget _buildTimerField(int index, List<StepContentModel> steps) {
    final title = _createTaskCubit.storedSteps[index].title;
    return CustomFormField(
      initialValue: title,
      hintText: 'Enter Timer for Step $index',
      onChanged: (timer) {
        _createTaskCubit.updateStep(index, title ?? "", timer);
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
    super.build(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Dynamic Stepper')),
      body: Column(
        children: [
          Expanded(
            child: DynamicStepperWidget(
              enableSwipeAction: true,
              showContent: true,
              steps: _steps,
              onStepDeleted: (index) => setState(
                () {
                  _steps.removeAt(index);
                },
              ),
              onStepDragged: _createTaskCubit.onStepDragged,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () {
              _createTaskCubit.saveSteps();
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

  @override
  bool get wantKeepAlive => true;
}
