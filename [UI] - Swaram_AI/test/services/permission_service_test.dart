import 'package:flutter_test/flutter_test.dart';
import 'package:swaram_ai/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('PermissionServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
