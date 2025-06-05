// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_feature.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProjectFeatureAdapter extends TypeAdapter<ProjectFeature> {
  @override
  final int typeId = 1;

  @override
  ProjectFeature read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProjectFeature(
      name: fields[0] as String,
      description: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProjectFeature obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectFeatureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
