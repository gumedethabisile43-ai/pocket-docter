import 'package:flutter/material.dart';

class HelpAboutPage extends StatelessWidget {
  const HelpAboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Help & About')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Why we created this help', style: t.titleLarge),
          const SizedBox(height: 8),
          Text(
            'Pocket Doctor is built to put accessibility first. Many people who are partially sighted or blind '
            'need safe, simple tools to move around and get help — even without internet. '
            'This help explains the voice commands, offline downloads, and safety features in plain language, '
            'so everyone can use the app with confidence.',
            style: t.bodyMedium,
          ),

          const SizedBox(height: 16),
          Text('What the app can do', style: t.titleLarge),
          const SizedBox(height: 8),
          const _Bullet('Voice-first navigation with spoken guidance'),
          const _Bullet('Offline maps via DR downloads — works with no data'),
          const _Bullet('Ride Safety: speak & share driver details, live location every 5 minutes'),
          const _Bullet('High contrast, large text, screen reader friendly'),

          const SizedBox(height: 24),
          Text('Creator', style: t.titleLarge),
          const SizedBox(height: 8),
          const Text('Sphamandla Leon Cele (SphaSoul)\nCell: +27 63 570 0670\nEmail: Sphamandlaleon@gmail.com'),
        ],
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  final String text;
  const _Bullet(this.text);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.only(top: 6), child: Icon(Icons.star_rate, size: 18)),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
 
