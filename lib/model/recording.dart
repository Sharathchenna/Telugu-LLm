import 'package:hive/hive.dart';

part 'recording.g.dart';

@HiveType(typeId: 1)
class Recording extends HiveObject {
  @HiveField(1)
  String? id;

  @HiveField(2)
  String path;

  @HiveField(3)
  String name;

  @HiveField(4)
  bool uploadedStatus;

  Recording(
      {required this.path, required this.name, required this.uploadedStatus});
}
