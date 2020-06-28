part of 'barcode_scanner_bloc.dart';

abstract class BarcodeScannerState extends Equatable {
  const BarcodeScannerState();
}

class BarcodeScanInitialState extends BarcodeScannerState {
  @override
  List<Object> get props => [];
}

class BarcodeScanningState extends BarcodeScannerState {
  @override
  List<Object> get props => [];
}

class BarcodeScannedState extends BarcodeScannerState {
  final String scannedMessage;

  const BarcodeScannedState(this.scannedMessage);

  @override
  List<Object> get props => [scannedMessage];
}

class BarcodeScanErrorState extends BarcodeScannerState {
  final String errorMessage;

  const BarcodeScanErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
