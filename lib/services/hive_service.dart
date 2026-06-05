import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String incomeBoxName = 'incomeBox';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(incomeBoxName);
  }

  static Box get incomeBox => Hive.box(incomeBoxName);
}