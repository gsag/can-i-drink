import 'package:barcode_scan/barcode_scan.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:canidrink/logic/barcode-scanner/bloc/barcode_scanner_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockBarcodeScannerBloc
    extends MockBloc<BarcodeScannerEvent, BarcodeScannerState>
    implements BarcodeScannerBloc {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  BarcodeScannerBloc bloc;
  MockBarcodeScannerBloc mockBloc;

  setUp(() {
    bloc = BarcodeScannerBloc();
    mockBloc = MockBarcodeScannerBloc();

    when(mockBloc.scanBarcode()).thenAnswer(
        (_) => Future<ScanResult>.value(new ScanResult(rawContent: "0")));
  });

  test("Should get initial state when it's called", () {
    //Arrange
    BarcodeScannerState state = bloc.initialState;
    //Assert
    expect(state, isA<BarcodeScanInitialState>());
  });

//   blocTest(
//     'Should emit [BarcodeScanInitialState, BarcodeScanningState, BarcodeScannedState] when successful',
//     build: () async => mockBloc,
//     act: (mockBloc) => mockBloc.add(GetBarcode()),
//     expect: [BarcodeScanningState()],
//   );
} //class
