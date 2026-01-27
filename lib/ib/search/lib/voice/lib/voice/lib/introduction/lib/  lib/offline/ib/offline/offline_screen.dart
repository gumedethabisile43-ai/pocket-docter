import 'package:flutter/material.dart';
import 'offline_region_manager.dart';

class OfflineScreen extends StatefulWidget {
  const OfflineScreen({super.key});
  @override
  State<OfflineScreen> createState() => _OfflineScreenState();
}

class _OfflineScreenState extends State<OfflineScreen> {
  bool offlineFirst = false;
  bool downloading = false;
  final _mgr = OfflineRegionManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DR downloads')),
      body: Column(
        children: [
          SwitchListTile.adaptive(
            title: const Text('Offline‑first routing'),
            subtitle: const Text('Prefer onboard routing when network is spotty'),
            value: offlineFirst,
            onChanged: (v) async {
              setState(() => offlineFirst = v);
              await _mgr.setOfflinePriority(v);
            },
          ),
          const Divider(height: 1),
          Expanded(
            child: FutureBuilder<List<RegionStatus>>(
              future: _mgr.listRegions(),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final regions = snap.data ?? [];
                if (regions.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'No offline regions yet.\nTap “Add region” to download a map for offline use.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async => setState(() {}),
                  child: ListView.separated(
                    itemCount: regions.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, i) {
                      final r = regions[i];
                      final mb = (r.bytesDownloaded / (1024 * 1024)).toStringAsFixed(1);
                      final pct = (r.progress * 100).toStringAsFixed(0);
                      return ListTile(
                        title: Text(r.name),
                        subtitle: Text('$pct% • $mb MB'),
                        trailing: IconButton(
                          tooltip: 'Delete region',
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () async {
                            await _mgr.deleteRegion(r.id);
                            if (mounted) setState(() {});
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: downloading
            ? null
            : () async {
                setState(() => downloading = true);

                // Example: Durban Metro region
                final region = OfflineRegion(
                  id: 'durban',
                  name: 'Durban Metro',
                  bounds: const LatLngBounds(
                    north: -29.5,
                    south: -30.2,
                    east: 31.2,
                    west: 30.7,
                  ),
                  minZoom: 8,
                  maxZoom: 16,
                  includeNavigation: true,
                  styleUris: const ["mapbox://styles/mapbox/streets-v12"],
                );

                try {
                  await _mgr.downloadRegion(region);
                } finally {
                  if (mounted) {
                    setState(() => downloading = false);
                  }
                }
              },
        icon: const Icon(Icons.download),
        label: Text(downloading ? 'Downloading…' : 'Add region'),
      ),
    );
  }
}
 
