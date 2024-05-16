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
  final _logger = getLogger("Category Service");
  String selectedCategoryId = "";
  late Databases _databases;
  final HiveService _hiveService = locator<HiveService>();
  final NetworkService _networkService = locator<NetworkService>();
  final _clientService = locator<ClientService>();
  List<Map<String, dynamic>> categoryData = [];

  bool get showFront => _showFront.value;

  CategoryService() {
    listenToReactiveValues([
      _showFront,
    ]);
    _databases = _clientService.getDatabase;
  }

  void toggleCard() {
    _showFront.value = !_showFront.value;
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>> getCategories() async {
    _logger.d("Inside the getcategories function");
    if (categoryData.isNotEmpty) {
      _logger.d(categoryData);
      return Future.value(categoryData);
    }
    _logger.d("Network Service: ${_networkService.hasConnection}");
    if (_networkService.hasConnection) {
      _logger.d("Getting data from db");
      return _fetchCategoriesFromDb();
    } else {
      _logger.d("Getting data from local storage");
      await _hiveService.initAll();
      var value = _hiveService.getCategories();
      _logger.i(value);
      return Future.value(value);
    }
  }

  Future<List<Map<String, dynamic>>> _fetchCategoriesFromDb() async {
    try {
      DocumentList documents = await _databases.listDocuments(
          databaseId: appWriteCategoriesDatabase,
          collectionId: appWriteCategoriesCollection);
      var categoriesList = _extractCategories(documents.documents);
      _hiveService.saveCategories(categoriesList);
      categoryData = categoriesList;
      return categoriesList;
    } catch (e) {
      _logger.e("Something went wrong $e");
      rethrow;
    }
  }

  List<Map<String, dynamic>> _extractCategories(List<Document> documentList) =>
      documentList.map((element) => element.data).toList();
}
