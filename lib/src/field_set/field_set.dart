import 'package:equatable/equatable.dart';

part 'field.dart';
part 'field_set_error.dart';
part 'field_set_object.dart';
part 'util.dart';

class FieldSet extends Equatable {
  const FieldSet._(this.fields);

  FieldSet.fromMap(Map<String, Field> fields) : this._(Map.unmodifiable(fields));
  FieldSet.fromList(List<Field> fields)
    : this._(Map.unmodifiable({for (var field in fields) field.name: field}));

  final Map<String, Field> fields;

  FieldSet copyWith({List<Field>? fields}) {
    if (fields == null || fields.isEmpty) {
      return this;
    }
    return FieldSet.fromMap(mergeFields(newFields: fields, existingFields: this.fields));
  }

  @override
  List<Object?> get props => [fields];
}
