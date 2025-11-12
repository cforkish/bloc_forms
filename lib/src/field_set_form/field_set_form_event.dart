part of 'field_set_form.dart';

abstract class FieldSetFormEvent extends Equatable {
  const FieldSetFormEvent();
}

class FieldSetFormBaseEvent extends FieldSetFormEvent {
  const FieldSetFormBaseEvent();

  @override
  List<Object?> get props => [];
}

class FieldSetFormReset extends FieldSetFormBaseEvent {
  const FieldSetFormReset();
}

class FieldSetFormNextStep extends FieldSetFormBaseEvent {
  const FieldSetFormNextStep();
}

class FieldSetFormPreviousStep extends FieldSetFormBaseEvent {
  const FieldSetFormPreviousStep();
}

class FieldSetFormSubmit extends FieldSetFormBaseEvent {
  const FieldSetFormSubmit();
}
