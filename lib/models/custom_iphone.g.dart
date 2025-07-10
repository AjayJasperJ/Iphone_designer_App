// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_iphone.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomIphoneAdapter extends TypeAdapter<CustomIphone> {
  @override
  final int typeId = 3;

  @override
  CustomIphone read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomIphone(
      components: (fields[0] as List).cast<PlacedComponent>(),
      ram: fields[1] as int,
      storage: fields[2] as int,
      screenSize: fields[3] as double,
      cameraMp: fields[4] as int,
      battery: fields[5] as int,
      color: Color(fields[6] as int),
    );
  }

  @override
  void write(BinaryWriter writer, CustomIphone obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.components)
      ..writeByte(1)
      ..write(obj.ram)
      ..writeByte(2)
      ..write(obj.storage)
      ..writeByte(3)
      ..write(obj.screenSize)
      ..writeByte(4)
      ..write(obj.cameraMp)
      ..writeByte(5)
      ..write(obj.battery)
      ..writeByte(6)
      ..write(obj.colorValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomIphoneAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
