// lib/models/guided_question.dart
class GuidedQuestion {
  final String id; // Unique identifier for the question
  final String text; // The question text
  // String answer; // Answer will be managed by TextEditingController externally

  GuidedQuestion({
    required this.id,
    required this.text,
    // this.answer = '', // Not strictly needed here if using controllers
  });
}
