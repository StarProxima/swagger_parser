import '../../utils/case_utils.dart';
import '../../utils/utils.dart';
import '../models/open_api_info.dart';

String dartRootClientTemplate({
  required OpenApiInfo openApiInfo,
  required String name,
  required Set<String> clientsNames,
  required String postfix,
  required bool putClientsInFolder,
  required bool markFileAsGenerated,
}) {
  if (clientsNames.isEmpty) {
    return '';
  }

  name = name.toPascal;

  final title = openApiInfo.title;
  final summary = openApiInfo.summary;
  final description = openApiInfo.description;
  final version = openApiInfo.version;
  final fulldescription = switch ((summary, description)) {
    (null, null) => null,
    (_, null) => summary,
    (null, _) => description,
    (_, _) => '$summary\n\n$description',
  };

  final comment =
      '${title ?? ''}${version != null ? ' `v$version`' : ''}${fulldescription != null ? '\n\n$fulldescription' : ''}';

  return '''
${generatedFileComment(
    markFileAsGenerated: markFileAsGenerated,
  )}import 'package:dio/dio.dart';
${_clientsImport(clientsNames, postfix, putClientsInFolder: putClientsInFolder)}
abstract class I$name {
${_interfaceGetters(clientsNames, postfix)}
}

${descriptionComment(comment)}class $name implements I$name {
  $name({
    required Dio dio,
    required String baseUrl,
  })  : _dio = dio,
        _baseUrl = baseUrl;

  final Dio _dio;
  final String _baseUrl;

${_p(clientsNames, postfix)}

${_r(clientsNames, postfix)}
}
''';
}

String _clientsImport(
  Set<String> imports,
  String postfix, {
  required bool putClientsInFolder,
}) =>
    '\n${imports.map(
          (import) =>
              "import '${putClientsInFolder ? 'clients' : import.toSnake}/"
              "${'${import}_$postfix'.toSnake}.dart';",
        ).join('\n')}\n';

String _interfaceGetters(Set<String> names, String postfix) => names
    .map((n) => '  ${n.toPascal + postfix.toPascal} get ${n.toCamel};')
    .join('\n\n');

String _p(Set<String> names, String postfix) => names
    .map((n) => '  ${n.toPascal + postfix.toPascal}? _${n.toCamel};')
    .join('\n');

String _r(Set<String> names, String postfix) => names
    .map(
      (n) =>
          '  @override\n  ${n.toPascal + postfix.toPascal} get ${n.toCamel} => '
          '_${n.toCamel} ??= ${n.toPascal + postfix.toPascal}(_dio, baseUrl: _baseUrl);',
    )
    .join('\n\n');