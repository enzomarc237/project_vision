import 'package:project_vision/models/expanded_project_idea.dart';
import 'package:project_vision/models/project_feature.dart';
import 'package:project_vision/models/project_risk.dart';
import 'ai_service.dart'; // Import the AIService interface

// A mock implementation of AIService for development and testing.
class MockAIService implements AIService {
  @override
  Future<ExpandedProjectIdea> analyzeProjectIdea({
    required String concept,
    String? goals,
    String? audience,
    Map<String, String>? questionnaireAnswers, // New parameter
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    if (concept.isEmpty && (questionnaireAnswers == null || questionnaireAnswers.values.every((ans) => ans.isEmpty))) {
      throw Exception("Project concept or at least one questionnaire answer cannot be empty.");
    }

    String summary = "Based on your concept: \"$concept\", ";
    if (goals != null && goals.isNotEmpty) {
      summary += "with goals to \"$goals\", ";
    }
    if (audience != null && audience.isNotEmpty) {
      summary += "targeting \"$audience\", ";
    }
    summary += "our AI suggests the following expansions.";

    if (questionnaireAnswers != null && questionnaireAnswers.isNotEmpty) {
      summary += "\n\nGuided Questionnaire Insights:";
      questionnaireAnswers.forEach((question, answer) {
        if (answer.isNotEmpty) {
          summary += "\n- Q: $question\n  A: $answer"; // Simple display of Q&A
        }
      });
    }

    // ... (rest of the mock feature and risk generation logic remains the same) ...
    List<ProjectFeature> mockFeatures = [
      ProjectFeature(name: "User Authentication", description: "Secure sign-up and login for users."),
      ProjectFeature(name: "Dashboard", description: "Main screen to display key information and navigation."),
    ];
     if (concept.toLowerCase().contains("mobile app")) {
      mockFeatures.add(ProjectFeature(name: "Push Notifications", description: "Engage users with timely updates."));
    }
    if (concept.toLowerCase().contains("e-commerce")) {
      mockFeatures.add(ProjectFeature(name: "Shopping Cart", description: "Allow users to select and purchase items."));
      mockFeatures.add(ProjectFeature(name: "Payment Gateway Integration", description: "Securely process online payments."));
    }
    if (questionnaireAnswers?.entries.any((e) => e.key.contains("mvp") && e.value.isNotEmpty) ?? false) {
        mockFeatures.add(ProjectFeature(name: "MVP Feature from Q&A", description: "A feature suggested by questionnaire on MVP."));
    }


    List<ProjectRisk> mockRisks = [
      ProjectRisk(description: "Scope Creep", mitigation: "Define a clear MVP and stick to it for initial versions."),
      ProjectRisk(description: "Market Competition", mitigation: "Conduct thorough market research to identify unique selling propositions."),
    ];

    if (goals != null && goals.toLowerCase().contains("scale quickly")) {
        mockRisks.add(ProjectRisk(description: "Scalability Issues", mitigation: "Design with scalability in mind from the start; consider serverless or microservices."));
    }


    // Simulate a chance of failure for testing error handling
    // if (DateTime.now().second % 4 == 0) {
    //   throw Exception("Mock AI Service Error: Failed to generate expanded idea.");
    // }

    return ExpandedProjectIdea(
      summary: summary,
      features: mockFeatures,
      risks: mockRisks,
    );
  }
}
