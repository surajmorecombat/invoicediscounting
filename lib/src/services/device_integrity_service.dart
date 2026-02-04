import 'package:flutter/foundation.dart';
import 'package:jailbreak_root_detection/jailbreak_root_detection.dart';



enum AndroidIntegrityResult { safe, restricted, blocked }

class AndroidDeviceIntegrityService {
  static Future<AndroidIntegrityResult> evaluate() async {
    try {
      final detector = JailbreakRootDetection.instance;

      final isNotTrust = await detector.isNotTrust;
      final isJailBroken = await detector.isJailBroken;
      final isRealDevice = await detector.isRealDevice;
      final isOnExternalStorage = await detector.isOnExternalStorage;
      final issues = await detector.checkForIssues;
      final isDevMode = await detector.isDevMode;
      final bool hasIssues =
         
          (( issues.isNotEmpty) ||
              (issues is Map && issues.isNotEmpty));
     
      if (isNotTrust || isJailBroken || hasIssues) {
        return AndroidIntegrityResult.blocked;
      }

     
      final bool mediumRisk = !isRealDevice || isOnExternalStorage || isDevMode;

      if (mediumRisk) {
        return kDebugMode
            ? AndroidIntegrityResult.safe
            : AndroidIntegrityResult.restricted;
      }

      return AndroidIntegrityResult.safe;
    } catch (_) {
     
      return kDebugMode
          ? AndroidIntegrityResult.safe
          : AndroidIntegrityResult.blocked;
    }
  }
}
