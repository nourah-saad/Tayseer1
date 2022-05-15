import 'package:flutter_test/flutter_test.dart';
import 'package:tayseer2/authintication/login_screen.dart';

void main() {
  test('empty ID', () {
    var result = IDFieldValidator.validate('');
    expect("يرجى إدخال رقم الهوية/الإقامة", result);
  });

  test('invalid ID', () {
    var result = IDFieldValidator.validate('1105');
    expect("يرجى إدخال رقم هوية/إقامة صحيح", result);
  });

  test('valid ID', () {
    var result = IDFieldValidator.validate('1198878865');
    expect("رقم الهوية/إقامة صحيحة", result);
  });

  test('empty Password', () {
    var result = PasswordFieldValidator.validate('');
    expect("يرجى إدخال كلمة المرور", result);
  });

  test('invalid Password', () {
    var result = PasswordFieldValidator.validate('Nn11');
    expect("يرجى كلمة المرور بشكل صحيح", result);
  });

  test('valid Password', () {
    var result = PasswordFieldValidator.validate('Nn!7488235');
    expect("كلمة المرور صحيحة", result);
  });
}
