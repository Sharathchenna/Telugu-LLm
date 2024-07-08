import 'package:stacked/stacked.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/services/category_service.dart';

class ChipItemModel extends ReactiveViewModel {
  final _categoryService = locator<CategoryService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_categoryService];

  void toggleChipCard(String id) {
    _categoryService.selectedCategoryId = id;
    _categoryService.toggleCard();
  }
}
