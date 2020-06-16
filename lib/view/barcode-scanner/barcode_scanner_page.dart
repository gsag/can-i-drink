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
    if (state is BarcodeScanInitialState) {
      return Text("Scan a barcode");
    } else if (state is BarcodeScanningState) {
      return Text("Scanning");
    } else if (state is BarcodeScannedState) {
      return Text(state.barcode);
    } else if (state is BarcodeScanErrorState) {
      return Text(state.errorMessage);
    } else {
      return Text("Unmapped state");
    }
  } //func
} //class
