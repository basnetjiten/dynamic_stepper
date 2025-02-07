// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/*
 * Edited by Saúl Ramírez and Jiten Basnet
 * Credits: https://gist.github.com/sanket143/bf20a16775095e0be33b8a8156c34cb9
 */

import 'dart:ui';

import 'package:dynamic_stepper/custom_drag_listener.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

/// The state of a [DynamicStep] which is used to control the style of the circle and
/// text.
///
/// See also:
///
///  * [DynamicStep]
enum DynamicStepState {
  /// A step that displays its index in its circle.
  indexed,

  /// A step that displays a pencil icon in its circle.
  editing,

  /// A step that displays a tick icon in its circle.
  complete,

  /// A step that is disabled and does not to react to taps.
  disabled,

  /// A step that is currently having an error. e.g. the user has submitted wrong
  /// input.
  error,

  /// A step that is currently having an error. e.g. the user has submitted wrong
  /// input.
  action,
}

/// Defines the [DynamicStepper]'s main axis.
enum DynamicStepperType {
  /// A vertical layout of the steps with their content in-between the titles.
  vertical,

  /// A horizontal layout of the steps with their content below the titles.
  horizontal,
}

/// Container for all the information necessary to build a Stepper widget's
/// forward and backward controls for any given step.
///
/// Used by [DynamicStepper.controlsBuilder].
@immutable
class DynamicControlsDetails {
  /// Creates a set of details describing the Stepper.
  const DynamicControlsDetails({
    required this.currentStep,
    required this.stepIndex,
    this.onStepCancel,
    this.onStepContinue,
  });

  /// Index that is active for the surrounding [DynamicStepper] widget. This may be
  /// different from [stepIndex] if the user has just changed steps and we are
  /// currently animating toward that step.
  final int currentStep;

  /// Index of the step for which these controls are being built. This is
  /// not necessarily the active index, if the user has just changed steps and
  /// this step is animating away. To determine whether a given builder is building
  /// the active step or the step being navigated away from, see [isActive].
  final int stepIndex;

  /// The callback called when the 'continue' button is tapped.
  ///
  /// If null, the 'continue' button will be disabled.
  final VoidCallback? onStepContinue;

  /// The callback called when the 'cancel' button is tapped.
  ///
  /// If null, the 'cancel' button will be disabled.
  final VoidCallback? onStepCancel;

  /// True if the indicated step is also the current active step. If the user has
  /// just activated the transition to a new step, some [DynamicStepper.type] values will
  /// lead to both steps being rendered for the duration of the animation shifting
  /// between steps.
  bool get isActive => currentStep == stepIndex;
}

/// A builder that creates a widget given the two callbacks `onStepContinue` and
/// `onStepCancel`.
///
/// Used by [DynamicStepper.controlsBuilder].
///
/// See also:
///
///  * [WidgetBuilder], which is similar but only takes a [BuildContext].
typedef ControlsWidgetBuilder = Widget Function(
    BuildContext context, DynamicControlsDetails details);

typedef StepperContentWidgetBuilder = Widget? Function(int index);

const TextStyle _kStepStyle = TextStyle(
  fontSize: 12.0,
  color: Colors.white,
);
const Color _kErrorLight = Colors.red;
final Color _kErrorDark = Colors.red.shade400;
const Color _kCircleActiveLight = Colors.white;
const Color _kCircleActiveDark = Colors.black87;
const Color _kDisabledLight = Colors.black38;
const Color _kDisabledDark = Colors.white38;
const double _kStepSize = 24.0;
const double _kTriangleHeight =
    _kStepSize * 0.866025; // Triangle height. sqrt(3.0) / 2.0

