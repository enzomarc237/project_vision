// lib/models/project_risk.dart
import 'package:hive/hive.dart';

part 'project_risk.g.dart'; // For generated adapter

@HiveType(typeId: 2) // Assign unique typeId
class ProjectRisk {
  @HiveField(0)
  final String description;

  @HiveField(1)
  final String mitigation;
  // Potential future fields: likelihood, impact, etc.

  ProjectRisk({
    required this.description,
    required this.mitigation,
  });

  // Optional: factory constructor for JSON serialization
  // factory ProjectRisk.fromJson(Map<String, dynamic> json) {
  //   return ProjectRisk(
  //     description: json['description'] as String,
  //     mitigation: json['mitigation'] as String,
  //   );
  // }

  // Optional: toJson method for JSON serialization
  // Map<String, dynamic> toJson() {
  //   return {
  //     'description': description,
  //     'mitigation': mitigation,
  //   };
  // }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'mitigation': mitigation,
    };
  }

  factory ProjectRisk.fromJson(Map<String, dynamic> json) {
    return ProjectRisk(
      description: json['description'] as String,
      mitigation: json['mitigation'] as String,
    );
  }

  @override
  String toString() {
    return 'ProjectRisk(description: $description, mitigation: $mitigation)';
  }
}
