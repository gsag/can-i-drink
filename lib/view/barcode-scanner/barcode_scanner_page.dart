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
            if (state is BarcodeScanInitialState) {
              print("initial");
              return Text("Scan a barcode");
            } else if (state is BarcodeScanningState) {
              print("scanning");
              return Text("Scanning");
            } else if (state is BarcodeScannedState) {
              print("scanned");
              return Text(state.barcode);
            } else if (state is BarcodeScanErrorState) {
              print("error");
              return Text(state.errorMessage);
            } else {
              return Text("Unmapped state");
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<BarcodeScannerBloc>(context).add(GetBarcode());
        },
        child: Icon(Icons.camera),
        tooltip: "Scan a barcode",
      ),
    );
  } //func
} //class
