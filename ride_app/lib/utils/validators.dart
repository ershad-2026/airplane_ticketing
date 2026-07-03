class Validators {
  Validators._();

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return "ইমেইল দিতে হবে";
    final regex = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,4}$');
    if (!regex.hasMatch(value.trim())) return "সঠিক ইমেইল দিন";
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return "পাসওয়ার্ড দিতে হবে";
    if (value.length < 6) return "কমপক্ষে ৬ ক্যারেক্টার দিন";
    return null;
  }

  static String? fullName(String? value) {
    if (value == null || value.trim().isEmpty) return "নাম দিতে হবে";
    if (value.trim().length < 2) return "সঠিক নাম দিন";
    return null;
  }

  static String? required(String? value, {String message = "এই ফিল্ড আবশ্যক"}) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }
}
