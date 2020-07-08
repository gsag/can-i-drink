import 'package:canidrink/data/barcode-scanner/barcode_product_prefix_repository.dart';
import 'package:canidrink/logic/barcode-scanner/service/barcode_scanner_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void setupServiceLocator() {
  locator.registerFactory(() => BarcodeScannerService());
  locator.registerFactory(() => Firestore.instance);
  locator.registerFactory(() => BarcodeProductPrefixRepository());
} //func
