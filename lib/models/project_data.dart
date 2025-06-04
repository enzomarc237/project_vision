// lib/models/project_data.dart
import 'package:project_vision/models/expanded_project_idea.dart';
import 'package:project_vision/models/project_feature.dart'; // For to/from JSON
import 'package:project_vision/models/project_risk.dart';   // For to/from JSON

import 'package:hive/hive.dart';
// Ensure other models are imported if directly used as types for fields (they are)
// ExpandedProjectIdea is already imported.
// import 'package:project_vision/models/project_feature.dart'; // Not directly used as field type
// import 'package:project_vision/models/project_risk.dart';   // Not directly used as field type

part 'project_data.g.dart'; // For generated adapter

@HiveType(typeId: 0) // Main object, often typeId 0
class ProjectData {
  @HiveField(0)
  final String id; // Unique identifier for the project

  @HiveField(1)
  String title; // User-defined or auto-generated project title

  // --- User Inputs ---
  @HiveField(2)
  final String projectConcept;

  @HiveField(3)
  final String? projectGoals;

  @HiveField(4)
  final String? targetAudience;

  @HiveField(5)
  final Map<String, String>? questionnaireAnswers; // Hive handles Map<String, String> directly

  @HiveField(6)
  final Map<String, String>? projectCategories; // Hive handles Map<String, String> directly

  // --- AI Output ---
  @HiveField(7)
  ExpandedProjectIdea? aiExpansionResults; // This will use ExpandedProjectIdeaAdapter

  // --- Metadata ---
  @HiveField(8)
  final DateTime createdAt; // Hive handles DateTime directly

  @HiveField(9)
  DateTime lastUpdatedAt; // Hive handles DateTime directly

  // Note: For Map types, Hive can store them directly if keys/values are primitives or HiveObjects.
  // For List<CustomObject>, CustomObject needs its own adapter.

  ProjectData({
    required this.id,
    required this.title,
    required this.projectConcept,
    this.projectGoals,
    this.targetAudience,
    this.questionnaireAnswers,
    this.projectCategories,
    this.aiExpansionResults,
    required this.createdAt,
    required this.lastUpdatedAt,
  });

  // toJson/fromJson remain
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'projectConcept': projectConcept,
      'projectGoals': projectGoals,
      'targetAudience': targetAudience,
      'questionnaireAnswers': questionnaireAnswers,
      'projectCategories': projectCategories,
      'aiExpansionResults': aiExpansionResults?.toJson(), // Assumes ExpandedProjectIdea has toJson
      'createdAt': createdAt.toIso8601String(),
      'lastUpdatedAt': lastUpdatedAt.toIso8601String(),
    };
  }

  factory ProjectData.fromJson(Map<String, dynamic> json) {
    return ProjectData(
      id: json['id'] as String,
      title: json['title'] as String,
      projectConcept: json['projectConcept'] as String,
      projectGoals: json['projectGoals'] as String?,
      targetAudience: json['targetAudience'] as String?,
      questionnaireAnswers: (json['questionnaireAnswers'] as Map<String, dynamic>?)
          ?.map((key, value) => MapEntry(key, value as String)),
      projectCategories: (json['projectCategories'] as Map<String, dynamic>?)
          ?.map((key, value) => MapEntry(key, value as String)),
      aiExpansionResults: json['aiExpansionResults'] != null
          ? ExpandedProjectIdea.fromJson(json['aiExpansionResults'] as Map<String, dynamic>)
          : null, // Assumes ExpandedProjectIdea has fromJson
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastUpdatedAt: DateTime.parse(json['lastUpdatedAt'] as String),
    );
  }
}
