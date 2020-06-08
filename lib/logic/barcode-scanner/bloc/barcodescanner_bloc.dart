import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

part 'barcodescanner_event.dart';
part 'barcodescanner_state.dart';

class BarcodescannerBloc
    extends Bloc<BarcodeScannerEvent, BarcodeScannerState> {
  @override
  BarcodeScannerState get initialState => BarcodeScanInitialState();

  @override
  Stream<BarcodeScannerState> mapEventToState(
    BarcodeScannerEvent event,
  ) async* {
    yield BarcodeScanningState();

    if (event is GetBarcode) {
      try {
        ScanResult result = await BarcodeScanner.scan();
        yield BarcodeScannedState(result.rawContent);
      } //try
      on PlatformException {
        yield BarcodeScanErrorState("erro");
      } //catch
    }
  }
}