/// A material step used in [DynamicStepper]. The step can have a title and subtitle,
/// an icon within its circle, some content and a state that governs its
/// styling.
///
/// See also:
///
///  * [DynamicStepper]
///  * <https://material.io/archive/guidelines/components/steppers.html>
@immutable
class DynamicStep {
  /// Creates a step for a [DynamicStepper].
  ///
  /// The [title], [content], and [state] arguments must not be null.
  const DynamicStep(
      {this.title,
      this.stepperIcon,
      required this.stepperContentWidgetBuilder,
      this.subtitle,
      this.content,
      this.state = DynamicStepState.indexed,
      this.isActive = false,
      this.label,
      this.actionIcon});

  final Widget? stepperIcon;
  final StepperContentWidgetBuilder stepperContentWidgetBuilder;

  /// The title of the step that typically describes it.
  final Widget? title;

  final Widget? actionIcon;

  /// The subtitle of the step that appears below the title and has a smaller
  /// font size. It typically gives more details that complement the title.
  ///
  /// If null, the subtitle is not shown.
  final Widget? subtitle;

  /// The content of the step that appears below the [title] and [subtitle].
  ///
  /// Below the content, every step has a 'continue' and 'cancel' button.
  final Widget? content;

  /// The state of the step which determines the styling of its components
  /// and whether steps are interactive.
  final DynamicStepState state;

  /// Whether or not the step is active. The flag only influences styling.
  final bool isActive;

  /// Only [DynamicStepperType.horizontal], Optional widget that appears under the [title].
  /// By default, uses the `bodyText1` theme.
  final Widget? label;
}

/// A material stepper widget that displays progress through a sequence of
/// steps. Steppers are particularly useful in the case of forms where one step
/// requires the completion of another one, or where multiple steps need to be
/// completed in order to submit the whole form.
///
/// The widget is a flexible wrapper. A parent class should pass [currentStep]
/// to this widget based on some logic triggered by the three callbacks that it
/// provides.
///
/// {@tool dartpad}
/// An example the shows how to use the [DynamicStepper], and the [DynamicStepper] UI
/// appearance.
///
/// ** See code in examples/api/lib/material/stepper/stepper.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [DynamicStep]
///  * <https://material.io/archive/guidelines/components/steppers.html>
class DynamicStepper extends StatefulWidget {
  /// Creates a stepper from a list of steps.
  ///
  /// This widget is not meant to be rebuilt with a different list of steps
  /// unless a key is provided in order to distinguish the old stepper from the
  /// new one.
  ///
  /// The [steps], [type], and [currentStep] arguments must not be null.
  const DynamicStepper({
    super.key,
    required this.steps,
    this.physics,
    this.type = DynamicStepperType.vertical,
    this.currentStep = 0,
    this.onStepTapped,
    this.onStepContinue,
    this.onStepCancel,
    this.controlsBuilder,
    this.elevation,
    this.margin,
    this.alwaysShowContent = true,
    this.isTitleOnlyStepper = false,
    this.enableSwipeAction = false,
    this.enableDrag = true,
    this.actionIcon,
    this.onStepDelete,
    this.buildDefaultDragHandles = false,
    this.enableRefresh = false,
    this.onRefresh,
    this.dragLastWidget = false,
    this.onStepDragged,
    this.lastWidget,
    this.slidableCardHeight,
    this.firstWidget,
    this.toggleWidget,
    this.backgroundColor,
    this.horizontalMargin,
  }) : assert(0 <= currentStep && currentStep < steps.length);

  //Enable or disable item to be draggable in a ReorderableListView
  final bool buildDefaultDragHandles;

  final Widget? lastWidget;

  final bool dragLastWidget;

  final Widget? firstWidget;

  final bool enableRefresh;

  final Future<void> Function()? onRefresh;

  final Color? backgroundColor;

  final Widget? toggleWidget;

  final double? slidableCardHeight;

  /// Shows only title widget in the stepper
  final bool enableSwipeAction;

  /// Enables Re-orderable item drag
  final bool enableDrag;

  /// Shows only title widget in the stepper
  final bool isTitleOnlyStepper;

  /// Icon to use for stepper circle. usually an action icon
  final Widget? actionIcon;

