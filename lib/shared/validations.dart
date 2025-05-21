import 'strings.dart';

abstract class Validations {
  static final _url =
      RegExp(r'^(https?:\/\/)?([\w\-]+\.)+[\w\-]+(\/[\w\- .\/?%&=]*)?$');

  static String? validateUrl(String? value) {
    final hasValue = value != null && value.isNotEmpty;
    if (hasValue && !_url.hasMatch(value)) return Strings.invalidUrl;
    return null;
  }
}
