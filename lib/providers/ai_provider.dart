import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_vision/services/ai_service.dart';

// Provider for the AIService.
// This will allow us to easily swap out the MockAIService for a real implementation later.
final aiServiceProvider = Provider<AIService>((ref) {
  // For now, we provide the MockAIService.
  // In the future, we could use environment variables or other configurations
  // to switch to a real AI service implementation.
  return MockAIService();
});

// If you anticipate needing to manage state related to AI interactions
// (e.g., loading states, results, errors) more complexly,
// you might consider a StateNotifierProvider or FutureProvider here.
// For now, a simple Provider for the service itself is sufficient.

// Example of how you might use a FutureProvider if the AI call was simple and direct:
/*
final aiAnalysisProvider = FutureProvider.family<String, Map<String, String>>(
  (ref, Sinputs) async {
    final concept = inputs['concept']!;
    final goals = inputs['goals'];
    final audience = inputs['audience'];

    final aiService = ref.watch(aiServiceProvider);
    return aiService.analyzeProjectIdea(
      concept: concept,
      goals: goals,
      audience: audience,
    );
  },
);
*/
// Note: The FutureProvider.family example above is just for illustration.
// We will trigger the AI service call from the UI directly for now to handle loading/error states there.
