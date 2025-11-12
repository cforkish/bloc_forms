part of 'field_set_form.dart';

class FieldSetFormStep extends FieldInputSet {
  FieldSetFormStep.fromMap(super.inputs, {required this.stepId}) : super.fromMap();
  FieldSetFormStep.fromList(super.inputs, {required this.stepId}) : super.fromList();

  final Enum stepId;

  @override
  FieldSetFormStep copyWith({List<FieldInput>? inputs}) {
    if (inputs == null || inputs.isEmpty) {
      return this;
    }

    return FieldSetFormStep.fromMap(
      mergeFields(newFields: inputs, existingFields: this.inputs) as Map<String, FieldInput>,
      stepId: stepId,
    );
  }

  @override
  List<Object?> get props => [...super.props, stepId];
}
