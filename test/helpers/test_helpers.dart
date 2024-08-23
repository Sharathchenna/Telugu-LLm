import 'package:mockito/annotations.dart';
import 'package:swaram_ai/services/stopwatch_service.dart';
// @stacked-import

@GenerateMocks([], customMocks: [
  MockSpec<StopwatchService>(onMissingStub: OnMissingStub.returnDefault),
// @stacked-mock-spec
])
void registerServices() {
// @stacked-mock-register
}

// @stacked-mock-create
