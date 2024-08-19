class TextValidator {
  static String? textValidator(String? value) {
    {
      if (value == null || value.isEmpty) {
        return 'Enter your email';
      }
      return null;
    }
  }

  static String? passwordValidator(String? value) {
    {
      if (value == null || value.isEmpty) {
        return 'Enter your password';
      }
      return null;
    }
  }
}
