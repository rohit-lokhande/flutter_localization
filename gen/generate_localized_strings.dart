import 'dart:convert';
import 'dart:io';

import 'package:mustache_template/mustache.dart';

main() async {
  var source = '''
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:app_localization/src/localization/index.dart';
import 'package:app_localization/src/navigation_service.dart';

class LocalizedStrings {

static String _find(String key) {
return AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!.find(key);
}

{{# strings }}
static String get {{key}} => _find('{{value}}');
{{/ strings }}

}
''';

  var template = Template(source, name: 'localized_strings.dart');

  File readFile = File('resources/lang/en.json');
  if (await readFile.exists()) {

    String data = await readFile.readAsString();
    Map<String, dynamic> _result = json.decode(data);

    List<Map<String, String>> lines = [];

    _result.forEach((key, value) {
      if (key.isNotEmpty) {
        lines.add({'key': camelCase(key), 'value': key});
      }
    });

    var output = template.renderString({'strings': lines});

    File fileToWrite = File('lib/src/config/${template.name!}');
    if (await fileToWrite.exists() == false) {
      fileToWrite.create();
    }
    await fileToWrite.writeAsString(output, mode: FileMode.write);
  }
}

String camelCase(String subject) {
  List<String> _splittedString = subject.split("_");

  return _splittedString[0].toLowerCase() +
      _splittedString
          .sublist(1)
          .map((String x) => capitalize(x, true))
          .toList()
          .join('');
}

String capitalize(String subject, [bool lowerRest = false]) {
  if (subject.isEmpty) {
    return '';
  }

  if (lowerRest) {
    return subject[0].toUpperCase() + subject.substring(1).toLowerCase();
  } else {
    return subject[0].toUpperCase() + subject.substring(1);
  }
}
