import 'package:flutter/material.dart';


class FormProvider extends ChangeNotifier {
  ValidationModel _email = ValidationModel(null, null);
  ValidationModel _name = ValidationModel(null, null);
  ValidationModel _phone = ValidationModel(null, null);
  ValidationModel _password = ValidationModel(null, null);
  ValidationModel get email => _email;
  ValidationModel get name => _name;
  ValidationModel get phone => _phone;
  ValidationModel get password => _password;


  void validateEmail(String? val) {
    if (val != null && val.isValidEmail) {
      _email = ValidationModel(val, null);
    } else {
      _email = ValidationModel(null, 'Please Enter a Valid Email');
    }
    notifyListeners();
  }

  void validateName(String? val) {
    if (val != null && val.isValidName) {
      _name = ValidationModel(val, null);
    } else {
      _name = ValidationModel(null, 'Please enter a valid name');
    }
    notifyListeners();
  }
  void validatePhone(String? val) {
    if (val != null && val.isValidPhone) {
      _phone = ValidationModel(val, null);
    } else {
      _phone = ValidationModel(null, 'Phone Number must be up to 12 digits');
    }
    notifyListeners();
  }

  void validatePassword(String? val) {
    if (val != null && val.isValidPassword) {
      _password = ValidationModel(val, null);
    } else {
      _password = ValidationModel(null,
          'Password must contain an uppercase, lowercase, \nnumeric digit and special character');
    }

    notifyListeners();
  }

  bool get validate {
    return _email.value != null &&
        _name.value != null &&
        _phone.value != null &&
        _password.value != null;
  }

}


class ValidationModel {
  String? value;
  String? error;
  ValidationModel(this.value, this.error);
}


extension extString on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName{
    final nameRegExp = RegExp(r"^\s*([A-Za-z]{1,}([.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPhone{
    final phoneRegExp = RegExp(r"^\+?0[0-9]{11}$");
    return phoneRegExp.hasMatch(this);
  }

  bool get isValidPassword{
    final passwordRegExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$');
    return passwordRegExp.hasMatch(this);
  }


}