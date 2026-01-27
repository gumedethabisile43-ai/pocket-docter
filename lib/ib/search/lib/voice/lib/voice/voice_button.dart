import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'voice_controller.dart';

class VoiceButton extends StatelessWidget {
  const VoiceButton({super.key});
  @override
  Widget build(BuildContext context) {
    final voice = context.watch<VoiceController>();
    return FloatingActionButton.extended(
      label: Text(voice.listening ? 'Listening…' : 'Hold to speak'),
      icon: const Icon(Icons.mic),
      onPressed: () async {
        if (voice.listening) {
          await voice.stop();
        } else {
          await voice.startListening();
        }
      },
    );
  }
}
 
