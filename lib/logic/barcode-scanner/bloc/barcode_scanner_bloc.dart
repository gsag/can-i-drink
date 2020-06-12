import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

part 'barcode_scanner_event.dart';
part 'barcode_scanner_state.dart';

class BarcodeScannerBloc
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
        ScanResult result = await this.scanBarcode();
        bool hasValidResult = result.rawContent.isNotEmpty;
        yield hasValidResult
            ? BarcodeScannedState(result.rawContent)
            : BarcodeScanInitialState();
      } //try
      on PlatformException {
        yield BarcodeScanErrorState("Error on capturing barcode.");
      } //catch
    }
  } //func

  Future<ScanResult> scanBarcode() async {
    return BarcodeScanner.scan();
  } //func

} //class
