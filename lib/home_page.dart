 
import 'package:flutter/material.dart';
import 'search/search_delegate.dart';
import 'voice/voice_button.dart';
// Not strictly required for routing by name, but keeps file self-documented:
import 'donate/donate_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pocket Doctor'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search',
            onPressed: () => showSearch(context: context, delegate: DRSearchDelegate()),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Top description (accessible, high contrast-friendly)
          Card(
            elevation: 0,
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Pocket Doctor (DR) helps everyone — especially partially sighted and blind users — '
                'navigate safely with voice, download offline maps, and share ride details and live location with trusted contacts.',
                style: t.bodyMedium,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Introduction
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Introduction & How to use'),
            subtitle: const Text('Voice-first, offline, and safety tips'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).pushNamed('/intro'),
          ),

          const Divider(),

          // Voice nav placeholder (hook up later)
          ListTile(
            leading: const Icon(Icons.record_voice_over),
            title: const Text('Start navigation (voice)'),
            subtitle: const Text('Say “Navigate to…”'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: connect to your navigation flow
            },
          ),

          // DR downloads
          ListTile(
            leading: const Icon(Icons.download_for_offline),
            title: const Text('DR downloads (offline maps)'),
            subtitle: const Text('Download regions for offline use'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).pushNamed('/offline'),
          ),

          // Ride Safety
          ListTile(
            leading: const Icon(Icons.shield_moon_outlined),
            title: const Text('Ride Safety'),
            subtitle: const Text('Speak driver details & share live location'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).pushNamed('/safety'),
          ),

          const Divider(),

          // NEW: Donate tile
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Donate (R20/month)'),
            subtitle: const Text('Support Pocket Doctor via EFT'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).pushNamed('/donate'),
          ),

          const Divider(),

          // Help & About
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Help & About'),
            subtitle: const Text('Why this help exists • Contacts'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).pushNamed('/help'),
          ),
        ],
      ),
      floatingActionButton: const VoiceButton(),
    );
  }
}
 
