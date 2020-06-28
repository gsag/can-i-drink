import 'package:canidrink/logic/barcode-scanner/bloc/barcode_scanner_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BarcodeScannerPage extends StatelessWidget {
  const BarcodeScannerPage({Key key, this.pageTitle}) : super(key: key);

  final String pageTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(pageTitle)),
      body: Container(
        child: BlocBuilder<BarcodeScannerBloc, BarcodeScannerState>(
          builder: (context, state) {
            return this.getPageContentByState(context, state);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: Key("ScanFloatingActionButton"),
        onPressed: () {
          BlocProvider.of<BarcodeScannerBloc>(context).add(GetBarcode());
        },
        child: Icon(
          Icons.camera,
          key: Key("ScanIcon"),
        ),
        tooltip: "Scan a barcode",
      ),
    );
  } //func

  Widget getPageContentByState(
      BuildContext context, BarcodeScannerState state) {
    switch (state.runtimeType) {
      case BarcodeScanInitialState:
        return this.getPageContainer(context, "Scan a barcode");
      case BarcodeScanningState:
        return this.getPageContainer(context, "Scanning");
      case BarcodeScannedState:
        BarcodeScannedState castedState = state;
        return this.getPageContainer(context, castedState.scannedMessage);
      default:
        BarcodeScanErrorState castedState = state;
        return this.getPageContainer(context, castedState.errorMessage);
    }
  } //func

  Container getPageContainer(BuildContext context, String contentStr) {
    return Container(
        alignment: Alignment.center,
        child: Text(
          contentStr,
          style: Theme.of(context).textTheme.headline6,
        ));
  } //func
} //class
