import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'placed_component.dart';

part 'custom_iphone.g.dart';

@HiveType(typeId: 3)
class CustomIphone extends HiveObject {
  @HiveField(0)
  final List<PlacedComponent> components;
  @HiveField(1)
  final int ram;
  @HiveField(2)
  final int storage;
  @HiveField(3)
  final double screenSize;
  @HiveField(4)
  final int cameraMp;
  @HiveField(5)
  final int battery;
  @HiveField(6)
  final int colorValue;

  CustomIphone({
    required this.components,
    required this.ram,
    required this.storage,
    required this.screenSize,
    required this.cameraMp,
    required this.battery,
    required Color color,
  }) : colorValue = color.value;

  Color get color => Color(colorValue);
}
