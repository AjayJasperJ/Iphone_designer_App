import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import '../models/custom_iphone.dart';

class CustomIphoneProvider extends ChangeNotifier {
  final List<CustomIphone> _iphones = [];
  late Box<CustomIphone> _box;

  List<CustomIphone> get iphones => _iphones;

  CustomIphoneProvider() {
    _init();
  }

  Future<void> _init() async {
    _box = Hive.box<CustomIphone>('customIphones');
    _iphones.clear();
    _iphones.addAll(_box.values);
    notifyListeners();
  }

  Future<void> addIphone(CustomIphone iphone) async {
    await _box.add(iphone);
    _iphones.add(iphone);
    notifyListeners();
  }

  Future<void> deleteIphoneAt(int index) async {
    if (index >= 0 && index < iphones.length) {
      final key = _box.keyAt(index);
      await _box.delete(key);
      iphones.removeAt(index);
      notifyListeners();
    }
  }
}
