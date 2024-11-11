

import 'package:drift/drift.dart';

@DataClassName("Task")
class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();  // 自增的主键
  TextColumn get name => text().withLength(min: 1, max: 50)();  // 名称字段
  DateTimeColumn get dueDate => dateTime().nullable()();  // 可选的截止日期
  BoolColumn get completed => boolean().withDefault(Constant(false))();  // 默认值为 false
}