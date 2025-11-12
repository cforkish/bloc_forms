import 'package:flutter_bloc/flutter_bloc.dart';

import '../field_set/field_set.dart';
import '../field_set_form/field_set_form.dart';

abstract class FieldSetFormBloc<T extends FieldSet, S extends FieldSetForm<T>>
    extends Bloc<FieldSetFormEvent, S> {
  FieldSetFormBloc(super.initialState) {
    on<FieldSetFormInputEvent>(onInputEvent);
    on<FieldSetFormReset>(onReset);
    on<FieldSetFormNextStep>(onNextStep);
    on<FieldSetFormPreviousStep>(onPreviousStep);
    on<FieldSetFormSubmit>(onSubmit);
  }

  S get initialState;

  void onInputEvent(FieldSetFormInputEvent event, Emitter<S> emit) {
    final nextState = state.copyWithInputEvent(event) as S?;
    if (nextState != null) {
      emit(nextState);
    }
  }

  void onReset(FieldSetFormReset event, Emitter<S> emit) {
    emit(initialState);
  }

  void onNextStep(FieldSetFormNextStep event, Emitter<S> emit) {
    if (state.canGoForward) {
      emit(state.goForward() as S);
    }
  }

  void onPreviousStep(FieldSetFormPreviousStep event, Emitter<S> emit) {
    if (state.canGoBack) {
      emit(state.goBack() as S);
    }
  }

  Future<void> onSubmit(FieldSetFormSubmit event, Emitter<S> emit) async {
    if (!state.isValid) {
      emit(
        state.copyWith(
              submissionStatus: FormSubmissionStatus.failure,
              submissionError: state.validationErrorMessage,
            )
            as S,
      );
      return;
    }
    emit(state.copyWith(submissionStatus: FormSubmissionStatus.inProgress) as S);

    try {
      T? output = await buildOutput();
      emit(state.copyWith(output: output, submissionStatus: FormSubmissionStatus.success) as S);
    } catch (e) {
      emit(
        state.copyWith(
              submissionError: e.toString(),
              submissionStatus: FormSubmissionStatus.failure,
            )
            as S,
      );
    }
  }

  Future<T?> buildOutput();
}
