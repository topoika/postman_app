import '../models/package.dart';
import 'app.controller.dart';

class PackageController extends AppController {
  Package package = Package();
  String? error;

  setError(val) => setState(() => error = val);
}
