import 'package:hive/hive.dart';
import 'package:flutter/cupertino.dart';

part 'placed_component.g.dart';

@HiveType(typeId: 1)
enum ComponentType {
  @HiveField(0)
  camera,
  @HiveField(1)
  powerButton,
  @HiveField(2)
  volumeButton,
  @HiveField(3)
  appleLogo,
  @HiveField(4)
  backFlashlight,
  @HiveField(5)
  lidarSensor,
  @HiveField(6)
  expandableCamera,
}

@HiveType(typeId: 2)
class PlacedComponent extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final ComponentType type;
  @HiveField(2)
  final double dx;
  @HiveField(3)
  final double dy;
  @HiveField(4)
  final double? radius; // For circular modules (camera, flashlight, lidar, logo)
  @HiveField(5)
  final double? width; // For rectangular modules (expandable camera, etc.)
  @HiveField(6)
  final double? height;

  PlacedComponent({
    required this.id,
    required this.type,
    required Offset position,
    this.radius,
    Size? size,
  }) : dx = position.dx,
       dy = position.dy,
       width = size?.width,
       height = size?.height;

  Offset get position => Offset(dx, dy);
  Size? get size => (width != null && height != null) ? Size(width!, height!) : null;

  factory PlacedComponent.fromMap(Map<String, dynamic> map) => PlacedComponent(
    id: map['id'],
    type: ComponentType.values[map['type']],
    position: Offset(map['dx'], map['dy']),
    radius: map['radius'],
    size: (map['width'] != null && map['height'] != null)
        ? Size(map['width'], map['height'])
        : null,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'type': type.index,
    'dx': dx,
    'dy': dy,
    'radius': radius,
    'width': width,
    'height': height,
  };
}
