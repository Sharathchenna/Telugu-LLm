import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/app/app.logger.dart';
import 'package:swaram_ai/model/recording.dart';
import 'package:swaram_ai/ui/common/app_hive.dart';

class HiveService {
  final _updateInBox = ReactiveValue<bool>(false);
  final _logger = getLogger("Hive Service");
  late Box<Recording> _recordBox;
  Box<List<Map<String, dynamic>>>? _categoryBox;

  bool get updateInBox => _updateInBox.value;

  HiveService() {
    if (!Hive.isBoxOpen(recordingBox)) {
      Hive.openBox<Recording>(recordingBox).then((value) {
        _recordBox = value;
      });
    }
  }

  void checkCategoryBoxAndOpen() async {
    if (!Hive.isBoxOpen(categoryBox)) {
      _categoryBox =
          await Hive.openBox<List<Map<String, dynamic>>>(categoryBox);
    }
  }

  void saveRecordings({required Recording recording}) async {
    _recordBox.put(recording.id, recording);
    _logger.i("Added recording in local");
  }

  Iterable<Recording> getSavedRecordings() => _recordBox.values;

  bool updateValue({required String key, required Recording updatedValue}) {
    Recording? recording = _recordBox.get(key);
    if (recording != null) {
      _recordBox.put(key, updatedValue);
      return true;
    } else {
      _logger.i("Update failed: Key $key");
      return false;
    }
  }

  void saveCategories(List<Map<String, dynamic>> categories) {
    checkCategoryBoxAndOpen();
    _categoryBox?.put("categoriesList", categories);
  }

  List<Map<String, dynamic>>? getCategories() {
    checkCategoryBoxAndOpen();
    return _categoryBox?.values.expand((element) => element).toList();
  }
}
