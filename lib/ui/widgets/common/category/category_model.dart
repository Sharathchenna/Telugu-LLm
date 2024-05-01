import 'package:stacked/stacked.dart';
import 'package:swaram_ai/data/category_data.dart';
import 'package:swaram_ai/ui/widgets/common/chip_item/chip_item.dart';

class CategoryModel extends BaseViewModel {
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
