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
  String status;

  @HiveField(5)
  String created;

  @HiveField(6, defaultValue: false)
  bool isVideo;

  @HiveField(7, defaultValue: 0.0)
  double progress;

  Recording(
      {required this.path,
      required this.name,
      required this.status,
      required this.created,
      this.isVideo = false,
      this.progress = 0.0,
      this.id});
}
