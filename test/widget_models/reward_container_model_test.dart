import 'package:flutter_test/flutter_test.dart';
import 'package:swaram_ai/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('RewardContainerModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
