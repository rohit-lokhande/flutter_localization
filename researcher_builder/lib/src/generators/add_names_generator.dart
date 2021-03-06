import 'dart:async';
import 'dart:math';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart' show BuildStep;
import 'package:merging_builder/merging_builder.dart';
import 'package:source_gen/source_gen.dart';

import '../add_names.dart';
import 'class_defination.dart';

class AddNamesGenerator extends MergingGenerator<ClassDefinition?, AddNames> {
  @override
  ClassDefinition? generateStreamItemForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is ClassElement) {
      return ClassDefinition(
          displayName: element.displayName,
          classPath: element.source.uri.toString(),
          route: annotation.objectValue.getField('route')!.toStringValue(),
          constructors: element.constructors,
          fields: element.fields);
    }
    return null;
  }

  /// Returns the merged content.
  @override
  FutureOr<String> generateMergedContent(
      Stream<ClassDefinition?> stream) async {
    final b = StringBuffer();
    b.writeln("import 'package:flutter/material.dart';");
    List<ClassDefinition?> classes = [];
    await for (final values in stream) {
      classes.add(values);
      b.writeln("import '${values!.classPath}';");
    }
    b.writeln('class AppRoutes {');
    for (final value in classes) {
      if (value!.fields!.isNotEmpty) {
        b.writeln(
            'static void navigateTo${value.constructors!.first.displayName}(BuildContext context,');

        List<String> constructorParameters =
            _getConstructorParameters(value.constructors!.first.parameters);
        b.write("${constructorParameters.join(",")}");

        b.write("){");

        b.writeln(
            "Navigator.push(context,MaterialPageRoute(builder: (context) =>  ${value.constructors!.first.displayName}(");
        List<String> parameters =
            _getParameterList(value.constructors!.first.parameters);

        b.write("${parameters.join(",")}");

        b.write(')),);');

        b.writeln('}');
      } else {

        b.writeln(
            'static void navigateTo${value.constructors!.first.displayName}(BuildContext context,');
        b.write("){");

        b.writeln(
            "Navigator.push(context,MaterialPageRoute(builder: (context) =>  ${value.constructors!.first.displayName}(");

        b.write(')),);');

        b.writeln('}');


      }
    }
    b.writeln('}');

    return b.toString();
  }

  List<String> _getParameterList(List<ParameterElement> parameterElement) {
    List<String> parameters = [];

    parameterElement.forEach((e) {
      if(e.name.toLowerCase() != 'key') {
        if(e.isOptional){
          parameters.add("${e.name}: ${e.name}");
        }else if(e.isRequiredNamed){
          parameters.add("${e.name}: ${e.name}");
        }else{
          parameters.add(e.name);
        }
      }
    });

    return parameters;
  }

  List<String> _getConstructorParameters(List<ParameterElement> parameters) {
    List<String> constructorParameters = [];
    parameters.forEach((e) {
      if (e.type.isDartCoreString && e.isOptional) {
        constructorParameters.add('String? ${e.displayName}');
      } else if (e.type.isDartCoreInt) {
        constructorParameters.add('int ${e.displayName}');
      } else if (e.type.isDartCoreBool) {
        constructorParameters.add('bool ${e.displayName}');
      } else if (e.type.isDartCoreDouble) {
        constructorParameters.add('double ${e.displayName}');
      } else if (e.type.isDartCoreList || e.type.isDartCoreObject) {
        constructorParameters.add(
            '${e.type.getDisplayString(withNullability: false)} ${e.displayName}');
      }
    });

    return constructorParameters;
  }
}
