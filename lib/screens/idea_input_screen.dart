import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:flutter/material.dart'; // Required for FlutterLogo

class IdeaInputScreen extends StatefulWidget {
  const IdeaInputScreen({super.key});

  @override
  State<IdeaInputScreen> createState() => _IdeaInputScreenState();
}

class _IdeaInputScreenState extends State<IdeaInputScreen> {
  final _projectConceptController = TextEditingController();
  final _projectGoalsController = TextEditingController();
  final _targetAudienceController = TextEditingController();

  @override
  void dispose() {
    _projectConceptController.dispose();
    _projectGoalsController.dispose();
    _targetAudienceController.dispose();
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

                  // Placeholder for Guided Questionnaire
                  const Text(
                    'Guided Questionnaire (Coming Soon)',
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
                      'This section will offer structured questions to help you develop your idea further.',
                       style: TextStyle(color: MacosColors.systemGray),
                    ),
                  ),
                  const SizedBox(height: 24),

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
                      onPressed: () {
                        final concept = _projectConceptController.text;
                        final goals = _projectGoalsController.text; // New
                        final audience = _targetAudienceController.text; // New

                        if (concept.isNotEmpty) {
                          print('Project Concept: $concept');
                          print('Project Goals: $goals'); // New
                          print('Target Audience: $audience'); // New
                          showMacosAlertDialog(
                            context: context,
                            builder: (_) => MacosAlertDialog(
                              appIcon: const FlutterLogo(size: 56),
                              title: const Text('Details Captured (For Now)'),
                              message: Text(
                                  'Concept: "$concept"\nGoals: "$goals"\nAudience: "$audience"\n\nMore features coming soon!'),
                              primaryButton: PushButton(
                                buttonSize: ButtonSize.large,
                                child: const Text('OK'),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ),
                          );
                        } else {
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
                        }
                      },
                      child: const Text('Next: Add Context'), // Or "Process Idea"
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
