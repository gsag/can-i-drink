import 'package:canidrink/logic/barcode-scanner/bloc/barcode_scanner_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {});
  test("Should GetBarcode event have no props", () {
    //Act
    final BarcodeScannerEvent event = GetBarcode();
    //Assert
    expect(event.props, isEmpty);
  });
} //func
