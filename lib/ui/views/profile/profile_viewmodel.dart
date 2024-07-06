import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ProfileViewModel extends BaseViewModel {
  bool isFormSubmitted = false;
  bool isLoading = false;

  late TextEditingController userNameController;
  late TextEditingController phoneNumberController;
  late TextEditingController emailController;
  late TextEditingController addressController;

  late FocusNode userNameFocusNode;
  late FocusNode phoneNumberFocusNode;
  late FocusNode emailFocusNode;
  late FocusNode addressFocusNode;

  String? emailValidationMessage;

  ProfileViewModel() {
    userNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    emailController = TextEditingController();
    addressController = TextEditingController();

    userNameFocusNode = FocusNode();
    phoneNumberFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    addressFocusNode = FocusNode();
  }

  bool get hasEmailValidationMessage =>
      emailValidationMessage != null && emailValidationMessage!.isNotEmpty;

  void saveProfile() async {
    isFormSubmitted = true;
    notifyListeners();

    if (_validateForm()) {
      isLoading = true;
      notifyListeners();

      isLoading = false;
      notifyListeners();
    }
  }

  bool _validateForm() {
    bool isValid = true;

    if (userNameController.text.isEmpty) {
      isValid = false;
    }

    if (phoneNumberController.text.isEmpty) {
      isValid = false;
    }

    if (!_validateEmail(emailController.text)) {
      emailValidationMessage = "Please enter a valid email.";
      isValid = false;
    } else {
      emailValidationMessage = null;
    }

    notifyListeners();
    return isValid;
  }

  bool _validateEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  @override
  void dispose() {
    userNameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    addressController.dispose();
    userNameFocusNode.dispose();
    phoneNumberFocusNode.dispose();
    emailFocusNode.dispose();
    addressFocusNode.dispose();
    super.dispose();
  }
}
