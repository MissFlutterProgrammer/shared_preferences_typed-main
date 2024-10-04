# Typed Shared Preferences

[![pub package](https://img.shields.io/pub/v/shared_preferences_typed.svg)](https://pub.dartlang.org/packages/shared_preferences_typed)

A type-safe wrapper around [shared_preferences](https://pub.dev/packages/shared_preferences), inspired by [ts-localstorage](https://www.npmjs.com/package/ts-localstorage).

## Why?

- Dart compiler now prevents you from writing a `bool` to an `int` key
- You can organize everything related to [SharedPreferences] in one file, not just the string keys
- You don't need to call `SharedPreferences.getInstance()` anywhere anymore

## Usage

- You create a `PrefKey` or a `PrefKeyNullable`, pass a string as a key and a default value that's returned when the value doesn't exist in the SharedPreferences.
- In case of `PrefKeyNullable`, the default value is still required to guarantee type safety, but it's not actually used anywhere

Check `test/shared_preferences_typed_test.dart` for a more detailed example, here are the most common use cases:

### Basic example (non-nullable)

```dart
/// Description
const key = PrefKey("some_key", true);

final valueBefore = await key.read(); // -> true (default value)
await key.write(false); // -> Value is now false
```

### Basic example (nullable)

```dart
/// Description
const key = PrefKeyNullable("some_key", true);

final valueBefore = await key.read(); // -> null
await key.write(false); // -> Value is now false
```

### Existing SharedPreferences instance (non-nullable)

```dart
final prefs = await SharedPreferences.instance();

/// Description
const key = PrefKey("some_key", true);

final valueBefore = await key.readSync(prefs); // -> true (default value)
await key.write(false); // -> Value is now false
```

### Existing SharedPreferences instance (nullable)

```dart
final prefs = await SharedPreferences.instance();

/// Description
const key = PrefKeyNullable("some_key", true);

final valueBefore = await key.readSync(prefs); // -> null
await key.writeSync(false, prefs); // -> Value is now false
```

## Additional information

- Using an existing SharedPreferences instance has no performance gain if you don't also use it elsewhere. However, the sync methods have benefits when you really can't have `await` somewhere.
