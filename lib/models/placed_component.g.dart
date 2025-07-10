// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'placed_component.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlacedComponentAdapter extends TypeAdapter<PlacedComponent> {
  @override
  final int typeId = 2;

  @override
  PlacedComponent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlacedComponent(
      id: fields[0] as int,
      type: fields[1] as ComponentType,
      position: Offset(
        fields[2] as double? ?? 0.0,
        fields[3] as double? ?? 0.0,
      ),
      radius: fields[4] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, PlacedComponent obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.dx)
      ..writeByte(3)
      ..write(obj.dy)
      ..writeByte(4)
      ..write(obj.radius)
      ..writeByte(5)
      ..write(obj.width)
      ..writeByte(6)
      ..write(obj.height);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlacedComponentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ComponentTypeAdapter extends TypeAdapter<ComponentType> {
  @override
  final int typeId = 1;

  @override
  ComponentType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ComponentType.camera;
      case 1:
        return ComponentType.powerButton;
      case 2:
        return ComponentType.volumeButton;
      case 3:
        return ComponentType.appleLogo;
      case 4:
        return ComponentType.backFlashlight;
      case 5:
        return ComponentType.lidarSensor;
      case 6:
        return ComponentType.expandableCamera;
      default:
        return ComponentType.camera;
    }
  }

  @override
  void write(BinaryWriter writer, ComponentType obj) {
    switch (obj) {
      case ComponentType.camera:
        writer.writeByte(0);
        break;
      case ComponentType.powerButton:
        writer.writeByte(1);
        break;
      case ComponentType.volumeButton:
        writer.writeByte(2);
        break;
      case ComponentType.appleLogo:
        writer.writeByte(3);
        break;
      case ComponentType.backFlashlight:
        writer.writeByte(4);
        break;
      case ComponentType.lidarSensor:
        writer.writeByte(5);
        break;
      case ComponentType.expandableCamera:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ComponentTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
