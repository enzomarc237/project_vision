// lib/providers/storage_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_vision/services/storage_service.dart';

// Provider for the StorageService
final storageServiceProvider = Provider<StorageService>((ref) {
  // The StorageService itself doesn't have complex constructor dependencies
  // other than its own internal Hive setup, which is handled by its init() method
  // or lazily when its methods are called.
  return StorageService();
});
