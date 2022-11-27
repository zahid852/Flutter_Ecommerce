import 'dart:async';
import 'package:ecomerce/Presentations/BaseViewModel/base_view_model.dart';

class loginViewModel extends baseViewModel
    with loginViewModelInput, loginViewModelOutput {
  bool _IsNameValid = false;
  bool _IsEmailValid = false;
  StreamController _PhoneNumberStreamController =
      StreamController<String>.broadcast();
  StreamController _NameFocusStreamController =
      StreamController<bool>.broadcast();
  StreamController _EmailFocusStreamController =
      StreamController<bool>.broadcast();
  StreamController _NameStreamController = StreamController<String>.broadcast();

  StreamController _EmailStreamController =
      StreamController<String>.broadcast();
  StreamController _IsAllInputValidStreamController =
      StreamController<void>.broadcast();
  @override
  void dispose() {
    _PhoneNumberStreamController.close();
    _EmailStreamController.close();
    _NameStreamController.close();
  }

  @override
  void start() {}

  setPhoneNumber(String phoneNumber) {
    InputNumber.add(phoneNumber);
  }

  validate() {
    InputIsAllInputValid.add(null);
  }

  bool isPhoneNumberValid(String phone) {
    return phone.length == 10;
  }

  setName(String name) {
    InputName.add(name);
    validate();
  }

  bool isNameValid(String name) {
    _IsNameValid = name.isNotEmpty;
    return _IsNameValid;
  }

  setEmail(String email) {
    InputEmail.add(email);
    validate();
  }

  setNameFieldFocus(bool focus) {
    InputNameFocus.add(focus);
  }

  setEmailFieldFocus(bool focus) {
    InputEmailFocus.add(focus);
  }

  bool isEmailValid(String email) {
    _IsEmailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return _IsEmailValid;
  }

  @override
  Sink get InputNumber => _PhoneNumberStreamController.sink;

  @override
  Stream<bool> get OutputIsNumberValid => _PhoneNumberStreamController.stream
      .map((phoneNumber) => isPhoneNumberValid(phoneNumber));

  @override
  Sink get InputEmail => _EmailStreamController.sink;

  @override
  Sink get InputName => _NameStreamController.sink;

  @override
  Stream<bool> get OutputIsEmailValid =>
      _EmailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<bool> get OutputIsNameValid =>
      _NameStreamController.stream.map((name) => isNameValid(name));

  @override
  Sink get InputIsAllInputValid => _IsAllInputValidStreamController.sink;

  @override
  Stream<bool> get OutputIsAllInputValid =>
      _IsAllInputValidStreamController.stream.map((_) => _IsAllInputValid());
  bool _IsAllInputValid() {
    if (_IsEmailValid && _IsNameValid) {
      return true;
    }
    return false;
  }

  @override
  Sink get InputNameFocus => _NameFocusStreamController.sink;

  @override
  Stream<bool> get OutputIsNameFieldFocus =>
      _NameFocusStreamController.stream.map((focus) => focus);

  @override
  Sink get InputEmailFocus => _EmailFocusStreamController.sink;

  @override
  Stream<bool> get OutputIsEmailFocus =>
      _EmailFocusStreamController.stream.map((focus) => focus);
}

abstract class loginViewModelInput {
  Sink get InputNumber;
  Sink get InputName;
  Sink get InputEmail;
  Sink get InputNameFocus;
  Sink get InputEmailFocus;
  Sink get InputIsAllInputValid;
}

abstract class loginViewModelOutput {
  Stream<bool> get OutputIsNumberValid;
  Stream<bool> get OutputIsNameValid;
  Stream<bool> get OutputIsEmailValid;
  Stream<bool> get OutputIsNameFieldFocus;
  Stream<bool> get OutputIsEmailFocus;
  Stream<bool> get OutputIsAllInputValid;
}
