import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'clock_controller.g.dart';

/// The current time, re-emitted every 20 seconds: enough for minute-level
/// countdowns and for windows to open and close on screen. Tests override it
/// with a fixed time.
@Riverpod(keepAlive: true)
Stream<DateTime> clock(Ref ref) async* {
  yield DateTime.now();
  yield* Stream.periodic(const Duration(seconds: 20), (_) => DateTime.now());
}
