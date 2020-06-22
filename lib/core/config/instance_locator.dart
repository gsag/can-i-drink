import 'package:canidrink/logic/barcode-scanner/service/barcode_scanner_service.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void setupServiceLocator() {
  locator.registerFactory(() => BarcodeScannerService());
} //func
