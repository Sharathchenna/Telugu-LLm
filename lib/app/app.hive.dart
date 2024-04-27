import 'package:hive_flutter/hive_flutter.dart';
import 'package:swaram_ai/model/recording.dart';

Future<void> setupHive() async {
  //register the adapters
  Hive.registerAdapter(RecordingAdapter());

  //hive init
  await Hive.initFlutter();
}
