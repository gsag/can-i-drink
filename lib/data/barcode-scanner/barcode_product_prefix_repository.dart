import 'dart:async';

import 'package:canidrink/core/config/instance_locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BarcodeProductPrefixRepository {
  Firestore _firestore;
  final String _collectionName = "barcode_product_prefixes";
  final String _documentAttribute = "product_prefix";

  BarcodeProductPrefixRepository({Firestore firestore}) {
    this._firestore = firestore ?? locator.get<Firestore>();
  } //func

  Future<List<String>> getProductPrefixes() async {
    final QuerySnapshot snapshot =
        await this._firestore.collection(this._collectionName).getDocuments();
    List<String> documents = snapshot.documents
        .map((doc) => doc[_documentAttribute] as String)
        .toList();
    return Future<List<String>>.sync(() => documents);
  } //func
} //class