  /// Makes the content of Steppers always visible
  final bool alwaysShowContent;

  /// The steps of the stepper whose titles, subtitles, icons always get shown.
  ///
  /// The length of [steps] must not change.
  final List<DynamicStep> steps;

  /// How the stepper's scroll view should respond to user input.
  ///
  /// For example, determines how the scroll view continues to
  /// animate after the user stops dragging the scroll view.
  ///
  /// If the stepper is contained within another scrollable it
  /// can be helpful to set this property to [ClampingScrollPhysics].
  final ScrollPhysics? physics;

  /// The type of stepper that determines the layout. In the case of
  /// [DynamicStepperType.horizontal], the content of the current step is displayed
  /// underneath as opposed to the [DynamicStepperType.vertical] case where it is
  /// displayed in-between.
  final DynamicStepperType type;

  /// The index into [steps] of the current step whose content is displayed.
  final int currentStep;

  /// The callback called when a step is tapped, with its index passed as
  /// an argument.
  final ValueChanged<int>? onStepTapped;

  /// The callback called when a step is deleted, with its index passed as
  /// an argument.
  final ValueChanged<int>? onStepDelete;

  /// The callback called when a step is dragged, with its index passed as
  /// an argument.
  final Function(int oldIndex, int newIndex)? onStepDragged;

  /// The callback called when the 'continue' button is tapped.
  ///
  /// If null, the 'continue' button will be disabled.
  final VoidCallback? onStepContinue;

  /// The callback called when the 'cancel' button is tapped.
  ///
  /// If null, the 'cancel' button will be disabled.
  final VoidCallback? onStepCancel;

  /// The callback for creating custom controls.
  ///
  /// If null, the default controls from the current theme will be used.
  ///
  /// This callback which takes in a context and a [DynamicControlsDetails] object, which
  /// contains step information and two functions: [onStepContinue] and [onStepCancel].
  /// These can be used to control the stepper. For example, reading the
  /// [DynamicControlsDetails.currentStep] value within the callback can change the text
  /// of the continue or cancel button depending on which step users are at.
  ///
  /// {@tool dartpad}
  /// Creates a stepper control with custom buttons.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///   return Stepper(
  ///     controlsBuilder:
  ///       (BuildContext context, ControlsDetails details) {
  ///          return Row(
  ///            children: <Widget>[
  ///              TextButton(
  ///                onPressed: details.onStepContinue,
  ///                child: Text('Continue to Step ${details.stepIndex + 1}'),
  ///              ),
  ///              TextButton(
  ///                onPressed: details.onStepCancel,
  ///                child: Text('Back to Step ${details.stepIndex - 1}'),
  ///              ),
  ///            ],
  ///          );
  ///       },
  ///     steps: const <Step>[
  ///       Step(
  ///         title: Text('A'),
  ///         content: SizedBox(
  ///           width: 100.0,
  ///           height: 100.0,
  ///         ),
  ///       ),
  ///       Step(
  ///         title: Text('B'),
  ///         content: SizedBox(
  ///           width: 100.0,
  ///           height: 100.0,
  ///         ),
  ///       ),
  ///     ],
  ///   );
  /// }
  /// ```
  /// ** See code in examples/api/lib/material/stepper/stepper.controls_builder.0.dart **
  /// {@end-tool}
  final ControlsWidgetBuilder? controlsBuilder;

  /// The elevation of this stepper's [Material] when [type] is [DynamicStepperType.horizontal].
  final double? elevation;

  /// custom margin on vertical stepper.
  final EdgeInsetsGeometry? margin;

  final EdgeInsetsGeometry? horizontalMargin;

  @override
  State<DynamicStepper> createState() => _DynamicStepperState();
}

