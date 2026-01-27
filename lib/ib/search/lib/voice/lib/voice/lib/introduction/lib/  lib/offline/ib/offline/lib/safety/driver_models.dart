 
class DriverSummary {
  final String provider;      // e.g., "Bolt", "Uber"
  final String driverName;    // e.g., "Sipho"
  final String carColor;      // e.g., "White"
  final String carMake;       // e.g., "Toyota Corolla"
  final String licensePlate;  // e.g., "ND 123 456"
  final String etaText;       // e.g., "3 min"
  final Uri? tripLink;        // optional deeplink the provider gives

  const DriverSummary({
    required this.provider,
    required this.driverName,
    required this.carColor,
    required this.carMake,
    required this.licensePlate,
    required this.etaText,
    this.tripLink,
  });

  String spoken() =>
      "$provider driver $driverName in a $carColor $carMake, plate $licensePlate, arriving in $etaText.";
}

class EmergencyContact {
  final String id;            // your backend id for the contact
  final String displayName;   // "Next of kin"
  final String phone;         // phone number
  final String? email;        // optional email

  const EmergencyContact({
    required this.id,
    required this.displayName,
    required this.phone,
    this.email,
  });
}
 
