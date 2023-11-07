import 'package:flutter/material.dart';

class ProviderC extends ChangeNotifier {
  String _nameText = '';
  String _phoneNumber = '';

//get functions
  String get nameText => _nameText;

  String get phoneNumber => _phoneNumber;

//constructor
  providerC(String value1, String value2) {
    _nameText = value1;
    _phoneNumber = value2;
    notifyListeners();
  }
}
