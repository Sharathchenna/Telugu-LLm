import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/app/app.logger.dart';
import 'package:swaram_ai/services/category_service.dart';

class CategoryDetailModel extends ReactiveViewModel {
  final _categoryService = locator<CategoryService>();
  final _logger = getLogger("Category Detail Model");
  String title = "";
  String imagePath = "";
  String description = "";
  Box settingsBox = Hive.box('settings');

  @override
  List<ListenableServiceMixin> get listenableServices => [_categoryService];

  CategoryDetailModel() {
    fetchCategoryDetails();
  }

  void toggleCard() {
    _categoryService.toggleCard();
    _categoryService.selectedCategoryId = "";
  }

  void fetchCategoryDetails() {
    _logger.d("Fetch category method called");
    var item = _categoryService.categoryData.firstWhere(
        (element) => element["\$id"] == _categoryService.selectedCategoryId);
    title = settingsBox.get('isEnglish', defaultValue: true) ? item["title"] : (item["title_telugu"] ?? item["title"]);
    description = settingsBox.get('isEnglish', defaultValue: true) ? item["Description"] : (item["description_telugu"] ?? item["Description"]);
    rebuildUi();
  }
}
