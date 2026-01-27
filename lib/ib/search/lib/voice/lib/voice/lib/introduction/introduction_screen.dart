import 'package:flutter/material.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).colorScheme;
    final t = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Introduction & How to use')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Welcome to Pocket Doctor (DR)', style: t.headlineSmall),
          const SizedBox(height: 8),
          Text(
            'This app is designed to be friendly for partially sighted and blind users. '
            'Everything can be done with voice and large buttons, and works even when you’re offline.',
            style: t.bodyMedium,
          ),

          const SizedBox(height: 16),
          Text('Quick start', style: t.titleMedium?.copyWith(color: c.primary)),
          const SizedBox(height: 8),
          _bullet('Tap the microphone to start voice commands.'),
          _bullet('Try: “Navigate to Addington Hospital” or “Open D R downloads”.'),
          _bullet('Use TalkBack (Android) or VoiceOver (iOS); items have clear labels and focus order.'),

          const SizedBox(height: 16),
          Text('Offline maps (DR downloads)', style: t.titleMedium?.copyWith(color: c.primary)),
          const SizedBox(height: 8),
          _bullet('Search “DR” in the top search bar, or open “DR downloads (offline maps)”.'),
          _bullet('Choose your region and download. Navigation and guidance will work fully offline.'),

          const SizedBox(height: 16),
          Text('Ride Safety', style: t.titleMedium?.copyWith(color: c.primary)),
          const SizedBox(height: 8),
          _bullet('When booking a ride, the app will speak the driver’s name, car, colour and plate.'),
          _bullet('With your consent, it will share these details and your live location every 5 minutes with your emergency contact until you arrive.'),
          _bullet('You can stop sharing at any time from the safety panel.'),

          const SizedBox(height: 16),
          Text('Tips for partially sighted users', style: t.titleMedium?.copyWith(color: c.primary)),
          const SizedBox(height: 8),
          _bullet('Increase text size in system settings; the app respects large fonts.'),
          _bullet('Turn on high‑contrast mode or dark mode for comfortable viewing.'),
          _bullet('Use voice for hands‑free browsing of screens and menus.'),

          const SizedBox(height: 16),
          Text('Tips for blind users', style: t.titleMedium?.copyWith(color: c.primary)),
          const SizedBox(height: 8),
          _bullet('Turn on TalkBack (Android) or VoiceOver (iOS).'),
          _bullet('Explore items by touch; double‑tap anywhere to activate.'),
          _bullet('Use the voice button to dictate destinations and actions.'),

          const SizedBox(height: 24),
          FilledButton.icon(
            icon: const Icon(Icons.download),
            label: const Text('Open DR downloads'),
            onPressed: () => Navigator.of(context).pushNamed('/offline'),
          ),
        ],
      ),
    );
  }

  Widget _bullet(String text) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 6),
          child: Icon(Icons.check_circle, size: 18),
        ),
        const SizedBox(width: 10),
        Expanded(child: Text(text)),
      ],
    ),
  );
}
 
