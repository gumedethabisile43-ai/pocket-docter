import 'package:flutter/material.dart';
import 'driver_models.dart';
import 'safety_coordinator.dart';

class SafetyPage extends StatefulWidget {
  const SafetyPage({super.key});
  @override
  State<SafetyPage> createState() => _SafetyPageState();
}

class _SafetyPageState extends State<SafetyPage> {
  late SafetyCoordinator safety;
  bool sharing = false; // whether live location is currently sharing

  @override
  void initState() {
    super.initState();

    // Wire the sender to your backend (Supabase/Firebase) later.
    // For now, this stub just prints the payload.
    safety = SafetyCoordinator(
      sender: (payload) async {
        // TODO: replace with your HTTPS endpoint call (email/WhatsApp relay)
        // Example with http.post(...) when backend is ready.
        // This demo just logs the payload so the UI works now.
        // ignore: avoid_print
        print('SAFETY SEND: $payload');
      },
      contacts: const [
        EmergencyContact(
          id: 'kin1',
          displayName: 'Next of kin',
          phone: '+27...',
          email: null,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final demoDriver = DriverSummary(
      provider: 'Bolt',
      driverName: 'Sipho',
      carColor: 'White',
      carMake: 'Toyota Corolla',
      licensePlate: 'ND 123 456',
      etaText: '3 min',
      tripLink: Uri.tryParse('https://bolt.eu/app/...'),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Ride Safety')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Safety overview',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          const Text(
            '• Speaks the driver and vehicle details\n'
            '• With your consent, shares driver info and your live location every 5 minutes with your trusted contact until arrival\n'
            '• You can stop sharing at any time',
          ),
          const SizedBox(height: 24),

          // Speak driver details
          FilledButton.icon(
            icon: const Icon(Icons.volume_up),
            label: const Text('Speak driver details'),
            onPressed: () => safety.announceDriver(demoDriver),
          ),

          const SizedBox(height: 12),

          // Start/Stop live location + share driver details once
          FilledButton.icon(
            icon: Icon(sharing ? Icons.stop : Icons.shield),
            label: Text(sharing ? 'Stop live location' : 'Share driver + Start live location'),
            onPressed: () async {
              if (!sharing) {
                // Share driver details once (with destination for the message)
                await safety.shareDriverDetails('trip_001', demoDriver, 'Addington Hospital');
                // Start 5-minute ticks
                await safety.startLiveLocation('trip_001', const Duration(minutes: 5));
              } else {
                await safety.stopLiveLocation();
              }
              if (mounted) setState(() => sharing = !sharing);
            },
          ),
        ],
      ),
    );
  }
}
 
