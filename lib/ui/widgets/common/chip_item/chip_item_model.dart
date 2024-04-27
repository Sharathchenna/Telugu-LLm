import 'package:stacked/stacked.dart';

class ChipItemModel extends BaseViewModel {
  bool isSelected = false;

  changeInSelection() {
    isSelected = !isSelected;
    rebuildUi();
  }
}
