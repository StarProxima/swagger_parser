import '../../utils/case_utils.dart';
import '../../utils/type_utils.dart';
import '../../utils/utils.dart';
import '../models/universal_data_class.dart';

/// Provides template for generating kotlin enum DTO
String kotlinEnumDtoTemplate(
  UniversalEnumClass dataClass, {
  required bool markFileAsGenerated,
}) {
  return '''
${generatedFileComment(markFileAsGenerated: markFileAsGenerated)}import com.squareup.moshi.Json
import com.squareup.moshi.JsonClass

@JsonClass(generateAdapter = true)
enum class ${dataClass.name.toPascal} {${_parameters(dataClass)}
}
''';
}

String _parameters(UniversalEnumClass dataClass) => dataClass.items
    .map(
      (e) =>
          '${dataClass.type != 'string' || prefixForEnumItems(dataClass.type, e, dart: false) != e ? '\n    @Json("$e")' : ''}\n    '
          '${prefixForEnumItems(dataClass.type, e, dart: false)},',
    )
    .join();
