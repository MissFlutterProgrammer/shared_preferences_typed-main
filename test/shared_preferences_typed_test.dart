import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:shared_preferences_typed/shared_preferences_typed.dart';

const _demoBool = true;
const _demoDouble = 2.0;
const _demoInt = 2;
const _demoString = "demo";
const _demoList = ["demo"];

const _defaultBool = false;
const _defaultDouble = 1.0;
const _defaultInt = 1;
const _defaultString = "default";
const _defaultList = ["default"];

const _kBool = PrefKey("_kBool", _defaultBool);
const _kBoolNullable = PrefKeyNullable("_kBoolNullable", _defaultBool);

const _kDouble = PrefKey("_kDouble", _defaultDouble);
const _kDoubleNullable = PrefKeyNullable("_kDoubleNullable", _defaultDouble);

const _kInt = PrefKey("_kInt", _defaultInt);
const _kIntNullable = PrefKeyNullable("_kIntNullable", _defaultInt);

const _kString = PrefKey("_kString", _defaultString);
const _kStringNullable = PrefKeyNullable("_kStringNullable", _defaultString);

const _kList = PrefKey("_kList", _defaultList);
const _kListNullable = PrefKeyNullable("_kListNullable", <String>[]);

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
  });

  test('Async, nullable', () async {
    _testKeyAsyncNullable(_kBoolNullable, _demoBool);
    _testKeyAsyncNullable(_kDoubleNullable, _demoDouble);
    _testKeyAsyncNullable(_kIntNullable, _demoInt);
    _testKeyAsyncNullable(_kStringNullable, _demoString);
    _testKeyAsyncNullable(_kListNullable, _demoList);
  });

  test('Async, non-nullable', () async {
    _testKeyAsyncNonNullable(_kBool, _demoBool, _defaultBool);
    _testKeyAsyncNonNullable(_kDouble, _demoDouble, _defaultDouble);
    _testKeyAsyncNonNullable(_kInt, _demoInt, _defaultInt);
    _testKeyAsyncNonNullable(_kString, _demoString, _defaultString);
    _testKeyAsyncNonNullable(_kList, _demoList, _defaultList);
  });

  test('Sync, nullable', () async {
    _testKeySyncNullable(_kBoolNullable, _demoBool);
    _testKeySyncNullable(_kDoubleNullable, _demoDouble);
    _testKeySyncNullable(_kIntNullable, _demoInt);
    _testKeySyncNullable(_kStringNullable, _demoString);
    _testKeySyncNullable(_kListNullable, _demoList);
  });

  test('Sync, non-nullable', () async {
    _testKeySyncNonNullable(_kBool, _demoBool, _defaultBool);
    _testKeySyncNonNullable(_kDouble, _demoDouble, _defaultDouble);
    _testKeySyncNonNullable(_kInt, _demoInt, _defaultInt);
    _testKeySyncNonNullable(_kString, _demoString, _defaultString);
    _testKeySyncNonNullable(_kList, _demoList, _defaultList);
  });
}

Future<void> _testKeyAsyncNullable<T>(
  PrefKeyNullable<T> key,
  T demoValue,
) async {
  expect(await key.read(), isNull);
  await key.write(demoValue);
  expect(await key.read(), equals(demoValue));
}

Future<void> _testKeyAsyncNonNullable<T>(
  PrefKeyNullable<T> key,
  T demoValue,
  T defaultValue,
) async {
  expect(await key.read(), equals(defaultValue));
  await key.write(demoValue);
  expect(await key.read(), equals(demoValue));
}

Future<void> _testKeySyncNullable<T>(
  PrefKeyNullable<T> key,
  T demoValue,
) async {
  final prefs = await SharedPreferences.getInstance();
  expect(await key.readSync(prefs), isNull);
  await key.writeSync(demoValue, prefs);
  expect(await key.readSync(prefs), equals(demoValue));
}

Future<void> _testKeySyncNonNullable<T>(
  PrefKeyNullable<T> key,
  T demoValue,
  T defaultValue,
) async {
  final prefs = await SharedPreferences.getInstance();
  expect(await key.readSync(prefs), equals(defaultValue));
  await key.writeSync(demoValue, prefs);
  expect(await key.readSync(prefs), equals(demoValue));
}
