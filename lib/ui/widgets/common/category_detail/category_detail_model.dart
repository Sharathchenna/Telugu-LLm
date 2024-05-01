import 'package:stacked/stacked.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/data/category_data.dart';
import 'package:swaram_ai/services/category_service.dart';

class CategoryDetailModel extends ReactiveViewModel {
  final _categoryService = locator<CategoryService>();
  String title = "";
  String imagePath = "";
  String description = "";

  @override
  List<ListenableServiceMixin> get listenableServices => [_categoryService];

  void toggleCard() => _categoryService.toggleCard();

  void fetchCategoryDetails() {
    categoryDataItem
        .firstWhere((item) => item.id == _categoryService.selectedCategoryId);
  }
}
