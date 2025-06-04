// lib/models/project_feature.dart
class ProjectFeature {
  final String name;
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

  @override
  String toString() {
    return 'ProjectFeature(name: $name, description: $description)';
  }
}
