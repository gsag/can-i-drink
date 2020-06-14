import 'package:barcode_scan/barcode_scan.dart';
import 'package:barcode_scan/model/scan_result.dart';

class BarcodeScannerService {
  Future<ScanResult> scanBarcode() async {
    return BarcodeScanner.scan();
  } //func
}
