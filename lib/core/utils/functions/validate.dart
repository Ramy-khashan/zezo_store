class Validate {
  static RegExp upperCaseRegex = RegExp(r'[A-Z]');
  static RegExp lowerCaseRegex = RegExp(r'[a-z]');
  static RegExp phoneNumberRegex = RegExp(r'^(?:[0][1][0125])[0-9]{8}$');

  /// email validation
  static RegExp emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  ///validation Functions
  static String? validateName(String name) {
    if (name.isEmpty) {
      return 'Name is required';
    } else if (!name.contains(upperCaseRegex)) {
      return ("Name must contain Uppercase letter");
    } else if (!name.contains(lowerCaseRegex)) {
      return ("Name must contain Lowercase letter");
    } else {
      return null;
    }
  }

  static String? validateEgyptPhoneNumber(String number) {
    if (!phoneNumberRegex.hasMatch(number)) {
      return 'Invalid Mobile';
    }
    if (number.isEmpty) {
      return "Phone number is required";
    }
    return null;
  }
  static String? validateEmail(String email) {
    if (email.isEmpty) {
      return 'Email can not be empty';
    }
    if (!emailRegex.hasMatch(email)) {
      return 'Email not valid';
    } else {
      return null;
    }
  }

  static String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password can not be empty';
    } else if (password.length < 8) {
      return 'Password shoud be more than 8 character';
    } else {
      return null;
    }
  }

  static String? notEmpty(String val) {
    if (val.isEmpty) {
      return 'This field can not be empty';
    }

    return null;
  }  static String? notEmptyPinCode(String val) {
    if (val.isEmpty) {
      return 'Empty';
    }

    return null;
  }
}
