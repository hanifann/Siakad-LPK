
import 'package:flutter/widgets.dart';
import 'app/view/app.dart';
import 'bootstrap.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  bootstrap(() => const App());
}