import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:flutter/material.dart'; // Required for FlutterLogo
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_vision/providers/ai_provider.dart';
import 'package:project_vision/models/expanded_project_idea.dart';
import 'package:project_vision/models/guided_question.dart';
// project_feature.dart and project_risk.dart are implicitly imported via expanded_project_idea.dart
// but could be explicitly imported if direct instantiation or type usage was needed here.

class IdeaInputScreen extends ConsumerStatefulWidget {
  const IdeaInputScreen({super.key});

  @override
  ConsumerState<IdeaInputScreen> createState() => _IdeaInputScreenState();
}

class _IdeaInputScreenState extends ConsumerState<IdeaInputScreen> {
  final _projectConceptController = TextEditingController();
  final _projectGoalsController = TextEditingController();
  final _targetAudienceController = TextEditingController();
  bool _isLoading = false;
  bool _showGuidedQuestions = false; // Toggle for showing/hiding questionnaire

  final List<Map<String, String>> _initialQuestionsData = [
    {'id': 'problem', 'text': 'What specific problem does your project aim to solve?'},
    {'id': 'mvp_features', 'text': 'What are 2-3 core features essential for an MVP (Minimum Viable Product)?'},
    {'id': 'unique_value', 'text': 'What makes your project unique compared to potential alternatives?'},
    {'id': 'success_metrics', 'text': 'What are the primary success metrics for this project?'},
  ];

  List<GuidedQuestion> _guidedQuestionList = [];
  Map<String, TextEditingController> _guidedQuestionControllers = {};

  @override
  void initState() {
    super.initState();
    // Existing controllers for project concept, goals, audience are already initialized

    for (var qData in _initialQuestionsData) {
      _guidedQuestionList.add(GuidedQuestion(id: qData['id']!, text: qData['text']!));
      _guidedQuestionControllers[qData['id']!] = TextEditingController();
    }
  }

