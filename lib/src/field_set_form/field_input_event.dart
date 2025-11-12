part of 'field_set_form.dart';

abstract class FieldSetFormInputEvent extends FieldSetFormEvent {
  const FieldSetFormInputEvent({required this.fieldInput, required this.stepId});
  final FieldInput fieldInput;
  final Enum stepId;
  @override
  List<Object?> get props => [fieldInput, stepId];
}
