class FormValidation {
  static String? validateEmptyValue(String? value) {
    value = value?.trim();
    if (value == null || value == "") return "Required field";
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    value = value?.trim();
    if (value == null || value == "") {
      return "Required field";
    } else {
      final RegExp regex = RegExp(r'^(\d{10}|(0|\+91)\d{10})$');
      var isValid = regex.hasMatch(value);
      if (!isValid) {
        return "Invalid Phone number";
      }
    }
    return null;
  }
}
