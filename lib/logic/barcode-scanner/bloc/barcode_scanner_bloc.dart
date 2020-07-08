import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:bloc/bloc.dart';
import 'package:canidrink/core/config/instance_locator.dart';
import 'package:canidrink/data/barcode-scanner/barcode_product_prefix_repository.dart';
import 'package:canidrink/logic/barcode-scanner/service/barcode_scanner_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

part 'barcode_scanner_event.dart';
part 'barcode_scanner_state.dart';

class BarcodeScannerBloc
    extends Bloc<BarcodeScannerEvent, BarcodeScannerState> {
  static const String DEFAULT_PLATFORM_ERROR_MESSAGE =
      "Error on capturing barcode.";
  static const String DEFAULT_INVALID_SCAN_MESSAGE =
      "Scan only accepts EAN13 format.";
  static const String DEFAULT_SUCCESS_SCANNED_MESSAGE = "You can drink it!";
  static const String DEFAULT_FAIL_SCANNED_MESSAGE = "You can't drink it!";

  BarcodeScannerService _barcodeScannerService;
  BarcodeProductPrefixRepository _repository;

  BarcodeScannerBloc(
      {BarcodeScannerService barcodeScannerService,
      BarcodeProductPrefixRepository repository}) {
    this._barcodeScannerService =
        barcodeScannerService ?? locator.get<BarcodeScannerService>();
    this._repository =
        repository ?? locator.get<BarcodeProductPrefixRepository>();
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
        yield await this._getScannerStateResult(result);
      } //try
      on PlatformException {
        yield BarcodeScanErrorState(DEFAULT_PLATFORM_ERROR_MESSAGE);
      } //catch
    }
  } //func

  Future<BarcodeScannerState> _getScannerStateResult(ScanResult result) async {
    bool isEmptyResult = result != null && result.rawContent.isEmpty;
    if (isEmptyResult) {
      return BarcodeScanInitialState();
    } //if

    bool isEan13Format = result.format == BarcodeFormat.ean13;
    if (!isEan13Format) {
      return BarcodeScanErrorState(DEFAULT_INVALID_SCAN_MESSAGE);
    } //if

    return BarcodeScannedState(
        await this._getMessageByBarcode(result.rawContent));
  } //func

  Future<String> _getMessageByBarcode(String rawBarcode) async {
    List<String> desiredProductPrefixes =
        await this._repository.getProductPrefixes();
    bool isDesiredProductBarcode =
        desiredProductPrefixes.any((prefix) => rawBarcode.startsWith(prefix));
    return isDesiredProductBarcode
        ? DEFAULT_SUCCESS_SCANNED_MESSAGE
        : DEFAULT_FAIL_SCANNED_MESSAGE;
  } //func
} //class