class _DynamicStepperState extends State<DynamicStepper>
    with TickerProviderStateMixin {
  late List<GlobalKey> _keys;
  final Map<int, DynamicStepState> _oldStates = <int, DynamicStepState>{};
  late List<DynamicStep> _steps;
  late int _currentStep;

  @override
  void initState() {
    super.initState();
    _steps = widget.steps;
    _currentStep = widget.currentStep;
    _keys = List<GlobalKey>.generate(
      _steps.length,
      (int i) => GlobalKey(),
    );

    for (int i = 0; i < _steps.length; i += 1) {
      _oldStates[i] = _steps[i].state;
    }
  }

  @override
  void didUpdateWidget(DynamicStepper oldWidget) {
    super.didUpdateWidget(oldWidget);

    for (int i = 0; i < oldWidget.steps.length; i += 1) {
      _oldStates[i] = oldWidget.steps[i].state;
    }
  }

  bool _isFirst(int index) {
    return index == 0;
  }

  bool _isLast(int index) {
    return _steps.length - 1 == index;
  }

  bool _isCurrent(int index) {
    return _currentStep == index;
  }

  bool _isDark() {
    return Theme.of(context).brightness == Brightness.dark;
  }

  bool _isLabel() {
    for (final DynamicStep step in _steps) {
      if (step.label != null) {
        return true;
      }
    }
    return false;
  }

  Widget _buildLine(bool visible) {
    return Container(
      width: visible ? 1.0 : 0.0,
      height: 16.0,
      color: const Color(0xFFCCCCCC),
    );
  }

  Widget _buildCircleChild(int index, bool oldState) {
    final DynamicStepState state =
        oldState ? _oldStates[index]! : _steps[index].state;
    final bool isDarkActive = _isDark() && _steps[index].isActive;
    switch (state) {
      case DynamicStepState.indexed:
      case DynamicStepState.disabled:
        return Text(
          '${index + 1}',
          style: isDarkActive
              ? _kStepStyle.copyWith(color: Colors.black87)
              : _kStepStyle,
        );
      case DynamicStepState.editing:
        return Icon(
          Icons.edit,
          color: isDarkActive ? _kCircleActiveDark : _kCircleActiveLight,
          size: 18.0,
        );
      case DynamicStepState.complete:
        return Icon(
          Icons.check,
          color: isDarkActive ? _kCircleActiveDark : _kCircleActiveLight,
          size: 18.0,
        );
      case DynamicStepState.error:
        return const Text('!', style: _kStepStyle);
      case DynamicStepState.action:
        return widget.actionIcon ??
            Icon(
              Icons.add,
              color: isDarkActive ? _kCircleActiveDark : _kCircleActiveLight,
              size: 18.0,
            );
    }
  }

  Color _circleColor(int index) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    if (!_isDark()) {
      return _steps[index].isActive
          ? colorScheme.primary
          : colorScheme.onSurface.withOpacity(0.38);
    } else {
      return _steps[index].isActive
          ? colorScheme.secondary
          : colorScheme.surface;
    }
  }

  Widget _buildCircle(int index, bool oldState) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      width: _kStepSize,
      height: _kStepSize,
      child: AnimatedContainer(
        curve: Curves.fastOutSlowIn,
        duration: kThemeAnimationDuration,
        decoration: BoxDecoration(
          color: _circleColor(index),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: _buildCircleChild(
              index, oldState && _steps[index].state == DynamicStepState.error),
        ),
      ),
    );
  }

  Widget _buildTriangle(int index, bool oldState) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      width: _kStepSize,
      height: _kStepSize,
      child: Center(
        child: SizedBox(
          width: _kStepSize,
          height: _kTriangleHeight,
          // Height of 24dp-long-sided equilateral triangle.
          child: CustomPaint(
            painter: _TrianglePainter(
              color: _isDark() ? _kErrorDark : _kErrorLight,
            ),
            child: Align(
              alignment: const Alignment(0.0, 0.8),
              // 0.8 looks better than the geometrical 0.33.
              child: _buildCircleChild(index,
                  oldState && _steps[index].state != DynamicStepState.error),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(int index) {
    if (_steps[index].state != _oldStates[index]) {
      return AnimatedCrossFade(
        firstChild: _buildCircle(index, true),
        secondChild: _buildTriangle(index, true),
        firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
        secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
        sizeCurve: Curves.fastOutSlowIn,
        crossFadeState: _steps[index].state == DynamicStepState.error
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        duration: kThemeAnimationDuration,
      );
    } else {
      if (_steps[index].state != DynamicStepState.error) {
        return _buildCircle(index, false);
      } else {
        return _buildTriangle(index, false);
      }
    }
  }

  Widget _buildVerticalControls(int stepIndex) {
    if (widget.controlsBuilder != null) {
      return widget.controlsBuilder!(
        context,
        DynamicControlsDetails(
          currentStep: _currentStep,
          onStepContinue: widget.onStepContinue,
          onStepCancel: widget.onStepCancel,
          stepIndex: stepIndex,
        ),
      );
    }

    final Color cancelColor;
    switch (Theme.of(context).brightness) {
      case Brightness.light:
        cancelColor = Colors.black54;
        break;
      case Brightness.dark:
        cancelColor = Colors.white70;
        break;
    }

    final ThemeData themeData = Theme.of(context);
    final ColorScheme colorScheme = themeData.colorScheme;
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);

    const OutlinedBorder buttonShape = RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)));
    const EdgeInsets buttonPadding = EdgeInsets.symmetric(horizontal: 16.0);

    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints.tightFor(height: 48.0),
        child: Row(
          // The Material spec no longer includes a Stepper widget. The continue
          // and cancel button styles have been configured to match the original
          // version of this widget.
          children: <Widget>[
            TextButton(
              onPressed: widget.onStepContinue,
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> states) {
                  return states.contains(WidgetState.disabled)
                      ? null
                      : (_isDark()
                          ? colorScheme.onSurface
                          : colorScheme.onPrimary);
                }),
                backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> states) {
                  return _isDark() || states.contains(WidgetState.disabled)
                      ? null
                      : colorScheme.primary;
                }),
                padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
                    buttonPadding),
                shape:
                    const WidgetStatePropertyAll<OutlinedBorder>(buttonShape),
              ),
              child: Text(localizations.continueButtonLabel),
            ),
            Container(
              margin: const EdgeInsetsDirectional.only(start: 8.0),
              child: TextButton(
                onPressed: widget.onStepCancel,
                style: TextButton.styleFrom(
                  foregroundColor: cancelColor,
                  padding: buttonPadding,
                  shape: buttonShape,
                ),
                child: Text(localizations.cancelButtonLabel),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _titleStyle(int index) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;

    switch (_steps[index].state) {
      case DynamicStepState.action:
      case DynamicStepState.indexed:
      case DynamicStepState.editing:
      case DynamicStepState.complete:
        return textTheme.bodyLarge!;
      case DynamicStepState.disabled:
        return textTheme.bodyLarge!.copyWith(
          color: _isDark() ? _kDisabledDark : _kDisabledLight,
        );
      case DynamicStepState.error:
        return textTheme.bodyLarge!.copyWith(
          color: _isDark() ? _kErrorDark : _kErrorLight,
        );
    }
  }

  TextStyle _subtitleStyle(int index) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;

    switch (_steps[index].state) {
      case DynamicStepState.action:
      case DynamicStepState.indexed:
      case DynamicStepState.editing:
      case DynamicStepState.complete:
        return textTheme.bodySmall!;
      case DynamicStepState.disabled:
        return textTheme.bodySmall!.copyWith(
          color: _isDark() ? _kDisabledDark : _kDisabledLight,
        );
      case DynamicStepState.error:
        return textTheme.bodySmall!.copyWith(
          color: _isDark() ? _kErrorDark : _kErrorLight,
        );
    }
  }

  TextStyle _labelStyle(int index) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;

    switch (_steps[index].state) {
      case DynamicStepState.action:
      case DynamicStepState.indexed:
      case DynamicStepState.editing:
      case DynamicStepState.complete:
        return textTheme.bodyLarge!;
      case DynamicStepState.disabled:
        return textTheme.bodyLarge!.copyWith(
          color: _isDark() ? _kDisabledDark : _kDisabledLight,
        );
      case DynamicStepState.error:
        return textTheme.bodyLarge!.copyWith(
          color: _isDark() ? _kErrorDark : _kErrorLight,
        );
    }
  }

  Widget _buildHeaderText(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (_steps[index].title != null)
          AnimatedDefaultTextStyle(
            style: _titleStyle(index),
            duration: kThemeAnimationDuration,
            curve: Curves.fastOutSlowIn,
            child: _steps[index].title!,
          ),
        if (_steps[index].subtitle != null)
          Container(
            margin: const EdgeInsets.only(top: 2.0),
            child: AnimatedDefaultTextStyle(
              style: _subtitleStyle(index),
              duration: kThemeAnimationDuration,
              curve: Curves.fastOutSlowIn,
              child: _steps[index].subtitle!,
            ),
          ),
      ],
    );
  }

  Widget _buildLabelText(int index) {
    if (_steps[index].label != null) {
      return AnimatedDefaultTextStyle(
        style: _labelStyle(index),
        duration: kThemeAnimationDuration,
        child: _steps[index].label!,
      );
    }
    return const SizedBox();
  }

  Widget _buildVerticalHeader(int index) {
    return Container(
      margin: widget.horizontalMargin ??
          const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              // Line parts are always added in order for the ink splash to
              // flood the tips of the connector lines.
              if (!widget.isTitleOnlyStepper) ...[
                _buildLine(!_isFirst(index)),
                _buildIcon(index),
              ],

              if (widget.isTitleOnlyStepper) ...[
                widget.steps[index].stepperIcon ?? _buildHeaderText(index)
              ],
              if (!widget.isTitleOnlyStepper) ...[
                _buildLine(!_isLast(index)),
              ],
            ],
          ),
          if (!widget.isTitleOnlyStepper) ...[
            Expanded(
              child: Container(
                margin: const EdgeInsetsDirectional.only(start: 12.0),
                child: _buildHeaderText(index),
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildVerticalBody(int index) {
    return Stack(
      children: <Widget>[
        if (widget.steps[index].stepperContentWidgetBuilder(index) != null)
          PositionedDirectional(
            start: 24.0,
            top: widget.isTitleOnlyStepper ? 30.0 : 50,
            bottom: 0.0,
            child: SizedBox(
              width: 24.0,
              child: Center(
                child: SizedBox(
                  width: _isLast(index) ? 0.0 : 1.0,
                  child: Container(
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
            ),
          ),
        widget.alwaysShowContent
            ? _secondChild(index)
            : AnimatedCrossFade(
                firstChild: Container(height: 0.0),
                secondChild: _secondChild(index),
                firstCurve:
                    const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
                secondCurve:
                    const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
                sizeCurve: Curves.fastOutSlowIn,
                crossFadeState: _isCurrent(index)
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: kThemeAnimationDuration,
              ),
      ],
    );
  }

  Container _secondChild(int index) {
    return Container(
      margin: widget.margin ??
          const EdgeInsetsDirectional.only(
            start: 60.0,
            top: 24,
            end: 24.0,
            bottom: 24.0,
          ),
      child: Column(
        children: <Widget>[
          widget.steps[index].stepperContentWidgetBuilder(index) ??
              const SizedBox(),
          ///TODO: @Jiten: check for controls here
          // _buildVerticalControls(index),
        ],
      ),
    );
  }

  Widget _buildVertical() {
    return RefreshIndicator(
      notificationPredicate: widget.enableRefresh ? (_) => true : (_) => false,
      onRefresh: widget.onRefresh ?? () async {},
      child: CustomScrollView(
        physics: widget.physics,
        slivers: [
          if (widget.firstWidget != null)
            SliverToBoxAdapter(
              child: widget.firstWidget!,
            ),
          if (widget.toggleWidget != null)
            SliverToBoxAdapter(
              child: Align(
                alignment: Alignment.centerRight,
                child: widget.toggleWidget!,
              ),
            ),
          SliverReorderableList(
              proxyDecorator: (child, index, animation) {
                return _proxyDecoratorBuilder(
                  animation,
                  child,
                );
              },
              itemCount: _steps.length,
              onReorder: (int oldIndex, int newIndex) {
                // Adjust newIndex for the ReorderableListView's index shift
                if (oldIndex < newIndex) newIndex--;

                if (!widget.dragLastWidget &&
                    (_isLast(oldIndex) || _isLast(newIndex))) {
                  return;
                }

                // Reorder items
                setState(() {
                  _steps.insert(newIndex, _steps.removeAt(oldIndex));
                  _currentStep = newIndex;
                });

                // Notify parent widget if a drag event occurred
                widget.onStepDragged?.call(oldIndex, newIndex);
              },
              itemBuilder: (BuildContext context, int i) {
                return buildReorderableItem(i);
              })
        ],
      ),
    );
  }

  AnimatedBuilder _proxyDecoratorBuilder(
      Animation<double> animation, Widget child) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        final double animValue = Curves.easeInOut.transform(animation.value);
        final double elevation = lerpDouble(0, 6, animValue)!;
        return Material(
          elevation: elevation,
          child: child,
        );
      },
      child: child,
    );
  }

  ///Creates an reorderable item with slidable if [enableSwipeAction] is used
  /// Otherwise  creates item without slidable
  dynamic buildReorderableItem(int i) {
    if (widget.enableSwipeAction) {
      return Material(
        key: ObjectKey(_steps[i]),
        child: CustomDragStartListener(
          enabled: widget.enableDrag,
          index: i,
          child: Slidable(
            enabled:
                widget.dragLastWidget ? widget.dragLastWidget : !_isLast(i),
            endActionPane: ActionPane(
              dragDismissible: false,
              motion: const ScrollMotion(),
              children: [
                CustomSlidableAction(
                  padding: EdgeInsets.zero,
                  onPressed: (context) {
                    widget.onStepDelete?.call(i);
                  },
                  foregroundColor: Colors.transparent,
                  backgroundColor: widget.backgroundColor ?? Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        CupertinoIcons.delete,
                        color: Color(0XFFEB5757),
                        size: 30,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Delete',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: const Color(0XFFEB5757)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            child: Container(
              color: widget.backgroundColor ?? Colors.white70,
              child: Stack(
                children: <Widget>[
                  if (_steps[i].title != null)
                    Column(
                      children: [
                        InkWell(
                          onTap: _steps[i].state != DynamicStepState.disabled
                              ? () {
                                  // // In the vertical case we need to scroll to the newly tapped
                                  // // step.
                                  // Scrollable.ensureVisible(
                                  //   _keys[i].currentContext!,
                                  //   curve: Curves.fastOutSlowIn,
                                  //   duration:
                                  //       kThemeAnimationDuration,
                                  // );

                                  widget.onStepTapped?.call(i);
                                }
                              : null,
                          canRequestFocus:
                              _steps[i].state != DynamicStepState.disabled,
                          child: _buildVerticalHeader(i),
                        ),
                        if (_isLast(i) && widget.lastWidget != null) ...[
                          widget.lastWidget!
                        ]
                      ],
                    )
                  else
                    _buildVerticalHeader(i),
                  _buildVerticalBody(i),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return _stepperContentWidget(i);
    }
  }

  Widget _stepperContentWidget(int i) {
    return CustomDragStartListener(
      enabled: widget.enableDrag,
      key: ObjectKey(_steps[i]),
      index: i,
      child: Container(
        color: widget.backgroundColor ?? Colors.white60,
        child: Stack(
          children: <Widget>[
            // if (_steps[i].title != null)
            //   InkWell(
            //     onTap: _steps[i].state != DynamicStepState.disabled
            //         ? () {
            //             // In the vertical case we need to scroll to the newly tapped
            //             // step.
            //             Scrollable.ensureVisible(
            //               _keys[i].currentContext!,
            //               curve: Curves.fastOutSlowIn,
            //               duration: kThemeAnimationDuration,
            //             );
            //
            //             widget.onStepTapped?.call(i);
            //           }
            //         : null,
            //     canRequestFocus: _steps[i].state != DynamicStepState.disabled,
            //     child: _buildVerticalHeader(i),
            //   )
            // else
            _buildVerticalBody(i),
            _buildVerticalHeader(i),

          ],
        ),
      ),
    );
  }

  Widget _buildHorizontal() {
    final List<Widget> children = <Widget>[
      for (int i = 0; i < _steps.length; i += 1) ...<Widget>[
        InkResponse(
          onTap: _steps[i].state != DynamicStepState.disabled
              ? () {
                  widget.onStepTapped?.call(i);
                }
              : null,
          canRequestFocus: _steps[i].state != DynamicStepState.disabled,
          child: Row(
            children: <Widget>[
              SizedBox(
                height: _isLabel() ? 104.0 : 72.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (_steps[i].label != null)
                      const SizedBox(
                        height: 24.0,
                      ),
                    Center(child: _buildIcon(i)),
                    if (_steps[i].label != null)
                      SizedBox(
                        height: 24.0,
                        child: _buildLabelText(i),
                      ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsetsDirectional.only(start: 12.0),
                child: _buildHeaderText(i),
              ),
            ],
          ),
        ),
        if (!_isLast(i))
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              height: 1.0,
              color: Colors.grey.shade400,
            ),
          ),
      ],
    ];

    final List<Widget> stepPanels = <Widget>[];
    for (int i = 0; i < _steps.length; i += 1) {
      stepPanels.add(
        Visibility(
          maintainState: true,
          visible: i == _currentStep,
          child: _steps[i].content ?? const SizedBox(),
        ),
      );
    }

    return Column(
      children: <Widget>[
        Material(
          elevation: widget.elevation ?? 2,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: children,
            ),
          ),
        ),
        Expanded(
          child: ListView(
            physics: widget.physics,
            padding: const EdgeInsets.all(24.0),
            children: <Widget>[
              AnimatedSize(
                curve: Curves.fastOutSlowIn,
                duration: kThemeAnimationDuration,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: stepPanels),
              ),
              _buildVerticalControls(_currentStep),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    assert(debugCheckHasMaterialLocalizations(context));
    assert(() {
      if (context.findAncestorWidgetOfExactType<DynamicStepper>() != null) {
        throw FlutterError(
          'Steppers must not be nested.\n'
          'The material specification advises that one should avoid embedding '
          'steppers within steppers. '
          'https://material.io/archive/guidelines/components/steppers.html#steppers-usage',
        );
      }
      return true;
    }());
    switch (widget.type) {
      case DynamicStepperType.vertical:
        return _buildVertical();
      case DynamicStepperType.horizontal:
        return _buildHorizontal();
    }
  }
}

// Paints a triangle whose base is the bottom of the bounding rectangle and its
// top vertex the middle of its top.
class _TrianglePainter extends CustomPainter {
  _TrianglePainter({
    required this.color,
  });

  final Color color;

  @override
  bool hitTest(Offset point) => true; // Hitting the rectangle is fine enough.

  @override
  bool shouldRepaint(_TrianglePainter oldPainter) {
    return oldPainter.color != color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final double base = size.width;
    final double halfBase = size.width / 2.0;
    final double height = size.height;
    final List<Offset> points = <Offset>[
      Offset(0.0, height),
      Offset(base, height),
      Offset(halfBase, 0.0),
    ];

    canvas.drawPath(
      Path()..addPolygon(points, true),
      Paint()..color = color,
    );
  }
}
