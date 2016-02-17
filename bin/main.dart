import 'package:redstone/redstone.dart' as app;
import 'package:redstone_sample/rest_api.dart';

main() {
  app.redstoneSetUp([#rest_api]);
  app.setupConsoleLog();
  app.showErrorPage = false;
  app.start(port: 8084);
}
