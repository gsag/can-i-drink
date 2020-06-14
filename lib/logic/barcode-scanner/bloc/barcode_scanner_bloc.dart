import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:bloc/bloc.dart';
import 'package:canidrink/logic/barcode-scanner/service/barcode-scanner-service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

part 'barcode_scanner_event.dart';
part 'barcode_scanner_state.dart';

class BarcodeScannerBloc
    extends Bloc<BarcodeScannerEvent, BarcodeScannerState> {
  BarcodeScannerService _barcodeScannerService = BarcodeScannerService();

  BarcodeScannerBloc({BarcodeScannerService barcodeScannerService})
      : this._barcodeScannerService = barcodeScannerService;

  @override
  BarcodeScannerState get initialState => BarcodeScanInitialState();

  @override
  Stream<BarcodeScannerState> mapEventToState(
    BarcodeScannerEvent event,
  ) async* {
    yield BarcodeScanningState();

    if (event is GetBarcode) {
      try {
        ScanResult result = await this._barcodeScannerService.scanBarcode();
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

} //class
