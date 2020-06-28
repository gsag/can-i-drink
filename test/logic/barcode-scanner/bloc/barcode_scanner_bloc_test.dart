import 'package:barcode_scan/barcode_scan.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:canidrink/logic/barcode-scanner/bloc/barcode_scanner_bloc.dart';
import 'package:canidrink/logic/barcode-scanner/service/barcode_scanner_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockBarcodeScannerService extends Mock implements BarcodeScannerService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  BarcodeScannerBloc bloc;
  MockBarcodeScannerService service;

  setUp(() {
    service = MockBarcodeScannerService();
    bloc = BarcodeScannerBloc(barcodeScannerService: service);
  });

  test("Should emit [BarcodeScanInitialState] when successful", () {
    //Arrange
    BarcodeScannerState state = bloc.initialState;
    //Assert
    expect(state, isA<BarcodeScanInitialState>());
  });

  blocTest(
    "Should emit [BarcodeScanningState, BarcodeScannedState] when successful",
    build: () {
      when(service.scanBarcode()).thenAnswer((_) => Future<ScanResult>.value(
          new ScanResult(
              rawContent: "7891991012345", format: BarcodeFormat.ean13)));
      return Future.value(bloc);
    },
    act: (bloc) => bloc.add(GetBarcode()),
    expect: [
      BarcodeScanningState(),
      BarcodeScannedState(BarcodeScannerBloc.DEFAULT_SUCCESS_SCANNED_MESSAGE)
    ],
  );

  blocTest(
    "Should emit [BarcodeScanningState, BarcodeScanInitialState] when scan result is empty",
    build: () {
      when(service.scanBarcode()).thenAnswer((_) => Future<ScanResult>.value(
          new ScanResult(rawContent: "", format: BarcodeFormat.unknown)));
      return Future.value(bloc);
    },
    act: (bloc) => bloc.add(GetBarcode()),
    expect: [
      BarcodeScanningState(),
      BarcodeScanInitialState(),
    ],
  );

  blocTest(
    "Should emit [BarcodeScanningState, BarcodeScanErrorState] when barcode format is not ean13",
    build: () {
      when(service.scanBarcode()).thenAnswer((_) => Future<ScanResult>.value(
          new ScanResult(rawContent: "0", format: BarcodeFormat.unknown)));
      return Future.value(bloc);
    },
    act: (bloc) => bloc.add(GetBarcode()),
    expect: [
      BarcodeScanningState(),
      BarcodeScanErrorState(BarcodeScannerBloc.DEFAULT_INVALID_SCAN_MESSAGE),
    ],
  );

  blocTest(
    "Should emit [BarcodeScanningState(), BarcodeScanErrorState] when unsuccessful",
    build: () {
      when(service.scanBarcode()).thenThrow(PlatformException(code: "0"));
      return Future.value(bloc);
    },
    act: (bloc) => bloc.add(GetBarcode()),
    expect: [
      BarcodeScanningState(),
      BarcodeScanErrorState(BarcodeScannerBloc.DEFAULT_PLATFORM_ERROR_MESSAGE)
    ],
  );
} //func
