import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:project_vision/screens/idea_input_screen.dart';
import 'package:project_vision/models/project_data.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // New import
import 'package:project_vision/providers/storage_provider.dart'; // New import

class HomeScreen extends ConsumerStatefulWidget { // Changed to ConsumerStatefulWidget
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState(); // Changed to ConsumerState
}

class _HomeScreenState extends ConsumerState<HomeScreen> { // Changed to ConsumerState
  int _pageIndex = 0;
  List<ProjectData> _savedProjects = [];
  bool _isLoadingProjects = true;

  @override
  void initState() {
    super.initState();
    _fetchSavedProjects();
  }

  Future<void> _fetchSavedProjects() async {
    if (!mounted) return;
    setState(() { _isLoadingProjects = true; });
    try {
      final storageService = ref.read(storageServiceProvider);
      final projects = await storageService.getAllProjects();
      if (mounted) {
        setState(() {
          _savedProjects = projects;
        });
      }
    } catch (e) {
      if (mounted) {
         print("Error fetching projects: $e");
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingProjects = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MacosWindow(
      sidebar: Sidebar(
        minWidth: 200,
        builder: (context, scrollController) {
          return SidebarItems(
            currentIndex: _pageIndex,
            onChanged: (index) {
              setState(() => _pageIndex = index);
              // For now, only one actual page, others are placeholders
              if (index == 1) { // Assuming "New Project" is at index 1
                Navigator.of(context).push(
                  CupertinoPageRoute(builder: (_) => const IdeaInputScreen()),
                );
              }
            },
            items: const [
              SidebarItem(
                leading: MacosIcon(CupertinoIcons.home),
                label: Text('Dashboard'),
              ),
              SidebarItem(
                leading: MacosIcon(CupertinoIcons.add_circled),
                label: Text('New Project Idea'),
              ),
              SidebarItem(
                leading: MacosIcon(CupertinoIcons.folder_special),
                label: Text('My Projects'),
              ),
              SidebarItem(
                leading: MacosIcon(CupertinoIcons.settings),
                label: Text('Settings'),
              ),
            ],
          );
        },
        bottom: const MacosListTile(
          leading: MacosIcon(CupertinoIcons.profile_circled),
          title: Text('User Profile'), // Placeholder
          subtitle: Text('user@example.com'), // Placeholder
        ),
      ),
      child: IndexedStack(
        index: _pageIndex,
        children: [
          // Content for Dashboard (Index 0)
          MacosScaffold(
            toolBar: ToolBar(
              title: const Text('Welcome to ProjectVision!'),
              actions: [
                ToolBarIconButton(
                  label: 'New Project',
                  icon: const MacosIcon(CupertinoIcons.add),
                  onPressed: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(builder: (_) => const IdeaInputScreen()),
                    );
                  },
                  showLabel: false,
                ),
              ],
            ),
            children: [
              ContentArea(
                builder: (context, scrollController) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ProjectVision: AI-Powered Project Scaffolding',
                          style: MacosTheme.of(context).typography.largeTitle,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Transform your project ideas into comprehensive plans.\nClick "New Project Idea" in the sidebar or the "+" button to get started.',
                          style: MacosTheme.of(context).typography.body,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                        PushButton(
                          buttonSize: ButtonSize.large,
                          child: const Text('Start a New Project'),
                          onPressed: () {
                            Navigator.of(context).push(
                              CupertinoPageRoute(builder: (_) => const IdeaInputScreen()),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          // Placeholder for "New Project Idea" screen content (Index 1)
          // This will be handled by navigation for now
          Container(child: Center(child: Text("Redirecting to New Project Idea..."))),

          // Content for "My Projects" (Index 2)
          MacosScaffold(
            toolBar: ToolBar(
              title: const Text('My Saved Projects'),
              actions: [
                ToolBarIconButton(
                  label: 'Refresh',
                  icon: const MacosIcon(CupertinoIcons.refresh),
                  onPressed: _fetchSavedProjects, // Add refresh functionality
                  showLabel: false,
                ),
              ],
            ),
            children: [
              ContentArea(
                builder: (context, scrollController) {
                  if (_isLoadingProjects) {
                    return const Center(child: ProgressCircle(value: null));
                  }
                  if (_savedProjects.isEmpty) {
                    return Center(
                      child: Text(
                        'No saved projects yet.',
                        style: MacosTheme.of(context).typography.headline,
                      ),
                    );
                  }
                  return ListView.builder(
                    controller: scrollController,
                    itemCount: _savedProjects.length,
                    itemBuilder: (context, index) {
                      final project = _savedProjects[index];
                      return MacosListTile(
                        leading: MacosIcon(CupertinoIcons.doc_text, color: MacosTheme.of(context).primaryColor),
                        title: Text(project.title, style: MacosTheme.of(context).typography.body),
                        subtitle: Text(
                          'Last updated: ${DateFormat.yMMMd().add_jm().format(project.lastUpdatedAt)}',
                          style: MacosTheme.of(context).typography.caption1,
                        ),
                        onClick: () {
                          print('Clicked on project: ${project.title}');
                          showMacosAlertDialog(
                              context: context,
                              builder: (_) => MacosAlertDialog(
                                    appIcon: const MacosIcon(CupertinoIcons.doc_text),
                                    title: Text(project.title, style: MacosTheme.of(context).typography.headline),
                                    message: Text(
                                      "Concept: ${project.projectConcept.substring(0, (project.projectConcept.length > 100) ? 100 : project.projectConcept.length)}${project.projectConcept.length > 100 ? "..." : ""}\n"
                                      "Created: ${DateFormat.yMMMd().format(project.createdAt)}\n"
                                      "${project.aiExpansionResults != null ? 'AI Summary: ${project.aiExpansionResults!.summary.substring(0, (project.aiExpansionResults!.summary.length > 100) ? 100 : project.aiExpansionResults!.summary.length)}${project.aiExpansionResults!.summary.length > 100 ? "..." : ""}' : 'No AI analysis found.'}",
                                       style: MacosTheme.of(context).typography.body,
                                    ),
                                    primaryButton: PushButton(
                                      buttonSize: ButtonSize.large,
                                      child: const Text('OK'),
                                      onPressed: () => Navigator.of(context).pop(),
                                    ),
                                  ));
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
          // Placeholder for "Settings" screen content (Index 3)
          Container(child: Center(child: Text("Settings (Coming Soon)"))),
        ],
      ),
    );
  }
}
