part of 'field_set.dart';

Map<String, Field> mergeFields({
  required List<Field> newFields,
  required Map<String, Field> existingFields,
}) {
  for (var field in newFields) {
    if (!existingFields.containsKey(field.name)) {
      throw ArgumentError('Cannot update field "${field.name}": field does not exist in map');
    }
  }
  return {...existingFields, for (var field in newFields) field.name: field};
}
