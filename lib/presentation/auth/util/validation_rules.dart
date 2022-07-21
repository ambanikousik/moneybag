class ValidationRules {
  static String? email(String? text) {
    if (text == null || text.isEmpty) {
      return 'Please write something';
    } else if (!text.contains('@')) {
      return 'Please write a valid email address';
    } else {
      return null;
    }
  }

  static String? money(String? text) {
    if (text == null || text.isEmpty) {
      return 'Please write something';
    } else if (int.tryParse(text) == null) {
      return 'Only numbers are allowed';
    } else {
      return null;
    }
  }

  static String? password(String? text) {
    if (text == null || text.isEmpty) {
      return 'Please write something';
    } else if (text.length < 8) {
      return 'Password length should be minimum 8';
    } else {
      return null;
    }
  }

  static String? regular(String? text) {
    if (text == null || text.isEmpty) {
      return 'Please write something';
    } else {
      return null;
    }
  }
}
