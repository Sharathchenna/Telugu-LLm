import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/app/app.logger.dart';
import 'package:swaram_ai/model/recording.dart';
import 'package:swaram_ai/ui/common/app_hive.dart';

class HiveService {
  final _updateInBox = ReactiveValue<bool>(false);
  final _logger = getLogger("Hive Service");

  late Box<Recording> _recordBox;
  late Box<List<Map<String, dynamic>>> _categoryBox;

  HiveService() {
    _initBoxes();
  }

  Future<void> initAll() async {
    await _initBoxes();
  }

  Future<void> _initBoxes() async {
    _recordBox = await Hive.openBox<Recording>(recordingBox);
    _categoryBox = await Hive.openBox<List<Map<String, dynamic>>>(categoryBox);
  }

  bool get updateInBox => _updateInBox.value;

  void saveRecordings({required Recording recording}) =>
      _recordBox.put(recording.id, recording);

  Iterable<Recording> getSavedRecordings() => _recordBox.values;

  Future<bool> updateValue(
      {required String key, required Recording updatedValue}) async {
    Recording? recording = _recordBox.get(key);
    if (recording != null) {
      _recordBox.put(key, updatedValue);
      return true;
    } else {
      _logger.i("Update failed: Key $key");
      return false;
    }
  }

  void saveCategories(List<Map<String, dynamic>> categories) =>
      _categoryBox.put("categoriesList", categories);

  List<Map<String, dynamic>> getCategories() =>
      _categoryBox.values.expand((element) => element).toList();
}
