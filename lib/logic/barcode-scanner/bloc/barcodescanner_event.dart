part of 'barcodescanner_bloc.dart';

abstract class BarcodeScannerEvent extends Equatable {
  const BarcodeScannerEvent();
}

class GetBarcode extends BarcodeScannerEvent {
  const GetBarcode();

  @override
  List<Object> get props => [];
}
