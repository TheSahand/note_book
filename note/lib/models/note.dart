import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 1)
class Note extends HiveObject {
  @HiveField(1)
  String note;
  @HiveField(2)
  String date;

  Note(this.note, this.date);
}
