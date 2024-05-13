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
    var item = _categoryService.categoryData.firstWhere(
        (element) => element["\$id"] == _categoryService.selectedCategoryId);
    title = item["title"];
    description = item["Description"];
    rebuildUi();
  }
}
