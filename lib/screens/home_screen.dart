import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:project_vision/screens/idea_input_screen.dart'; // To be created

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _pageIndex = 0;

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
          // Placeholder for "My Projects" screen content (Index 2)
          Container(child: Center(child: Text("My Projects (Coming Soon)"))),
          // Placeholder for "Settings" screen content (Index 3)
          Container(child: Center(child: Text("Settings (Coming Soon)"))),
        ],
      ),
    );
  }
}
