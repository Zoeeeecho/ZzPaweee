import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'hive_service.dart';

class BackupService {
  Future<void> exportBackup() async {
    final backupData = {
      'exportedAt': DateTime.now().toIso8601String(),
      'income': HiveService.incomeBox.values.toList(),
      'owners': HiveService.ownerBox.values.toList(),
      'pets': HiveService.petBox.values.toList(),
    };

    final jsonString = const JsonEncoder.withIndent('  ').convert(backupData);

    final directory = await getApplicationDocumentsDirectory();
    final file = File(
      '${directory.path}/zzpaweee_backup_${DateTime.now().millisecondsSinceEpoch}.json',
    );

    await file.writeAsString(jsonString);

    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path)],
        text: 'ZzPaweee backup file',
      ),
    );
  }
}