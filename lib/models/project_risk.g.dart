// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_risk.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProjectRiskAdapter extends TypeAdapter<ProjectRisk> {
  @override
  final int typeId = 2;

  @override
  ProjectRisk read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProjectRisk(
      description: fields[0] as String,
      mitigation: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProjectRisk obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.description)
      ..writeByte(1)
      ..write(obj.mitigation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectRiskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
