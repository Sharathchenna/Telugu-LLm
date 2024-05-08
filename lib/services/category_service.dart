import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/app/app.logger.dart';
import 'package:swaram_ai/services/client_service.dart';
import 'package:swaram_ai/services/hive_service.dart';
import 'package:swaram_ai/services/network_service.dart';
import 'package:swaram_ai/ui/common/app_strings.dart';

class CategoryService with ListenableServiceMixin {
  final _showFront = ReactiveValue<bool>(true);
  final _logger = getLogger("Category Sevice");
  String selectedCategoryId = "";
  late Databases _databases;
  late HiveService _hiveService;
  late NetworkService _networkService;

  bool get showFront => _showFront.value;

  CategoryService() {
    listenToReactiveValues([
      _showFront,
    ]);
    _hiveService = locator<HiveService>();
  }

  void toggleCard() {
    _showFront.value = !_showFront.value;
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>> getCategories() {
    _networkService = locator<NetworkService>();
    if (_networkService.hasConnection) {
      return _fetchCategoriesFromDb();
    }
    return Future.value(_hiveService.getCategories());
  }

  Future<List<Map<String, dynamic>>> _fetchCategoriesFromDb() async {
    try {
      _databases = locator<ClientService>().getDatabase;

      DocumentList documents = await _databases.listDocuments(
          databaseId: appWriteCategoriesDatabase,
          collectionId: appWriteCategoriesCollection);
      var categoriesList = _extractCategories(documents.documents);
      _hiveService.saveCategories(categoriesList);
      _logger.i(categoriesList);
      return categoriesList;
    } catch (e) {
      _logger.e("Something went wrong $e");
      rethrow;
    }
  }

  List<Map<String, dynamic>> _extractCategories(List<Document> documentList) {
    List<Map<String, dynamic>> categoriesList = [];
    for (var element in documentList) {
      categoriesList.add(element.data);
    }
    return categoriesList;
  }
}
