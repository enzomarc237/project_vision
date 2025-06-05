// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expanded_project_idea.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpandedProjectIdeaAdapter extends TypeAdapter<ExpandedProjectIdea> {
  @override
  final int typeId = 3;

  @override
  ExpandedProjectIdea read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpandedProjectIdea(
      summary: fields[0] as String,
      features: (fields[1] as List).cast<ProjectFeature>(),
      risks: (fields[2] as List).cast<ProjectRisk>(),
    );
  }

  @override
  void write(BinaryWriter writer, ExpandedProjectIdea obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.summary)
      ..writeByte(1)
      ..write(obj.features)
      ..writeByte(2)
      ..write(obj.risks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpandedProjectIdeaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
