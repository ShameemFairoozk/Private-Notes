
import 'package:hive/hive.dart';
part 'notepad_model.g.dart';
@HiveType(typeId: 1)
class NotePadModel {

  @HiveField(0)
  int? key;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final DateTime createdAt;
  @HiveField(4)
  final DateTime updatedAt;

  NotePadModel({
    this.key,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });
}
