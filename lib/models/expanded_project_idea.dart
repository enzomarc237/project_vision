// lib/models/expanded_project_idea.dart
import 'package_feature.dart';
import 'project_risk.dart';

class ExpandedProjectIdea {
  final String summary; // Overall summary from AI
  final List<ProjectFeature> features;
  final List<ProjectRisk> risks;
  // Potential future fields: techStackSuggestions, marketAnalysis, etc.

  ExpandedProjectIdea({
    required this.summary,
    this.features = const [], // Default to empty list
    this.risks = const [],   // Default to empty list
  });

  // Optional: factory constructor for JSON serialization
  // factory ExpandedProjectIdea.fromJson(Map<String, dynamic> json) {
  //   var featuresList = json['features'] as List?;
  //   List<ProjectFeature> projectFeatures = featuresList
  //       ?.map((i) => ProjectFeature.fromJson(i as Map<String, dynamic>))
  //       .toList() ?? [];

  //   var risksList = json['risks'] as List?;
  //   List<ProjectRisk> projectRisks = risksList
  //       ?.map((i) => ProjectRisk.fromJson(i as Map<String, dynamic>))
  //       .toList() ?? [];

  //   return ExpandedProjectIdea(
  //     summary: json['summary'] as String,
  //     features: projectFeatures,
  //     risks: projectRisks,
  //   );
  // }

  // Optional: toJson method for JSON serialization
  // Map<String, dynamic> toJson() {
  //   return {
  //     'summary': summary,
  //     'features': features.map((f) => f.toJson()).toList(),
  //     'risks': risks.map((r) => r.toJson()).toList(),
  //   };
  // }

  @override
  String toString() {
    return 'ExpandedProjectIdea(summary: $summary, features: ${features.length}, risks: ${risks.length})';
  }
}
