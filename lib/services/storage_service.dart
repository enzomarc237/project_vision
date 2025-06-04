// lib/services/storage_service.dart
import 'package:hive_flutter/hive_flutter.dart'; // Use hive_flutter for init and ValueListenableBuilder if needed
import 'package:project_vision/models/project_data.dart';
import 'package:uuid/uuid.dart'; // For generating unique IDs

class StorageService {
  static const String _projectsBoxName = 'projects_box';
  final Uuid _uuid = Uuid(); // For generating unique IDs

  // Private constructor for singleton pattern (optional, but good practice for services)
  // StorageService._privateConstructor();
  // static final StorageService instance = StorageService._privateConstructor();

  // Ensure the box is open. This should be called before any operations.
  // Can be called in main.dart after Hive.initFlutter() and adapter registration,
  // or lazily within each method here (with a check).
  Future<Box<ProjectData>> _getOpenProjectsBox() async {
    if (!Hive.isBoxOpen(_projectsBoxName)) {
      // This assumes ProjectDataAdapter and other necessary adapters are registered in main.dart
      return await Hive.openBox<ProjectData>(_projectsBoxName);
    }
    return Hive.box<ProjectData>(_projectsBoxName);
  }

  // Initialize and open boxes. Call this during app startup.
  // Alternatively, handle opening boxes lazily as in _getOpenProjectsBox.
  static Future<void> init() async {
    // Hive.initFlutter() and adapter registrations should be done in main.dart
    // This method is primarily for opening boxes used by this service.
    await Hive.openBox<ProjectData>(_projectsBoxName);
    print("StorageService: '$_projectsBoxName' opened.");
  }

  Future<String> generateUniqueId() async {
    return _uuid.v4();
  }

  // Create: Save a new project
  Future<void> saveProject(ProjectData project) async {
    final box = await _getOpenProjectsBox();
    // ID should be set on the project object before calling saveProject
    // If project.id is not set, this will use it as key.
    // If you want Hive to auto-generate integer keys, use box.add(project)
    // But using a custom string ID (like UUID) is often more robust.
    await box.put(project.id, project);
    print("Project saved with ID: ${project.id}");
  }

  // Read: Load a single project by ID
  Future<ProjectData?> getProject(String id) async {
    final box = await _getOpenProjectsBox();
    return box.get(id);
  }

  // Read: Load all projects
  Future<List<ProjectData>> getAllProjects() async {
    final box = await _getOpenProjectsBox();
    // Values are returned in insertion order by default.
    // You can sort them here if needed, e.g., by createdAt date.
    List<ProjectData> projects = box.values.toList();
    projects.sort((a, b) => b.createdAt.compareTo(a.createdAt)); // Sort by newest first
    return projects;
  }

  // Update: Update an existing project
  // This is the same as saveProject if the ID already exists, as put() overwrites.
  Future<void> updateProject(ProjectData project) async {
    // Ensure lastUpdatedAt is updated
    project.lastUpdatedAt = DateTime.now();
    await saveProject(project); // `put` will update if key exists
    print("Project updated with ID: ${project.id}");
  }

  // Delete: Delete a project by ID
  Future<void> deleteProject(String id) async {
    final box = await _getOpenProjectsBox();
    await box.delete(id);
    print("Project deleted with ID: $id");
  }

  // Optional: Listen to changes in the projects box
  // This can be useful for updating UI reactively.
  // Example: ValueListenable<Box<ProjectData>> getProjectsBoxListenable() {
  //   return Hive.box<ProjectData>(_projectsBoxName).listenable();
  // }

  // Close the box when the service is no longer needed (e.g., app termination)
  // Though Hive boxes are often kept open for the app's lifetime.
  Future<void> dispose() async {
    final box = await _getOpenProjectsBox(); // Ensure it's open before trying to close
    await box.close();
    print("StorageService: '$_projectsBoxName' closed.");
  }
}

// Example of how you might want to initialize StorageService and open boxes in main.dart
// (This part is for context, not directly part of StorageService itself)
/*
// In main.dart, after Hive.registerAdapter calls:
// ...
await StorageService.init(); // Opens the 'projects_box'
// ...
// runApp(...)
*/
