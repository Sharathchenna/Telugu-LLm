import 'package:stacked/stacked.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/app/app.logger.dart';
import 'package:swaram_ai/data/category_data.dart';
import 'package:swaram_ai/services/category_service.dart';
import 'package:swaram_ai/ui/widgets/common/chip_item/chip_item.dart';

class CategoryModel extends BaseViewModel {
  final CategoryService _categoryService = locator<CategoryService>();
  final _logger = getLogger("Category Model");

  Future<List<ChipItem>> getCategoryData() async {
    _logger.d("get category data called");
    var categoriesList = await _categoryService.getCategories();
    _logger.d(categoriesList);
    return categoriesList
        .map((e) => ChipItem(
            id: e["\$id"],
            label: e["title"],
            imagePath: "assets/icons/book_open.png"))
        .toList();
  }

  List<ChipItem> get categoryData {
    return categoryDataItem
        .map(
          (item) => ChipItem(
            id: item.id,
            label: item.label,
            imagePath: item.imagePath,
          ),
        )
        .toList();
  }
}
