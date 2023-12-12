import 'package:google_maps_flutter/google_maps_flutter.dart';

/// The result returned after completing location selection.
class LocationResult {
  /// The human readable name of the location. This is primarily the
  /// name of the road. But in cases where the place was selected from Nearby
  /// places list, we use the <b>name</b> provided on the list item.
  String? address;

  /// Google Maps place ID
  String? placeId;

  /// Latitude/Longitude of the selected location.
  LatLng? latLng;

  String? subPremise;

  String? streetNumber;

  String? routeName;

  String? localityName;

  String? administrativeAreaLevel1;

  String? administrativeAreaLevel2;

  String? administrativeAreaLevel3;

  String? countryName;

  String? postalCode;

  LocationResult({
    this.latLng,
    this.address,
    this.placeId,
    this.subPremise,
    this.streetNumber,
    this.routeName,
    this.localityName,
    this.administrativeAreaLevel1,
    this.administrativeAreaLevel2,
    this.administrativeAreaLevel3,
    this.countryName,
    this.postalCode
  });

  @override
  String toString() {
    return 'LocationResult{address: $address, latLng: $latLng, placeId: $placeId, subPremise: $subPremise, streetNumber: $streetNumber, routeName: $routeName, localityName: $localityName, administrativeAreaLevel1: $administrativeAreaLevel1, administrativeAreaLevel2: $administrativeAreaLevel2, administrativeAreaLevel3: $administrativeAreaLevel3, countryName: $countryName, postalCode: $postalCode}';
  }
}
