import 'package:stacked/stacked.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/data/category_data.dart';
import 'package:swaram_ai/services/category_service.dart';
import 'package:swaram_ai/ui/widgets/common/chip_item/chip_item.dart';

class CategoryModel extends BaseViewModel {
  late CategoryService _categoryService;
  CategoryModel() {
    _categoryService = locator<CategoryService>();
  }

  // List<ChipItem> getCategoryData() async {
  //   var categoriesList = await _categoryService.getCategories();
  //   return categoriesList.map((e) => ChipItem(id: id, label: label, imagePath: imagePath))
  // }

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
