import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatusRepository {
  static const _channel = MethodChannel(
    'io.github.mrmdrx.wastash/status_files',
  );
  static const _statusesUriKey = "statuses_uri";

  static Future<void> requestStatusAccess() async {
    if (Platform.isAndroid) {
      final result = await _channel.invokeMethod('requestStatusFolderAccess');
      if (result is String) {
        await saveStatusFolderUri(result);
      }
    }
  }

  static Future<List<String>> getStatusFiles() async {
    try {
      final uri = await getStatusFolderUri();
      if (uri == null) return [];

      final files = await _channel.invokeMethod<List>('getStatusFiles', {
        'uri': uri,
      });
      return files?.map((path) => path.toString()).toList() ?? [];
    } catch (e) {
      if (kDebugMode) print('Error getting status files: $e');
      return [];
    }
  }

  static Future<String?> getStatusFolderUri() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_statusesUriKey);
  }

  static Future<List<String>> getSavedStatusFiles() async {
    try {
      final files = await _channel.invokeMethod<List>('getSavedStatusFiles');
      return files?.map((e) => e.toString()).toList() ?? [];
    } catch (e) {
      if (kDebugMode) print('Error getting saved status files: $e');
      return [];
    }
  }

  static Future<void> saveStatusFolderUri(String uri) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_statusesUriKey, uri);
  }

  static bool isImage(String uri) {
    final path = uri.toLowerCase();
    return path.endsWith('.jpg') ||
        path.endsWith('.jpeg') ||
        path.endsWith('.png') ||
        path.endsWith('.webp');
  }

  static bool isVideo(String uri) {
    final path = uri.toLowerCase();
    return path.endsWith('.mp4') ||
        path.endsWith('.mov') ||
        path.endsWith('.avi') ||
        path.endsWith('.webm');
  }

  static void setupDirectoryListener() {
    _channel.setMethodCallHandler((call) async {
      if (call.method == "onDirectorySelected") {
        final uri = call.arguments as String;
        await saveStatusFolderUri(uri);
        return true;
      }
      return null;
    });
  }

  static Stream<List<String>> watchStatusFiles() async* {
    while (true) {
      yield await getStatusFiles();
      await Future.delayed(const Duration(seconds: 5));
    }
  }

  static Stream<List<String>> watchSavedStatusFiles() async* {
    while (true) {
      yield await getSavedStatusFiles();
      await Future.delayed(const Duration(seconds: 5));
    }
  }
}
