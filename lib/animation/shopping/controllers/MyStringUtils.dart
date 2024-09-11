class MyStringUtils {
  static bool isEmail(String text) {
    // Simple email regex check
    RegExp regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return regex.hasMatch(text);
  }
}
