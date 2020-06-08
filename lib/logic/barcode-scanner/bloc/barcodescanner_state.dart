part of 'barcodescanner_bloc.dart';

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
  final String barcode;

  const BarcodeScannedState(this.barcode);

  @override
  List<Object> get props => [barcode];
}

class BarcodeScanErrorState extends BarcodeScannerState {
  final String errorMessage;

  const BarcodeScanErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
