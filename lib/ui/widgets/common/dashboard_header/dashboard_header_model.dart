import 'package:stacked/stacked.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/services/category_service.dart';

class DashboardHeaderModel extends ReactiveViewModel {
  final _categoryService = locator<CategoryService>();

  @override
  List<ListenableServiceMixin> get listenableServices {
    return [_categoryService];
  }

  bool get showFrontSide => _categoryService.showFront;
}
