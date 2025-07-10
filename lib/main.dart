import 'package:dragable_app/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/placed_component.dart';
import 'models/custom_iphone.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Hive.initFlutter();
  Hive.registerAdapter(ComponentTypeAdapter());
  Hive.registerAdapter(PlacedComponentAdapter());
  Hive.registerAdapter(CustomIphoneAdapter());
  await Hive.openBox<CustomIphone>('customIphones');
  runApp(const AstoreApp());
}
