import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_vision/services/ai_service.dart';
import 'package:project_vision/services/mock_ai_service.dart'; // Import MockAIService
import 'package:project_vision/services/gemini_service.dart'; // Import GeminiService

// Configuration flag to easily switch between mock and real service
// Set to true to use MockAIService, false to use GeminiService.
// TODO: This should ideally be managed by a more robust configuration system
// (e.g., environment variables, build flavors, or a settings service).
const bool useMockService = false; // Default to GeminiService for integration

final aiServiceProvider = Provider<AIService>((ref) {
  if (useMockService) {
    print("AI Provider: Using MockAIService");
    return MockAIService();
  } else {
    print("AI Provider: Using GeminiService");
    // Ensure Firebase is initialized before GeminiService is instantiated
    // if GeminiService constructor relies on Firebase.initializeApp immediately.
    // However, our GeminiService initializes the model in its constructor,
    // and main.dart already calls WidgetsFlutterBinding.ensureInitialized()
    // and potentially Firebase.initializeApp() if we add it there.
    // For safety, ensure Firebase.initializeApp() has completed if direct dependency.
    return GeminiService();
  }
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
