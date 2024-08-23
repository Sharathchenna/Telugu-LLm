import 'package:stacked/stacked.dart';
import 'package:hive/hive.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/app/app.logger.dart';
import 'package:swaram_ai/data/category_data.dart';
import 'package:swaram_ai/services/category_service.dart';
import 'package:swaram_ai/ui/widgets/common/chip_item/chip_item.dart';

class CategoryModel extends BaseViewModel {
  final CategoryService _categoryService = locator<CategoryService>();
  final _logger = getLogger("Category Model");
  Box settingsBox = Hive.box('settings');

  Future<List<ChipItem>> getCategoryData() async {
    _logger.d("Fetching category data...");
    var categoriesList = await _categoryService.getCategories();
    _logger.d(categoriesList);

    // Filter categoriesList by published column and sort by category_rank
    var filteredCategoriesList = categoriesList
        .where((category) => category["published"] == true);

    // filteredCategoriesList.sort((a, b) =>
    //    (a["category_rank"]).compareTo(b["category_rank"]));
    // TO-DO : sort function shows error in the above line


    return filteredCategoriesList
        .map((e) => ChipItem(
        id: e["\$id"],
        label: settingsBox.get('isEnglish', defaultValue: true)
            ? e["title"]
            : (e['title_telugu'] ?? e["title"]),
        imagePath: e["category_icon"] ?? "assets/icons/book_open.png"))
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