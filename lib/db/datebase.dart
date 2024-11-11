import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'tables.dart'; // 导入你定义的表文件

part 'database.g.dart';

@DriftDatabase(tables: [Tasks])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // 获取所有任务
  Future<List<Tasks>> getAllTasks() => select(tasks).get();

  // 插入新任务
  Future<int> insertTask(Tasks task) => into(tasks).insert(task);

  // 更新任务
  Future<bool> updateTask(Tasks task) => update(tasks).replace(task);

  // 删除任务
  Future<int> deleteTask(int id) => (delete(tasks)..where((t) => t.id.equals(id))).go();
}

// 创建数据库连接
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}