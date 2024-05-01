import 'package:stacked/stacked.dart';

class CategoryService with ListenableServiceMixin {
  final _showFront = ReactiveValue<bool>(true);
  String selectedCategoryId = "";

  bool get showFront => _showFront.value;

  CategoryService() {
    listenToReactiveValues([
      _showFront,
    ]);
  }

  void toggleCard() {
    _showFront.value = !_showFront.value;
    notifyListeners();
  }
}
