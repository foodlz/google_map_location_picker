import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:google_map_location_picker/src/utils/log.dart';

class LocationProvider extends ChangeNotifier {
  static LocationProvider of(BuildContext context, {bool listen = true}) =>
      Provider.of<LocationProvider>(context, listen: listen);

  LatLng? _lastIdleLocation;

  LatLng? get lastIdleLocation => _lastIdleLocation;

  void setLastIdleLocation(LatLng? lastIdleLocation) {
    if (_lastIdleLocation != lastIdleLocation) {
      _lastIdleLocation = lastIdleLocation;
      d("setLastIdleLocation $_lastIdleLocation");
      notifyListeners();
    }
  }
}
