import 'package:stacked/stacked.dart';
import 'package:swaram_ai/data/category_data.dart';
import 'package:swaram_ai/ui/widgets/common/chip_item/chip_item.dart';

class CategoryModel extends BaseViewModel {
  List<ChipItem> getCategoryData() {
    return categoryData
        .map(
          (item) => ChipItem(
            label: item.label,
            imagePath: item.imagePath,
            selectedColor: item.selectedColor,
          ),
        )
        .toList();
  }
}
