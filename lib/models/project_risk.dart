// lib/models/project_risk.dart
class ProjectRisk {
  final String description;
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

  @override
  String toString() {
    return 'ProjectRisk(description: $description, mitigation: $mitigation)';
  }
}
