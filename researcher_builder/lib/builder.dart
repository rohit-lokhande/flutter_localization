import 'package:build/build.dart';
import 'package:merging_builder/merging_builder.dart';
import 'package:researcher_builder/src/generators/class_defination.dart';

import 'src/generators/add_names_generator.dart';

/// Defines a merging builder.
/// Honours the options: `input_files`, `output_file`, `header`, `footer`,
/// and `sort_assets` that can be set in `build.yaml`.
Builder addNamesBuilder(BuilderOptions options) {
  final defaultOptions = BuilderOptions({
    'input_files': 'lib/*.dart',
    'output_file': 'lib/output.dart',
    'sort_assets': true,
  });

  // Apply user set options.
  options = defaultOptions.overrideWith(options);
  return MergingBuilder<ClassDefinition?, LibDir>(
    generator: AddNamesGenerator(),
    inputFiles: options.config['input_files'],
    outputFile: options.config['output_file'],
    sortAssets: options.config['sort_assets'],
  );
}