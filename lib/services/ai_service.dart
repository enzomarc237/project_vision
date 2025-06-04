// Defines the contract for an AI service that analyzes project ideas.
abstract class AIService {
  /// Analyzes the provided project concept, goals, and audience.
  ///
  /// Returns a [Future<String>] representing the AI's analysis or suggestions.
  /// Throws an exception if the analysis fails.
  Future<String> analyzeProjectIdea({
    required String concept,
    String? goals, // Optional for now
    String? audience, // Optional for now
  });
}

// A mock implementation of AIService for development and testing.
class MockAIService implements AIService {
  @override
  Future<String> analyzeProjectIdea({
    required String concept,
    String? goals,
    String? audience,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    if (concept.isEmpty) {
      throw Exception("Project concept cannot be empty.");
    }

    // Simulate a basic analysis
    StringBuffer analysis = StringBuffer();
    analysis.writeln("Mock AI Analysis Report:");
    analysis.writeln("==========================");
    analysis.writeln("Project Concept: \"$concept\"");

    if (goals != null && goals.isNotEmpty) {
      analysis.writeln("Identified Goals: \"$goals\"");
    } else {
      analysis.writeln("Goals: Not specified. Consider defining clear objectives.");
    }

    if (audience != null && audience.isNotEmpty) {
      analysis.writeln("Target Audience: \"$audience\"");
    } else {
      analysis.writeln("Audience: Not specified. Identifying your target users is crucial.");
    }

    analysis.writeln("\nFurther Suggestions:");
    analysis.writeln("- Consider market research for similar project ideas.");
    analysis.writeln("- Develop a basic feature list based on the concept.");
    analysis.writeln("- Think about potential monetization strategies if applicable.");

    // Simulate a chance of failure for testing error handling
    // if (DateTime.now().second % 4 == 0) {
    //   throw Exception("Mock AI Service Error: Failed to analyze idea.");
    // }

    return analysis.toString();
  }
}
