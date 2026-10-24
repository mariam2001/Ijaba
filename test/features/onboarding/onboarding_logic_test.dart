import 'package:flutter_test/flutter_test.dart';
import 'package:ijaba/core/utils/localized_digits.dart';
import 'package:ijaba/features/onboarding/presentation/controller/permission_steps_controller.dart';

void main() {
  group('permission steps run in order', () {
    PermissionSteps steps({
      bool notifications = false,
      bool exactAlarms = false,
      bool battery = false,
    }) => (
      notifications: notifications,
      exactAlarms: exactAlarms,
      battery: battery,
      brand: 'Oppo',
    );

    test('notifications come first', () {
      expect(steps(exactAlarms: true, battery: true).current, 0);
    });

    test('then exact alarms, then the battery setting', () {
      expect(steps(notifications: true).current, 1);
      expect(steps(notifications: true, exactAlarms: true).current, 2);
    });

    test('3 means everything is done', () {
      expect(
        steps(notifications: true, exactAlarms: true, battery: true).current,
        3,
      );
    });
  });

  test('step numbers use Arabic-Indic digits in Arabic', () {
    expect(localizedDigits(3, 'ar'), '٣');
    expect(localizedDigits(12, 'ar'), '١٢');
    expect(localizedDigits(3, 'en'), '3');
  });
}
