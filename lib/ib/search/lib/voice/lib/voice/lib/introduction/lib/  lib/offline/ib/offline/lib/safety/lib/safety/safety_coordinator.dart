import 'dart:async';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:geolocator/geolocator.dart';
import 'driver_models.dart';

/// Implement this and pass it in when you create SafetyCoordinator.
/// You can wire it to a tiny HTTPS function (Supabase/Firebase) that relays
/// to email/WhatsApp so you don't pay SMS fees.
typedef SafetySender = Future<void> Function(Map<String, dynamic> payload);

class SafetyCoordinator {
  SafetyCoordinator({
    required this.sender,
    required this.contacts,
  });

  final SafetySender sender;
  final List<EmergencyContact> contacts;

  final FlutterTts _tts = FlutterTts();
  Timer? _timer;
  String? _tripId;

  /// Speaks the driver & vehicle details for blind/partially sighted users.
  Future<void> announceDriver(DriverSummary d, {String locale = 'en-ZA'}) async {
    await _tts.setLanguage(locale);
    await _tts.setSpeechRate(0.45);
    await _tts.speak(d.spoken());
  }

  /// Shares the driver details (and optional destination text) with contacts.
  Future<void> shareDriverDetails(String tripId, DriverSummary d, String destinationText) async {
    final payload = {
      "type": "driver_details",
      "tripId": tripId,
      "driver": {
        "provider": d.provider,
        "name": d.driverName,
        "vehicle": {"color": d.carColor, "make": d.carMake, "plate": d.licensePlate},
        "eta": d.etaText,
        "tripLink": d.tripLink?.toString(),
      },
      "destination": destinationText,
      "contacts": contacts
          .map((c) => {"id": c.id, "name": c.displayName, "phone": c.phone, "email": c.email})
          .toList(),
    };
    await sender(payload);
  }

  /// Starts periodic live-location sharing (default every 5 minutes).
  /// Call [stopLiveLocation] when the user arrives or cancels.
  Future<void> startLiveLocation(String tripId, Duration cadence) async {
    _tripId = tripId;
    await _sendLocationOnce();
    _timer?.cancel();
    _timer = Timer.periodic(cadence, (_) => _sendLocationOnce());
  }

  /// Stops the periodic location sharing.
  Future<void> stopLiveLocation() async {
    _timer?.cancel();
    _timer = null;
    _tripId = null;
  }

  /// Sends one location “tick” to the backend (called on a timer).
  Future<void> _sendLocationOnce() async {
    if (_tripId == null) return;

    // Ensure permissions are granted in the UI before calling startLiveLocation.
    final perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied || perm == LocationPermission.deniedForever) return;

    final pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    final payload = {
      "type": "location_tick",
      "tripId": _tripId,
      "ts": DateTime.now().toIso8601String(),
      "lat": pos.latitude,
      "lng": pos.longitude,
      "contacts": contacts.map((c) => {"id": c.id}).toList(),
    };
    await sender(payload);
  }
}
 

Notes
• On Android, for reliable background updates, run a Foreground Service (we’ll add it when we do the native step).
• On iOS, use significant‑location changes background mode.
• Always ask for explicit consent before location sharing; allow Stop sharing anytime (good privacy practice).
