import 'dart:async';
import 'package:flutter/services.dart';

class LatLngBounds {
  final double north, south, east, west;
  const LatLngBounds({
    required this.north,
    required this.south,
    required this.east,
    required this.west,
  });
}

class OfflineRegion {
  final String id, name;
  final LatLngBounds bounds;
  final double minZoom, maxZoom;
  final bool includeNavigation;
  final List<String> styleUris;

  const OfflineRegion({
    required this.id,
    required this.name,
    required this.bounds,
    this.minZoom = 7,
    this.maxZoom = 16,
    this.includeNavigation = true,
    this.styleUris = const ["mapbox://styles/mapbox/streets-v12"],
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'minZoom': minZoom,
        'maxZoom': maxZoom,
        'bounds': {
          'north': bounds.north,
          'south': bounds.south,
          'east': bounds.east,
          'west': bounds.west,
        },
        'includeNavigation': includeNavigation,
        'styleUris': styleUris,
      };
}

enum OfflineTaskState {
  idle, preparing, downloading, verifying, complete, failed, deleting, canceled
}

class RegionStatus {
  final String id, name;
  final OfflineTaskState state;
  final int bytesDownloaded, bytesTotal;
  final double progress;
  final bool navTilesIncluded;
  final DateTime? lastUpdated;

  const RegionStatus({
    required this.id,
    required this.name,
    required this.state,
    required this.bytesDownloaded,
    required this.bytesTotal,
    required this.progress,
    required this.navTilesIncluded,
    this.lastUpdated,
  });
}

class OfflineRegionManager {
  static const MethodChannel _ch = MethodChannel('offline_manager');
  static const EventChannel _ev = EventChannel('offline_manager/events');

  final _progressCtrl = StreamController<RegionStatus>.broadcast();
  Stream<RegionStatus> get progressStream => _progressCtrl.stream;

  OfflineRegionManager() {
    _ev.receiveBroadcastStream().listen((e) {
      final m = Map<String, dynamic>.from(e);
      _progressCtrl.add(
        RegionStatus(
          id: m['id'] ?? '',
          name: m['name'] ?? '',
          state: OfflineTaskState.values[m['state'] ?? 0],
          bytesDownloaded: m['bytesDownloaded'] ?? 0,
          bytesTotal: m['bytesTotal'] ?? 0,
          progress: (m['progress'] ?? 0.0).toDouble(),
          navTilesIncluded: m['navTilesIncluded'] ?? true,
          lastUpdated: m['lastUpdated'] != null
              ? DateTime.tryParse(m['lastUpdated'])
              : null,
        ),
      );
    });
  }

  Future<void> enablePredictiveCaching({
    required List<String> styleUris,
    bool cacheSearch = false,
  }) =>
      _ch.invokeMethod('enablePredictiveCaching', {
        'styleUris': styleUris,
        'cacheSearch': cacheSearch,
      });

  Future<void> downloadRegion(OfflineRegion r) =>
      _ch.invokeMethod('downloadRegion', r.toMap());

  Future<void> deleteRegion(String id) =>
      _ch.invokeMethod('deleteRegion', {'id': id});

  Future<void> cancel(String id) =>
      _ch.invokeMethod('cancel', {'id': id});

  Future<void> setOfflinePriority(bool enabled) =>
      _ch.invokeMethod('setOfflinePriority', {'enabled': enabled});

  Future<List<RegionStatus>> listRegions() async {
    final res = await _ch.invokeMethod('listRegions');
    final list = (res as List).cast<Map>();
    return list
        .map((m) => RegionStatus(
              id: m['id'] ?? '',
              name: m['name'] ?? '',
              state: OfflineTaskState.values[m['state'] ?? 0],
              bytesDownloaded: m['bytesDownloaded'] ?? 0,
              bytesTotal: m['bytesTotal'] ?? 0,
              progress: (m['progress'] ?? 0.0).toDouble(),
              navTilesIncluded: m['navTilesIncluded'] ?? true,
              lastUpdated: m['lastUpdated'] != null
                  ? DateTime.tryParse(m['lastUpdated'])
                  : null,
            ))
        .toList();
  }

  void dispose() => _progressCtrl.close();
}
 
