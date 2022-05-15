import 'package:flutter_test/flutter_test.dart';
import 'package:tayseer2/dummy_view/dummy_Screen.dart';

void main() {
  test('empty ID', () {
    var result = EmailFieldValidator.validate('');
    expect("يرجى إدخال البريد الإلكتروني", result);
  });
}
