import 'package:equatable/equatable.dart';

import '../field_set/field_set.dart';

part 'field_input.dart';
part 'field_input_event.dart';
part 'field_input_set.dart';
part 'field_set_form_event.dart';
part 'field_set_form_step.dart';

enum FormSubmissionStatus { initial, inProgress, success, failure, cancelled }

class FieldSetForm<T extends FieldSet> extends Equatable {
  const FieldSetForm._({
    required this.steps,
    required this.currentStepId,
    this.submissionStatus = FormSubmissionStatus.initial,
    this.submissionError,
    this.output,
  });

  FieldSetForm.fromStepList({required List<FieldSetFormStep> steps, required Enum currentStepId})
    : this._(
        steps: Map.unmodifiable({for (var step in steps) step.stepId: step}),
        currentStepId: currentStepId,
        submissionStatus: FormSubmissionStatus.initial,
        submissionError: null,
        output: null,
      );

  FieldSetForm.fromStepMap({
    required Map<Enum, FieldSetFormStep> steps,
    required Enum currentStepId,
  }) : this._(
         steps: Map.unmodifiable(steps),
         currentStepId: currentStepId,
         submissionStatus: FormSubmissionStatus.initial,
         submissionError: null,
         output: null,
       );

  final Map<Enum, FieldSetFormStep> steps;
  final Enum currentStepId;
  FieldSetFormStep get currentStep => steps[currentStepId]!;
  final FormSubmissionStatus submissionStatus;
  final String? submissionError;
  final T? output;

  bool get canGoBack => currentStepId.index > 0;
  bool get canGoForward => currentStepId.index < steps.length - 1;

  @override
  List<Object?> get props => [steps, currentStepId, submissionStatus, submissionError, output];

  FieldSetForm<T> goBack() =>
      copyWith(currentStepId: steps.keys.elementAt(currentStepId.index - 1));
  FieldSetForm<T> goForward() =>
      copyWith(currentStepId: steps.keys.elementAt(currentStepId.index + 1));

  bool get isValid => steps.values.every((step) => step.isValid);

  String? get validationErrorMessage {
    final errors = steps.values.map((step) => step.validationErrorMessage).nonNulls.join('\n');
    return errors.isEmpty ? null : errors;
  }

  FieldSetForm<T> copyWithInputEvent(FieldSetFormInputEvent event) {
    final newStep = steps[event.stepId]!.copyWith(inputs: [event.fieldInput]);
    return FieldSetForm<T>.fromStepMap(
      steps: {...steps, event.stepId: newStep},
      currentStepId: event.stepId,
    );
  }

  FieldSetForm<T> copyWith({
    Enum? currentStepId,
    FormSubmissionStatus? submissionStatus,
    String? submissionError,
    T? output,
  }) => FieldSetForm._(
    steps: steps,
    currentStepId: currentStepId ?? this.currentStepId,
    submissionStatus: submissionStatus ?? this.submissionStatus,
    submissionError: submissionError ?? this.submissionError,
    output: output ?? this.output,
  );
}
