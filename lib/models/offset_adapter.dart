import 'package:flutter/cupertino.dart';

class OffsetAdapter {
  static Map<String, double> toMap(Offset offset) => {'dx': offset.dx, 'dy': offset.dy};
  static Offset fromMap(Map<String, double> map) => Offset(map['dx']!, map['dy']!);
}
