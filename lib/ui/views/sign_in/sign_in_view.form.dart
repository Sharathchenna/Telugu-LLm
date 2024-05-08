// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:swaram_ai/ui/common/form_validation.dart';

const bool _autoTextFieldValidation = true;

const String UserNameValueKey = 'userName';
const String PhoneNumberValueKey = 'phoneNumber';

final Map<String, TextEditingController> _SignInViewTextEditingControllers = {};

final Map<String, FocusNode> _SignInViewFocusNodes = {};

final Map<String, String? Function(String?)?> _SignInViewTextValidations = {
  UserNameValueKey: FormValidation.validateEmptyValue,
  PhoneNumberValueKey: FormValidation.validatePhoneNumber,
};

mixin $SignInView {
  TextEditingController get userNameController =>
      _getFormTextEditingController(UserNameValueKey);
  TextEditingController get phoneNumberController =>
      _getFormTextEditingController(PhoneNumberValueKey);

  FocusNode get userNameFocusNode => _getFormFocusNode(UserNameValueKey);
  FocusNode get phoneNumberFocusNode => _getFormFocusNode(PhoneNumberValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_SignInViewTextEditingControllers.containsKey(key)) {
      return _SignInViewTextEditingControllers[key]!;
    }

    _SignInViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _SignInViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_SignInViewFocusNodes.containsKey(key)) {
      return _SignInViewFocusNodes[key]!;
    }
    _SignInViewFocusNodes[key] = FocusNode();
    return _SignInViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    userNameController.addListener(() => _updateFormData(model));
    phoneNumberController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    userNameController.addListener(() => _updateFormData(model));
    phoneNumberController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          UserNameValueKey: userNameController.text,
          PhoneNumberValueKey: phoneNumberController.text,
        }),
    );

    if (_autoTextFieldValidation || forceValidate) {
      updateValidationData(model);
    }
  }

  bool validateFormFields(FormViewModel model) {
    _updateFormData(model, forceValidate: true);
    return model.isFormValid;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _SignInViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _SignInViewFocusNodes.values) {
      focusNode.dispose();
    }

    _SignInViewTextEditingControllers.clear();
    _SignInViewFocusNodes.clear();
  }
}

extension ValueProperties on FormStateHelper {
  bool get hasAnyValidationMessage => this
      .fieldsValidationMessages
      .values
      .any((validation) => validation != null);

  bool get isFormValid {
    if (!_autoTextFieldValidation) this.validateForm();

    return !hasAnyValidationMessage;
  }

  String? get userNameValue => this.formValueMap[UserNameValueKey] as String?;
  String? get phoneNumberValue =>
      this.formValueMap[PhoneNumberValueKey] as String?;

  set userNameValue(String? value) {
    this.setData(
      this.formValueMap..addAll({UserNameValueKey: value}),
    );

    if (_SignInViewTextEditingControllers.containsKey(UserNameValueKey)) {
      _SignInViewTextEditingControllers[UserNameValueKey]?.text = value ?? '';
    }
  }

  set phoneNumberValue(String? value) {
    this.setData(
      this.formValueMap..addAll({PhoneNumberValueKey: value}),
    );

    if (_SignInViewTextEditingControllers.containsKey(PhoneNumberValueKey)) {
      _SignInViewTextEditingControllers[PhoneNumberValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasUserName =>
      this.formValueMap.containsKey(UserNameValueKey) &&
      (userNameValue?.isNotEmpty ?? false);
  bool get hasPhoneNumber =>
      this.formValueMap.containsKey(PhoneNumberValueKey) &&
      (phoneNumberValue?.isNotEmpty ?? false);

  bool get hasUserNameValidationMessage =>
      this.fieldsValidationMessages[UserNameValueKey]?.isNotEmpty ?? false;
  bool get hasPhoneNumberValidationMessage =>
      this.fieldsValidationMessages[PhoneNumberValueKey]?.isNotEmpty ?? false;

  String? get userNameValidationMessage =>
      this.fieldsValidationMessages[UserNameValueKey];
  String? get phoneNumberValidationMessage =>
      this.fieldsValidationMessages[PhoneNumberValueKey];
}

extension Methods on FormStateHelper {
  setUserNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[UserNameValueKey] = validationMessage;
  setPhoneNumberValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[PhoneNumberValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    userNameValue = '';
    phoneNumberValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      UserNameValueKey: getValidationMessage(UserNameValueKey),
      PhoneNumberValueKey: getValidationMessage(PhoneNumberValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _SignInViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _SignInViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      UserNameValueKey: getValidationMessage(UserNameValueKey),
      PhoneNumberValueKey: getValidationMessage(PhoneNumberValueKey),
    });
