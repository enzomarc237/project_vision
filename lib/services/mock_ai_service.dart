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
    Map<String, String>? questionnaireAnswers,
    Map<String, String>? projectCategories, // New parameter
  }) async {
    await Future.delayed(const Duration(seconds: 1)); // Slightly reduced delay

    // Adjusted validation: concept or questionnaire or categories should have some input
    bool conceptProvided = concept.isNotEmpty;
    bool qnaProvided = questionnaireAnswers != null && questionnaireAnswers.values.any((ans) => ans.isNotEmpty);
    bool categoriesProvided = projectCategories != null && projectCategories.values.any((cat) => cat != null && cat.isNotEmpty);

    if (!conceptProvided && !qnaProvided && !categoriesProvided) {
      throw Exception("At least one input (concept, questionnaire, or category) must be provided.");
    }

    StringBuffer summaryBuffer = StringBuffer();
    summaryBuffer.write("Based on your input: ");
    if (conceptProvided) summaryBuffer.write("Concept: \"$concept\". ");
    if (goals != null && goals.isNotEmpty) summaryBuffer.write("Goals: \"$goals\". ");
    if (audience != null && audience.isNotEmpty) summaryBuffer.write("Target Audience: \"$audience\". ");

    if (projectCategories != null && projectCategories.isNotEmpty) {
      summaryBuffer.write("\nProject Categories: ");
      List<String> categoryEntries = [];
      projectCategories.forEach((key, value) {
        if (value != null && value.isNotEmpty) { // Ensure value is not null and not empty
            categoryEntries.add("$key: $value");
        }
      });
      if (categoryEntries.isNotEmpty) {
        summaryBuffer.write(categoryEntries.join(', ') + ". ");
      }
    }

    summaryBuffer.write("Our AI suggests the following expansions.");

    if (questionnaireAnswers != null && questionnaireAnswers.isNotEmpty) {
      summaryBuffer.write("\n\nGuided Questionnaire Insights:");
      questionnaireAnswers.forEach((question, answer) {
        if (answer.isNotEmpty) {
          summaryBuffer.write("\n- Q: $question\n  A: $answer");
        }
      });
    }

    String summary = summaryBuffer.toString();

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
    // Example: Add a feature if it's a 'Mobile App'
    if (projectCategories?['Project Type'] == 'Mobile App') {
      mockFeatures.add(ProjectFeature(name: "Mobile UI/UX Adaptation", description: "Specific design considerations for mobile platforms."));
    }
    if (projectCategories?['Industry'] == 'Healthcare') {
        mockFeatures.add(ProjectFeature(name: "HIPAA Compliance Module", description: "Considerations for handling sensitive health information."));
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
