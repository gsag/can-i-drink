import 'package:barcode_scan/barcode_scan.dart';
import 'package:canidrink/core/config/theme/malt_theme_data.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: MaltThemeConfig.maltThemeData,
      home: MyHomePage(title: 'Can I Drink?'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String barcode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Text(this.barcode),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: scan,
        tooltip: 'Scan',
        child: Icon(Icons.camera),
      ),
    );
  }

  Future<ScanResult> scan() async {
    ScanResult result = await BarcodeScanner.scan();
    print(result.type); // The result type (barcode, cancelled, failed)
    print(result.rawContent); // The barcode content
    print(result.format); // The barcode format (as enum)
    print(result.formatNote);
    setState(() {
      this.barcode = result.rawContent;
    });
    return result;
  }
}
