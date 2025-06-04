import 'package:project_vision/models/expanded_project_idea.dart';
import 'package:project_vision/models/project_feature.dart';
import 'package:project_vision/models/project_risk.dart';

// Defines the contract for an AI service that analyzes project ideas.
abstract class AIService {
  /// Analyzes the provided project concept, goals, and audience.
  ///
  /// Returns a [Future<ExpandedProjectIdea>] representing the AI's analysis or suggestions.
  /// Throws an exception if the analysis fails.
  Future<ExpandedProjectIdea> analyzeProjectIdea({
    required String concept,
    String? goals, // Optional for now
    String? audience, // Optional for now
  });
}