  @override
  void dispose() {
    _projectConceptController.dispose();
    _projectGoalsController.dispose();
    _targetAudienceController.dispose();
    for (var controller in _guidedQuestionControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MacosScaffold(
      toolBar: ToolBar(
        title: const Text('New Project Idea'),
        leading: MacosBackButton(
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      children: [
        ContentArea(
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Describe Your Project Concept',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  MacosTextField(
                    controller: _projectConceptController,
                    placeholder: 'Enter a detailed description of your project idea...',
                    maxLines: 10,
                    minLines: 5,
                  ),
                  const SizedBox(height: 24),

                  // Guided Questionnaire Toggle and Section
                  MacosSwitch(
                    value: _showGuidedQuestions,
                    onChanged: (value) {
                      setState(() {
                        _showGuidedQuestions = value;
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  const Text('Use Guided Questionnaire (Optional)'),

                  if (_showGuidedQuestions)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Guided Questions:',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 12),
                          ..._guidedQuestionList.map((question) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(question.text, style: const TextStyle(fontWeight: FontWeight.normal)),
                                  const SizedBox(height: 6),
                                  MacosTextField(
                                    controller: _guidedQuestionControllers[question.id],
                                    placeholder: 'Your answer...',
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  const SizedBox(height: 24), // Existing SizedBox before Project Categorization placeholder

                  // Placeholder for Project Categorization
                  const Text(
                    'Project Categorization (Coming Soon)',
                     style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: MacosColors.systemGray, // Placeholder styling
                    ),
                  ),
                  const SizedBox(height: 8),
                   Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color.fromRGBO(211, 211, 211, 1)), // light grey
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Select project type, industry, scale, etc. here.',
                       style: TextStyle(color: MacosColors.systemGray),
                    ),
                  ),
                  const SizedBox(height: 24), // Add some space

                  // Project Goals
                  const Text(
                    'Project Goals',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  MacosTextField(
                    controller: _projectGoalsController, // Needs to be created
                    placeholder: 'What are the main goals of this project?',
                    maxLines: 5,
                    minLines: 3,
                  ),
                  const SizedBox(height: 24),

                  // Target Audience
                  const Text(
                    'Target Audience',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  MacosTextField(
                    controller: _targetAudienceController, // Needs to be created
                    placeholder: 'Who is the target audience for this project?',
                    maxLines: 5,
                    minLines: 3,
                  ),
                  const SizedBox(height: 30),

                  Align(
                    alignment: Alignment.centerRight,
                    child: PushButton(
                      buttonSize: ButtonSize.large,
                      onPressed: _isLoading ? null : () async { // Disable button when loading
                        final concept = _projectConceptController.text;
                        final goals = _projectGoalsController.text;
                        final audience = _targetAudienceController.text;

                        if (concept.isEmpty) {
                          showMacosAlertDialog(
                            context: context,
                            builder: (_) => MacosAlertDialog(
                              appIcon: const MacosIcon(CupertinoIcons.exclamationmark_triangle, size: 56),
                              title: const Text('Concept Missing'),
                              message: const Text('Please enter your project concept before proceeding. Goals and audience are optional for now.'),
                              primaryButton: PushButton(
                                buttonSize: ButtonSize.large,
                                child: const Text('OK'),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ),
                          );
                          return; // Stop execution if concept is empty
                        }

                        setState(() {
                          _isLoading = true;
                        });

                        // Collect questionnaire answers
                        Map<String, String> collectedQuestionnaireAnswers = {};
                        if (_showGuidedQuestions) { // Only collect if the questionnaire is visible and used
                          _guidedQuestionControllers.forEach((id, controller) {
                            if (controller.text.trim().isNotEmpty) {
                              // Find the original question text using the id to make the map more meaningful
                              // This assumes _guidedQuestionList is populated with GuidedQuestion objects that have 'id' and 'text'
                              final questionText = _guidedQuestionList.firstWhere((q) => q.id == id, orElse: () => GuidedQuestion(id: id, text: id)).text;
                              collectedQuestionnaireAnswers[questionText] = controller.text.trim();
                            }
                          });
                        }

                        try {
                          final aiService = ref.read(aiServiceProvider); // Use ref.read here
                          final analysisResult = await aiService.analyzeProjectIdea(
                            concept: concept,
                            goals: goals,
                            audience: audience,
                            questionnaireAnswers: collectedQuestionnaireAnswers, // Pass the collected answers
                          );

                          // For now, we reuse the existing dialog logic. This will be improved in the next step.
                          if (mounted) { // Check if the widget is still in the tree
                            // Cast analysisResult to ExpandedProjectIdea if type isn't inferred
                            final ExpandedProjectIdea structuredResult = analysisResult;

                            // Build a more structured message for the dialog
                            StringBuffer dialogMessage = StringBuffer();
                            dialogMessage.writeln("AI Analysis (Mock):");
                            dialogMessage.writeln("===================");
                            dialogMessage.writeln("Summary: ${structuredResult.summary}");
                            dialogMessage.writeln("\nSuggested Features:");
                            if (structuredResult.features.isEmpty) {
                              dialogMessage.writeln("- None suggested at this time.");
                            } else {
                              for (var feature in structuredResult.features.take(3)) { // Show up to 3 features
                                dialogMessage.writeln("- ${feature.name}: ${feature.description}");
                              }
                              if (structuredResult.features.length > 3) {
                                dialogMessage.writeln("- ...and more.");
                              }
                            }

                            dialogMessage.writeln("\nPotential Risks:");
                            if (structuredResult.risks.isEmpty) {
                              dialogMessage.writeln("- None identified at this time.");
                            } else {
                              for (var risk in structuredResult.risks.take(2)) { // Show up to 2 risks
                                dialogMessage.writeln("- ${risk.description} (Mitigation: ${risk.mitigation})");
                              }
                              if (structuredResult.risks.length > 2) {
                                dialogMessage.writeln("- ...and more.");
                              }
                            }

                            showMacosAlertDialog(
                              context: context,
                              builder: (_) => MacosAlertDialog(
                                appIcon: const FlutterLogo(size: 56), // Or a more relevant icon
                                title: const Text('Project Expansion Analysis'),
                                message: Text(dialogMessage.toString()), // Display the structured info
                                primaryButton: PushButton(
                                  buttonSize: ButtonSize.large,
                                  child: const Text('OK'),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ),
                            );
                          }
                        } catch (e) {
                          if (mounted) { // Check if the widget is still in the tree
                            showMacosAlertDialog(
                              context: context,
                              builder: (_) => MacosAlertDialog(
                                appIcon: const MacosIcon(CupertinoIcons.exclamationmark_circle, color: MacosColors.systemRed, size: 56),
                                title: const Text('Error'),
                                message: Text('An error occurred during AI analysis: ${e.toString()}'),
                                primaryButton: PushButton(
                                  buttonSize: ButtonSize.large,
                                  child: const Text('OK'),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ),
                            );
                          }
                        } finally {
                          if (mounted) { // Check if the widget is still in the tree
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        }
                      },
                      child: _isLoading
                          ? const ProgressCircle(value: null) // Indeterminate progress
                          : const Text('Next: Add Context'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
