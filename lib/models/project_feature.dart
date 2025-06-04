// lib/models/project_feature.dart
import 'package:hive/hive.dart';

part 'project_feature.g.dart'; // For generated adapter

@HiveType(typeId: 1) // Assign unique typeId
class ProjectFeature {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String description;
  // Potential future fields: priority, category, etc.

  ProjectFeature({
    required this.name,
    required this.description,
  });

  // Optional: factory constructor for JSON serialization if needed later
  // factory ProjectFeature.fromJson(Map<String, dynamic> json) {
  //   return ProjectFeature(
  //     name: json['name'] as String,
  //     description: json['description'] as String,
  //   );
  // }

  // Optional: toJson method for JSON serialization
  // Map<String, dynamic> toJson() {
  //   return {
  //     'name': name,
  //     'description': description,
  //   };
  // }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
    };
  }

  factory ProjectFeature.fromJson(Map<String, dynamic> json) {
    return ProjectFeature(
      name: json['name'] as String,
      description: json['description'] as String,
    );
  }

  @override
  String toString() {
    return 'ProjectFeature(name: $name, description: $description)';
  }
}
