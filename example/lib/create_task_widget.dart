import 'package:dynamic_stepper/dynamic_stepper.dart';
import 'package:example/dynamic_stepper_widget.dart';
import 'package:example/presentation/step_form_cubit/create_task_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_form_field/custom_form_field.dart';
import 'package:simple_form_field/form_configs.dart';

class CreateTaskWidget extends StatefulWidget {
  const CreateTaskWidget({super.key});

  @override
  State<CreateTaskWidget> createState() => _CreateTaskWidgetWidgetState();
}

class _CreateTaskWidgetWidgetState extends State<CreateTaskWidget>
    with AutomaticKeepAliveClientMixin<CreateTaskWidget> {
  final List<DynamicStep> _steps = [];
  final CreateTaskCubit _createTaskCubit = CreateTaskCubit()..addNextStep();

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
  DynamicStep _createStep({required bool isAddButton}) {
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
        return isAddButton ? null : _stepFormWidget(stepIndex);
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
    _steps.add(_createStep(isAddButton: true));
  }

  // Widget for step form
  Widget _stepFormWidget(int index) {
    return BlocListener<CreateTaskCubit, CreateTaskState>(
      bloc: _createTaskCubit,
      listener: (context, state) {
        state.status.maybeWhen(
            orElse: () {},
            error: (error) {
              print('ERROR $error');
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: [
            _buildStepImage(),
            _buildTitleField(index),
            _buildTimerField(index),
          ],
        ),
      ),
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
  Widget _buildTitleField(int index) {
    return BlocSelector<CreateTaskCubit, CreateTaskState, Field<String?>?>(
      bloc: _createTaskCubit,
      selector: (state) => state.steps[index]?.titleField,
      builder: (context, titleField) {
        return Material(
          child: CustomFormField(
            initialValue: titleField?.value,
            hintText: 'Title for Step $index',
            onChanged: (title) {
              _createTaskCubit.onStepFormChanged(index: index, title: title);
            },
            errorText: titleField?.errorMessage,
          ),
        );
      },
    );
  }

  // Timer input field widget
  Widget _buildTimerField(int index) {
    return BlocSelector<CreateTaskCubit, CreateTaskState, Field<String?>?>(
      bloc: _createTaskCubit,
      selector: (state) => state.steps[index]?.timerField,
      builder: (context, timerField) {
        return Material(
          child: CustomFormField(
            initialValue: timerField?.value,
            hintText: 'Timer for Step $index',
            onChanged: (timer) {
              _createTaskCubit.onStepFormChanged(index: index, timer: timer);
            },
            errorText: timerField?.errorMessage,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Stepper'),
        actions: [
          IconButton(onPressed: () {

          }, icon: const Icon(Icons.add)),
          IconButton(onPressed: () {

          }, icon: const Icon(Icons.safety_check))
        ],
      ),
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
                  _createTaskCubit.deleteStep(index);
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
            child: const Text('Addx xStep'),
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
