import 'package:mockito/annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:swaram_ai/app/app.locator.dart';
import 'package:swaram_ai/services/timer_service.dart';
import 'package:swaram_ai/services/record_service.dart';
import 'package:swaram_ai/services/category_service.dart';

import 'test_helpers.mocks.dart';
// @stacked-import

@GenerateMocks([], customMocks: [
  MockSpec<NavigationService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<BottomSheetService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<DialogService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<TimerService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<RecordService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<CategoryService>(onMissingStub: OnMissingStub.returnDefault),
// @stacked-mock-spec
])
void registerServices() {
  getAndRegisterCategoryService();
// @stacked-mock-register
}

MockCategoryService getAndRegisterCategoryService() {
  final service = MockCategoryService();
  locator.registerSingleton<CategoryService>(service);
  return service;
}
// @stacked-mock-create
