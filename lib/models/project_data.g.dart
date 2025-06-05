// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProjectDataAdapter extends TypeAdapter<ProjectData> {
  @override
  final int typeId = 0;

  @override
  ProjectData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProjectData(
      id: fields[0] as String,
      title: fields[1] as String,
      projectConcept: fields[2] as String,
      projectGoals: fields[3] as String?,
      targetAudience: fields[4] as String?,
      questionnaireAnswers: (fields[5] as Map?)?.cast<String, String>(),
      projectCategories: (fields[6] as Map?)?.cast<String, String>(),
      aiExpansionResults: fields[7] as ExpandedProjectIdea?,
      createdAt: fields[8] as DateTime,
      lastUpdatedAt: fields[9] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ProjectData obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.projectConcept)
      ..writeByte(3)
      ..write(obj.projectGoals)
      ..writeByte(4)
      ..write(obj.targetAudience)
      ..writeByte(5)
      ..write(obj.questionnaireAnswers)
      ..writeByte(6)
      ..write(obj.projectCategories)
      ..writeByte(7)
      ..write(obj.aiExpansionResults)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.lastUpdatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
