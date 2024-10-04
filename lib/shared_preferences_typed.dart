library shared_preferences_typed;

import 'package:shared_preferences/shared_preferences.dart';

/// A typed [SharedPreferences] wrapper.
class PrefKeyNullable<T> {
  /// The key used to store the value.
  final String key;

  /// The default value to use as a type guard.
  /// If you're using a [PrefKey], this also acts as a default value.
  final T defaultValue;

  const PrefKeyNullable(
    this.key,
    this.defaultValue,
  ) : assert(
          defaultValue is bool ||
              defaultValue is String ||
              defaultValue is double ||
              defaultValue is int ||
              defaultValue is List<String>,
        );

  /// Returns true, if the key exists within the [SharedPreferences].
  Future<bool> exists([SharedPreferences? prefs]) async {
    final p = prefs ?? await SharedPreferences.getInstance();
    return p.containsKey(key);
  }

  /// Removes the key from [SharedPreferences]
  Future<bool> remove([SharedPreferences? prefs]) async {
    final p = prefs ?? await SharedPreferences.getInstance();
    return p.remove(key);
  }

  /// Returns the value of the key.
  /// Returns [defaultValue] during test mode.
  Future<T?> read([SharedPreferences? prefs]) async {
    final p = prefs ?? await SharedPreferences.getInstance();
    return readSync(p);
  }

  /// Returns the value of the key.
  /// Use `.read()` if you don't have an existing [SharedPreferences] instance.
  /// Returns [defaultValue] during test mode.
  Future<T?> readSync(SharedPreferences prefs) async {
    switch (T) {
      case bool:
        return prefs.getBool(key) as T?;
      case double:
        return prefs.getDouble(key) as T?;
      case int:
        return prefs.getInt(key) as T?;
      case String:
        return prefs.getString(key) as T?;
      case List<String>:
        return prefs.getStringList(key) as T?;
      default:
        return prefs.get(key) as T?;
    }
  }

  /// Write a value to [SharedPreferences].
  /// Does nothing during test mode.
  Future<void> write(T value, [SharedPreferences? prefs]) async {
    final p = prefs ?? await SharedPreferences.getInstance();
    writeSync(value, p);
  }

  /// Write a value to [SharedPreferences].
  /// Use `.write()` if you don't have an existing [SharedPreferences] instance.
  /// Does nothing during test mode.
  Future<void> writeSync(T value, SharedPreferences prefs) async {
    assert(
      value != null,
      "You can't write null to SharedPreferences. Use key.remove() instead.",
    );
    switch (T) {
      case bool:
        prefs.setBool(key, value as bool);
        break;
      case double:
        prefs.setDouble(key, value as double);
        break;
      case int:
        prefs.setInt(key, value as int);
        break;
      case String:
        prefs.setString(key, value as String);
        break;
      case List<String>:
        prefs.setStringList(key, value as List<String>);
        break;
      default:
        assert(false, "write was called with an unsupported type: $T");
    }
  }

  @override
  String toString() => key;
}

/// Non-nullable version of [PrefKeyNullable].
class PrefKey<T> extends PrefKeyNullable<T> {
  const PrefKey(
    /// Tset2
    String key,
    T value,
  ) : super(key, value);

  @override
  Future<T> read([SharedPreferences? prefs]) async {
    return await super.read(prefs) ?? defaultValue;
  }

  @override
  Future<T> readSync(SharedPreferences prefs) async {
    return await super.readSync(prefs) ?? defaultValue;
  }
}
