import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String incomeBoxName = 'zzpaweee_income_box';
  static const String ownerBoxName = 'zzpaweee_owner_box';
  static const String petBoxName = 'zzpaweee_pet_box';
  static const String bookingBoxName = 'zzpaweee_booking_box';

  static Future<void> init() async {
    await Hive.initFlutter();

    await Hive.openBox(incomeBoxName);
    await Hive.openBox(ownerBoxName);
    await Hive.openBox(petBoxName);
    await Hive.openBox(bookingBoxName);
  }

  static Box get incomeBox => Hive.box(incomeBoxName);
  static Box get ownerBox => Hive.box(ownerBoxName);
  static Box get petBox => Hive.box(petBoxName);
  static Box get bookingBox => Hive.box(bookingBoxName);
}