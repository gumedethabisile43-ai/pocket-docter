import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DonatePage extends StatelessWidget {
  const DonatePage({super.key});

  final String accountHolder = "Sphamandla Leon Cele";
  final String bankName = "TymeBank";
  final String branchCode = "678910";
  final String accountNumber = "51021073559";
  final String reference = "PocketDoctor Donation";

  void copyToClipboard(BuildContext context, String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("$label copied")));
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text("Support Pocket Doctor")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            "Monthly Donation (R20)",
            style: t.titleLarge,
          ),
          const SizedBox(height: 10),
          Text(
            "Thank you for supporting Pocket Doctor (DR).\n"
            "Your monthly contribution of R20 helps keep the app free and accessible "
            "for partially sighted and blind users.",
            style: t.bodyMedium,
          ),

          const SizedBox(height: 30),
          Text("Banking Details", style: t.titleMedium),

          const SizedBox(height: 12),
          _infoTile("Account Holder", accountHolder),
          _copyButton(context, accountHolder, "Account Holder"),

          const SizedBox(height: 16),
          _infoTile("Bank Name", bankName),

          const SizedBox(height: 16),
          _infoTile("Branch Code", branchCode),
          _copyButton(context, branchCode, "Branch Code"),

          const SizedBox(height: 16),
          _infoTile("Account Number", accountNumber),
          _copyButton(context, accountNumber, "Account Number"),

          const SizedBox(height: 16),
          _infoTile("Reference", reference),
          _copyButton(context, reference, "Reference"),

          const SizedBox(height: 40),
          Text(
            "How to donate:",
            style: t.titleMedium,
          ),
          const SizedBox(height: 8),
          const Text(
            "1. Open your banking app.\n"
            "2. Choose ‘EFT Payment’.\n"
            "3. Enter the account details above.\n"
            "4. Enter the reference to help identify your donation.\n"
            "5. Set it as a recurring monthly payment (Optional).",
          ),

          const SizedBox(height: 40),
          const Text(
            "Thank you for your support! ❤️",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget _infoTile(String title, String value) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      subtitle: Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _copyButton(BuildContext context, String text, String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: FilledButton.tonal(
        onPressed: () => copyToClipboard(context, text, label),
        child: Text("Copy $label"),
      ),
    );
  }
}
 
