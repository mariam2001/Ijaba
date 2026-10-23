import 'package:ijaba/features/windows/data/model/dua_window_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'enabled_windows_controller.g.dart';

/// Which windows alert. All of them until the Windows screen (step 5) lets
/// the user switch each one on or off.
@Riverpod(keepAlive: true)
Set<DuaWindowType> enabledWindowTypes(Ref ref) => DuaWindowType.values.toSet();
