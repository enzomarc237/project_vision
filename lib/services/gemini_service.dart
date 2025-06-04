// lib/services/gemini_service.dart
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart'; // Required for Firebase.initializeApp if not done in main
import 'package:firebase_ai/firebase_ai.dart'; // Main package for Firebase AI Logic (Gemini)

import 'package:project_vision/models/expanded_project_idea.dart';
import 'package:project_vision/models/project_feature.dart';
import 'package:project_vision/models/project_risk.dart';
import 'ai_service.dart';

class GeminiService implements AIService {
  // TODO: API Key should be configurable and securely managed.
  // This might be set during Firebase initialization or via a settings screen.
  // For now, we acknowledge it's needed by the Firebase setup for Gemini.
  // The actual key is configured in the Google Cloud/Firebase console.
  // The SDK uses this configuration implicitly if project is set up correctly.
  final String _apiKeyPlaceholder = "YOUR_GEMINI_API_KEY_CONFIGURED_IN_FIREBASE";

  GenerativeModel? _model;

  GeminiService() {
    // Initialize the model.
    // Ensure Firebase is initialized before this service is used.
    // Model name might need adjustment based on availability and specific needs.
    // Example: 'gemini-pro' or specific multimodal models if needed.
    // Location can also be specified if needed.
    try {
      _model = FirebaseAI.instance.generativeModel(
        modelName: 'gemini-pro', // A common text generation model
        // generationConfig: GenerationConfig(...) // Optional: for temperature, topK, etc.
        // safetySettings: [...] // Optional: for safety configurations
      );
    } catch (e) {
      print("Error initializing Gemini Model: $e");
      // Potentially throw this or handle it so the app knows the service isn't usable.
      _model = null;
    }
  }

  @override
  Future<ExpandedProjectIdea> analyzeProjectIdea({
    required String concept,
    String? goals,
    String? audience,
  }) async {
    if (_model == null) {
      throw Exception("Gemini model is not initialized. Check Firebase setup and API key configuration.");
    }

    // --- Placeholder for API Key Check ---
    // In a real scenario with a client-side key, you might check it here.
    // However, with Firebase AI Logic, the key is server-side.
    // We'll simulate a check or rely on Firebase SDK's error for missing setup.
    if (_apiKeyPlaceholder == "YOUR_GEMINI_API_KEY_CONFIGURED_IN_FIREBASE_OR_SETUP_MISSING") {
      // This is a conceptual check. The SDK will likely fail differently if Firebase isn't set up for Gemini.
      print("API Key placeholder detected. Actual API call will likely fail or use default project settings.");
      // To make this testable without a real key, return a specific structure or error.
      return ExpandedProjectIdea(
        summary: "Gemini Service: API Key not configured. Please set up Firebase project for Gemini.",
        features: [ProjectFeature(name: "Setup Required", description: "Firebase/Gemini API key needs configuration.")],
        risks: [ProjectRisk(description: "Service Inactive", mitigation: "Configure API key in Firebase console.")],
      );
    }

    // 1. Construct the prompt for Gemini
    final StringBuffer promptBuffer = StringBuffer();
    promptBuffer.writeln("Analyze the following project idea and provide a structured expansion.");
    promptBuffer.writeln("Project Concept: \"$concept\"");
    if (goals != null && goals.isNotEmpty) {
      promptBuffer.writeln("Project Goals: \"$goals\"");
    }
    if (audience != null && audience.isNotEmpty) {
      promptBuffer.writeln("Target Audience: \"$audience\"");
    }
    promptBuffer.writeln("\nProvide the output as a single, valid JSON object with the following structure:");
    promptBuffer.writeln("{");
    promptBuffer.writeln("  \"summary\": \"A brief overall summary of the project idea and its potential (2-4 sentences).\",");
    promptBuffer.writeln("  \"features\": [");
    promptBuffer.writeln("    { \"name\": \"Feature Name 1\", \"description\": \"Description of feature 1\" },");
    promptBuffer.writeln("    { \"name\": \"Feature Name 2\", \"description\": \"Description of feature 2\" }");
    promptBuffer.writeln("    // ... (suggest 2-5 features)");
    promptBuffer.writeln("  ],");
    promptBuffer.writeln("  \"risks\": [");
    promptBuffer.writeln("    { \"description\": \"Description of risk 1\", \"mitigation\": \"Mitigation for risk 1\" },");
    promptBuffer.writeln("    { \"description\": \"Description of risk 2\", \"mitigation\": \"Mitigation for risk 2\" }");
    promptBuffer.writeln("    // ... (suggest 1-3 risks)");
    promptBuffer.writeln("  ]");
    promptBuffer.writeln("}");
    promptBuffer.writeln("Ensure the output is ONLY the JSON object, with no other text before or after it.");

    final String prompt = promptBuffer.toString();
    print("Gemini Prompt (JSON request):\n$prompt"); // For debugging

    try {
      // 2. Make the API call
      final response = await _model!.generateContent([Content.text(prompt)]);

      print("Gemini Raw Response Text: ${response.text}"); // For debugging

      if (response.text == null || response.text!.trim().isEmpty) {
        throw Exception("Received empty response from Gemini.");
      }

      String rawJson = response.text!.trim();
      // Sometimes Gemini might wrap JSON in ```json ... ```, try to strip it.
      if (rawJson.startsWith("```json")) {
        rawJson = rawJson.substring(7);
        if (rawJson.endsWith("```")) {
          rawJson = rawJson.substring(0, rawJson.length - 3);
        }
      }
      rawJson = rawJson.trim(); // Trim again after stripping markdown

      try {
        final Map<String, dynamic> jsonResponse = jsonDecode(rawJson) as Map<String, dynamic>;
        // Assuming ExpandedProjectIdea.fromJson is correctly implemented in its model file.
        return ExpandedProjectIdea.fromJson(jsonResponse);
      } catch (e) {
        print("Error parsing Gemini JSON response: $e");
        print("Problematic JSON string: $rawJson");
        // Fallback if JSON parsing fails, return the raw text in summary
        return ExpandedProjectIdea(
          summary: "Failed to parse Gemini response as JSON. Raw response: ${response.text}",
          features: [ProjectFeature(name: "Parsing Error", description: e.toString())],
          risks: [ProjectRisk(description: "Parsing Error", mitigation: "Check Gemini output format or prompt.")],
        );
      }
    } catch (e) {
      print("Error calling Gemini API: $e");
      // More specific error handling might be needed based on Firebase AI SDK errors
      if (e.toString().contains("API key not valid")) { // Example of more specific error
         return ExpandedProjectIdea(
            summary: "Gemini Service Error: API Key is not valid. Please check Firebase project configuration.",
            features: [],
            risks: [ProjectRisk(description: "Invalid API Key", mitigation: "Ensure API key is correct and enabled in Firebase/Google Cloud.")],
        );
      }
      throw Exception("Failed to get analysis from Gemini: ${e.toString()}");
    }
  }
}
