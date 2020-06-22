import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:bloc/bloc.dart';
import 'package:canidrink/core/config/instance_locator.dart';
import 'package:canidrink/logic/barcode-scanner/service/barcode_scanner_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

part 'barcode_scanner_event.dart';
part 'barcode_scanner_state.dart';

class BarcodeScannerBloc
    extends Bloc<BarcodeScannerEvent, BarcodeScannerState> {
  static const List<String> DESIRED_PRODUCT_CODE_PREFIXES = [
    "78919910",
    "78911490"
  ];
  static const String DEFAULT_PLATFORM_ERROR_MESSAGE =
      "Error on capturing barcode.";
  static const String DEFAULT_INVALID_SCAN_MESSAGE =
      "Scan has an invalid format.";
  static const String DEFAULT_SUCCESS_SCANNED_MESSAGE = "You can drink it!";
  static const String DEFAULT_FAIL_SCANNED_MESSAGE = "You can't drink it!";

  BarcodeScannerService _barcodeScannerService;

  BarcodeScannerBloc({BarcodeScannerService barcodeScannerService}) {
    this._barcodeScannerService =
        barcodeScannerService ?? locator.get<BarcodeScannerService>();
  }

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
        yield* this._getScannerStateStream(result);
      } //try
      on PlatformException {
        yield BarcodeScanErrorState(DEFAULT_PLATFORM_ERROR_MESSAGE);
      } //catch
    }
  } //func

  Stream<BarcodeScannerState> _getScannerStateStream(ScanResult result) async* {
    bool isEmptyResult = result != null && result.rawContent.isEmpty;
    if (isEmptyResult) {
      yield BarcodeScanInitialState();
    } //if

    bool isEan13Format = result.format == BarcodeFormat.ean13;
    if (!isEan13Format) {
      yield BarcodeScanErrorState(DEFAULT_INVALID_SCAN_MESSAGE);
    } //if

    if (!isEmptyResult && isEan13Format) {
      yield BarcodeScannedState(this._getMessageByBarcode(result.rawContent));
    } //if
  } //func

  String _getMessageByBarcode(String rawBarcode) {
    bool isDesiredProductBarcode = DESIRED_PRODUCT_CODE_PREFIXES
        .any((prefix) => rawBarcode.startsWith(prefix));
    return isDesiredProductBarcode
        ? DEFAULT_SUCCESS_SCANNED_MESSAGE
        : DEFAULT_FAIL_SCANNED_MESSAGE;
  } //func

} //class
