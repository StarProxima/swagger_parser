import 'dart:io';

import '../generator/models/generation_statistics.dart';
import '../generator/models/open_api_info.dart';
import '../generator/models/programming_language.dart';
import '../generator/models/universal_data_class.dart';
import '../generator/models/universal_type.dart';
import '../utils/case_utils.dart';

const _green = '\x1B[32m';
// ignore: unused_element
const _yellow = '\x1B[33m';
const _red = '\x1B[31m';
const _reset = '\x1B[0m';

/// Provides imports as String from list of imports
String dartImports({required Set<String> imports, String? pathPrefix}) {
  if (imports.isEmpty) {
    return '';
  }
  return '\n${imports.map((import) => "import '${pathPrefix ?? ''}${import.toSnake}.dart';").join('\n')}\n';
}

/// Provides class description
String descriptionComment(
  String? description, {
  bool tabForFirstLine = true,
  String tab = '',
  String end = '',
}) {
  if (description == null || description.isEmpty) {
    return '';
  }

  final lineStart = RegExp('^(.*)', multiLine: true);
  final result = description.replaceAllMapped(
    lineStart,
    (m) => '${!tabForFirstLine && m.start == 0 ? '' : tab}/// ${m[1]}',
  );

  return '$result\n$end';
}

/// Replace all not english letters in text
String? replaceNotEnglishLetter(String? text) {
  if (text == null || text.isEmpty) {
    return null;
  }
  final lettersRegex = RegExp('[^a-zA-Z]');
  return text.replaceAll(lettersRegex, ' ');
}

/// Specially for File import
String ioImport(UniversalComponentClass dataClass) => dataClass.parameters.any(
      (p) => p.toSuitableType(ProgrammingLanguage.dart).startsWith('File'),
    )
        ? "import 'dart:io';\n\n"
        : '';

String generatedFileComment({
  required bool markFileAsGenerated,
  bool ignoreLints = true,
}) =>
    markFileAsGenerated
        ? ignoreLints
            ? '$_generatedCodeComment$_ignoreLintsComment\n'
            : '$_generatedCodeComment\n'
        : '';

const _generatedCodeComment = r'''
//  _  _ ___  ____ _  _     ____ _ _ _ ____ ____ ____ ____ ____     ___  ____ ____ ____ ____ ____ 
//   \/  |  \ |___ |  |     [__  | | | |__| | __ | __ |___ |__/     |__] |__| |__/ [__  |___ |__/ 
//  _/\_ |__/ |___  \/  ___ ___] |_|_| |  | |__] |__] |___ |  \ ___ |    |  | |  \ ___] |___ |  \     
//  
// GENERATED CODE - DO NOT MODIFY BY HAND
''';

const _ignoreLintsComment = '''
// ignore_for_file: type=lint
''';

void introMessage() {
  stdout.writeln(
    '''
  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  ┃                               ┃
  ┃   Welcome to swagger_parser   ┃
  ┃                               ┃
  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
''',
  );
}

void generateMessage() {
  stdout.writeln('Generate...');
}

final _numbersRegExp = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');

String formatNumber(int number) => '$number'.replaceAllMapped(
      _numbersRegExp,
      (match) => '${match[1]} ',
    );

void schemaStatisticsMessage({
  required OpenApiInfo openApi,
  required GenerationStatistics statistics,
  String? name,
}) {
  final version = openApi.version != null ? 'v${openApi.version}' : '';

  var title = name ?? '';
  if (title.length > 80) {
    title = '${title.substring(0, 80)}...';
  }

  stdout.writeln(
    '\n> $title $version: \n'
    '    ${formatNumber(statistics.totalRestClients)} rest clients, '
    '${formatNumber(statistics.totalRequests)} requests, '
    '${formatNumber(statistics.totalDataClasses)} data classes.\n'
    '    ${formatNumber(statistics.totalFiles)} files with ${formatNumber(statistics.totalLines)} lines of code.\n'
    '    ${_green}Success (${statistics.timeElapsed.inMilliseconds / 1000} seconds)$_reset',
  );
}

void schemaFailedMessage({
  required Object error,
  required StackTrace stack,
  String? name,
}) {
  var title = name ?? '';
  if (title.length > 80) {
    title = '${title.substring(0, 80)}...';
  }

  stdout.writeln(
    '\n> $title: \n'
    '    ${_red}Failed to generate files.$_reset\n'
    '    $error\n'
    '    ${stack.toString().replaceAll('\n', '\n    ')}',
  );
}

void summaryStatisticsMessage({
  required int successCount,
  required int schemasCount,
  required GenerationStatistics statistics,
}) {
  stdout.writeln(
    '\nSummary (${statistics.timeElapsed.inMilliseconds / 1000} seconds):\n'
    '${successCount != schemasCount ? '$successCount/$schemasCount' : '$schemasCount'} schemas, '
    '${formatNumber(statistics.totalRestClients)} clients, '
    '${formatNumber(statistics.totalRequests)} requests, '
    '${formatNumber(statistics.totalDataClasses)} data classes.\n'
    '${formatNumber(statistics.totalFiles)} files with ${formatNumber(statistics.totalLines)} lines of code.',
  );
}

void doneMessage({
  required int successSchemasCount,
  required int schemasCount,
}) {
  if (successSchemasCount == 0) {
    stdout.writeln(
      '\n'
      '${_red}The generation was completed with errors.\n'
      'No schemas were generated.$_reset',
    );
  } else if (successSchemasCount != schemasCount) {
    stdout.writeln(
      '\n'
      '${_red}The generation was completed with errors.\n'
      '${schemasCount - successSchemasCount} schemas were not generated.$_reset',
    );
  } else {
    stdout.writeln(
      '\n'
      '${schemasCount > 1 ? _green : ''}The generation was completed successfully. '
      'You can run the generation using build_runner.${schemasCount > 1 ? _reset : ''}',
    );
  }
}

void exitWithError(String message) {
  stderr.writeln('${_red}ERROR: $message$_reset');
  exit(2);
}
