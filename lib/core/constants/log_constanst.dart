import 'dart:developer';

import 'package:flutter/foundation.dart';

// Check if in debug mode
const bool isDebugMode = kDebugMode;

// Log function that logs only in debug mode
void logDebug(String message) {
  if (isDebugMode) {
    log('DEBUG: $message');
  }
}

void printDebug(String message) {
  if (isDebugMode) {
    print('DEBUG: $message');
  }
}
