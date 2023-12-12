import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_location_picker/generated/l10n.dart';
import 'package:google_map_location_picker/src/providers/location_provider.dart';
import 'package:google_map_location_picker/src/utils/loading_builder.dart';
import 'package:google_map_location_picker/src/utils/log.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'model/location_result.dart';
import 'utils/location_utils.dart';
import 'package:permission_handler/permission_handler.dart';


class MapPicker extends StatefulWidget {
  const MapPicker(
    this.apiKey, {
    Key? key,
    this.initialCenter,
    this.initialZoom,
    this.requiredGPS,
    this.myLocationButtonEnabled,
    this.layersButtonEnabled,
    this.automaticallyAnimateToCurrentLocation,
    this.mapStylePath,
    this.appBarColor,
    this.searchBarBoxDecoration,
    this.hintText,
    this.resultCardConfirmIcon,
    this.resultCardAlignment,
    this.resultCardDecoration,
    this.resultCardPadding,
    this.language,
    this.desiredAccuracy,
  }) : super(key: key);

  final String apiKey;
  final LatLng? initialCenter;
  final double? initialZoom;
  final bool? requiredGPS;
  final bool? myLocationButtonEnabled;
  final bool? layersButtonEnabled;
  final bool? automaticallyAnimateToCurrentLocation;
  final String? mapStylePath;
  final Color? appBarColor;
  final BoxDecoration? searchBarBoxDecoration;
  final String? hintText;
  final Widget? resultCardConfirmIcon;
  final Alignment? resultCardAlignment;
  final Decoration? resultCardDecoration;
  final EdgeInsets? resultCardPadding;
  final String? language;
  final LocationAccuracy? desiredAccuracy;

  @override
  MapPickerState createState() => MapPickerState();
}

class MapPickerState extends State<MapPicker> {
  Map<String, String>? _headers;
  Completer<GoogleMapController> mapController = Completer();

  MapType _currentMapType = MapType.normal;
  String? _mapStyle;
  LatLng? _lastMapPosition;
  Position? _currentPosition;
  String? _address;
  String? _placeId;
  String? _aptNumber;
  String? _streetNumber;
  String? _routeName;
  String? _localityName;
  String? _administrativeAreaLevel1;
  String? _administrativeAreaLevel2;
  String? _administrativeAreaLevel3;
  String? _countryName;
  String? _postalCode;
  String? autoCompletePlaceId;
  Map<String, dynamic>? autoCompleteDetails;

  Future<void> getHeaders() async {
    final headers = await LocationUtils.getAppHeaders();
    setState(() => _headers = headers);
  }

  void _onToggleMapTypePressed() {
    final MapType nextType = MapType.values[(_currentMapType.index + 1) % MapType.values.length];
    setState(() => _currentMapType = nextType);
  }

  // This also checks for location permission.
  Future<void> _initCurrentLocation() async {

    if (!mounted) return;

    Position? currentPosition;

    try {
      currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: widget.desiredAccuracy!);
    } catch (e) {
      currentPosition = null;
      d("_initCurrentLocation#e = $e");
    }

    if (!mounted) return;

    setState(() => _currentPosition = currentPosition);

    if (currentPosition != null) {

      LatLng newLocation = LatLng(currentPosition.latitude, currentPosition.longitude);

      // Check if the new location is significantly different from the last known map position
      //     0.0001 degrees of latitude ≈ 11.1 meters
      //     0.0001 degrees of longitude ≈ 7.8 meters
      if (_lastMapPosition == null ||
          (newLocation.latitude - _lastMapPosition!.latitude).abs() > 0.00001 &&
              (newLocation.longitude - _lastMapPosition!.longitude).abs() > 0.00001) {
        await moveToCurrentLocation(newLocation);
      } else {
        d('The new location is not significantly different. Cancel moveToCurrentLocation');
      }

    }

  }

  Future moveToCurrentLocation(LatLng currentLocation, {String? placeId, placeDetails}) async {
    final controller = await mapController.future;
    if(placeId != null) {
      autoCompletePlaceId = placeId;
      autoCompleteDetails = placeDetails;
    } else {
      autoCompletePlaceId = null;
      autoCompleteDetails = null;
    }
    await controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: currentLocation, zoom: widget.initialZoom!),
    ));
  }

  @override
  void initState() {
    super.initState();
    getHeaders();

    if (widget.automaticallyAnimateToCurrentLocation! && !widget.requiredGPS!)
      _initCurrentLocation();

    if (widget.mapStylePath != null) {
      rootBundle.loadString(widget.mapStylePath!).then((string) {
        _mapStyle = string;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.requiredGPS!) {
      _checkGeolocationPermission();
      if (_currentPosition == null) _initCurrentLocation();
    }

    if (_currentPosition != null && dialogOpen != null)
      Navigator.of(context, rootNavigator: true).pop();

    return Scaffold(
      body: Builder(
        builder: (context) {
          if (_currentPosition == null &&
              widget.automaticallyAnimateToCurrentLocation! &&
              widget.requiredGPS!) {
            return const Center(child: CircularProgressIndicator());
          }
          return buildMap();
        },
      ),
    );
  }

  Widget buildMap() {
    return Center(
      child: Stack(
        children: <Widget>[
          GoogleMap(
            myLocationButtonEnabled: true,
            initialCameraPosition: CameraPosition(
              target: widget.initialCenter!,
              zoom: widget.initialZoom!,
            ),
            onMapCreated: (GoogleMapController controller) {
              mapController.complete(controller);
              //Implementation of mapStyle
              if (widget.mapStylePath != null) {
                controller.setMapStyle(_mapStyle);
              }
              _lastMapPosition = widget.initialCenter;
              if(!widget.automaticallyAnimateToCurrentLocation!) {
                LocationProvider.of(context, listen: false)
                    .setLastIdleLocation(_lastMapPosition);
              }
            },
            onCameraMove: (CameraPosition position) {
              _lastMapPosition = position.target;
            },
            onCameraIdle: () async {
              LocationProvider.of(context, listen: false)
                  .setLastIdleLocation(_lastMapPosition);
            },
            onCameraMoveStarted: () {
              //d("onCameraMoveStarted#_lastMapPosition = $_lastMapPosition");
            },
            //onTap: (latLng) {
            //  clearOverlay();
            //},
            mapType: _currentMapType,
            myLocationEnabled: true,
          ),
          _MapFabs(
            myLocationButtonEnabled: widget.myLocationButtonEnabled,
            layersButtonEnabled: widget.layersButtonEnabled,
            onToggleMapTypePressed: _onToggleMapTypePressed,
            onMyLocationPressed: _initCurrentLocation,
          ),
          pin(),
          locationCard(),
        ],
      ),
    );
  }

  Widget locationCard() {
    return Align(
      alignment: widget.resultCardAlignment ?? Alignment.bottomCenter,
      child: Padding(
        padding: widget.resultCardPadding ?? EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Consumer<LocationProvider>(
              builder: (context, locationProvider, _) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    flex: 20,
                    child: FutureLoadingBuilder<Map<String, String?>?>(
                      future: getAddress(locationProvider.lastIdleLocation),
                      mutable: true,
                      loadingIndicator: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircularProgressIndicator(),
                        ],
                      ),
                      builder: (context, data) {
                        if (data == null) {
                          return const SizedBox();
                        }
                        _address = data["address"];
                        _placeId = data["placeId"];
                        return Text(
                          _address ?? S.of(context).unnamedPlace,
                          style: TextStyle(fontSize: 18),
                        );
                      },
                    ),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.of(context).pop({
                        'location': LocationResult(
                          latLng: locationProvider.lastIdleLocation,
                          address: _address,
                          placeId: _placeId,
                          subPremise: _aptNumber,
                          streetNumber: _streetNumber,
                          routeName: _routeName,
                          localityName: _localityName,
                          administrativeAreaLevel1: _administrativeAreaLevel1,
                          administrativeAreaLevel2: _administrativeAreaLevel2,
                          administrativeAreaLevel3: _administrativeAreaLevel3,
                          countryName: _countryName,
                          postalCode: _postalCode
                        )
                      });
                    },
                    child: widget.resultCardConfirmIcon ??
                        Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Future<Map<String, String?>> getAddress(LatLng? location) async {

    try {

      final endpoint = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=${location?.latitude},${location?.longitude}'
          '&key=${widget.apiKey}&language=${widget.language}';

      if(location?.latitude == null || location?.longitude == null) {
        return {"placeId": null, "address": null, "streetNumber": null, "routeName": null, "localityName": null, "administrativeAreaLevel3": null, "administrativeAreaLevel2": null, "administrativeAreaLevel1": null, "countryName": null, "postalCode": null};
      }

      if(autoCompletePlaceId != null && autoCompleteDetails != null) {

        autoCompleteDetails!['address_components']?.forEach((addressComponents) {
          String type = addressComponents['types'][0].toString();
          switch (type) {
            case 'subpremise':
              _aptNumber = addressComponents['long_name'].toString();
              d("aptNumber: $_aptNumber");
              break;
            case 'street_number':
              _streetNumber = addressComponents['long_name'].toString();
              d("streetNumber: $_streetNumber");
              break;
            case 'route': // Street
              _routeName = addressComponents['long_name'].toString();
              d("routeName: $_routeName");
              break;
            case 'locality': // City
              _localityName = addressComponents['long_name'].toString();
              d("localityName: $_localityName");
              break;
            case 'administrative_area_level_3':
              _administrativeAreaLevel3 = addressComponents['long_name'].toString();
              d("administrativeAreaLevel3: $_administrativeAreaLevel3");
              break;
            case 'administrative_area_level_2':
              _administrativeAreaLevel2 = addressComponents['long_name'].toString();
              d("administrativeAreaLevel2: $_administrativeAreaLevel2");
              break;
            case 'administrative_area_level_1': // State
              _administrativeAreaLevel1 = addressComponents['long_name'].toString();
              d("administrativeAreaLevel1: $_administrativeAreaLevel1");
              break;
            case 'country':
              _countryName = addressComponents['long_name'].toString();
              d("countryName: $_countryName");
              break;
            case 'postal_code':
              _postalCode = addressComponents['long_name'].toString();
              d("postalCode: $_postalCode");
              break;
            default:
              break;
          }
        });


        String? placeId = autoCompletePlaceId;
        String? formattedAddress = autoCompleteDetails!['formatted_address'];
        Future.delayed(const Duration(seconds: 2), () {
          autoCompletePlaceId = null;
          autoCompleteDetails = null;
        });

        return {
          "placeId": placeId,
          "address": formattedAddress,
          "subPremise":  _aptNumber,
          "streetNumber": _streetNumber,
          "routeName": _routeName,
          "localityName": _localityName,
          "administrativeAreaLevel3": _administrativeAreaLevel3,
          "administrativeAreaLevel2": _administrativeAreaLevel2,
          "administrativeAreaLevel1": _administrativeAreaLevel1,
          "countryName": _countryName,
          "postalCode": _postalCode,
          "lat": location?.latitude.toString(),
          "lng": location?.longitude.toString()
        };

      }

      final response = await http.get(Uri.parse(endpoint),
          headers: _headers);

      if (response.statusCode == 200) {

        d(_headers.toString());

        Map<String, dynamic> responseJson = jsonDecode(response.body);
        d(responseJson);
        List<dynamic> results = responseJson['results'];
        List<dynamic>? addressComponents;
        Map<String, dynamic>? matchingResult;

        if (responseJson['status'] == 'REQUEST_DENIED') {
          d(responseJson['error_message']);
          return {"placeId": null, "address": null, "streetNumber": null, "routeName": null, "localityName": null, "administrativeAreaLevel3": null, "administrativeAreaLevel2": null, "administrativeAreaLevel1": null, "countryName": null, "postalCode": null};
        }

        d("auto Complete PlaceId $autoCompletePlaceId");

        if(autoCompletePlaceId != null) {
          for (var result in results) {
            if (result['place_id'] == autoCompletePlaceId) {
              matchingResult = result;
              break;
            }
          }
        }

        if (matchingResult != null) {
          d('Matching result: $matchingResult');
          addressComponents = matchingResult['address_components'];
          d('addressComponents: $addressComponents');
        } else {
          matchingResult = results[0];
          addressComponents = matchingResult!['address_components'];
          d('addressComponents: $addressComponents');
        }

        autoCompletePlaceId = null;

        addressComponents?.forEach((addressComponents) {
          String type = addressComponents['types'][0].toString();
          switch (type) {
            case 'subpremise':
              _aptNumber = addressComponents['long_name'].toString();
              d("aptNumber: $_aptNumber");
              break;
            case 'street_number':
              _streetNumber = addressComponents['long_name'].toString();
              d("streetNumber: $_streetNumber");
              break;
            case 'route': // Street
              _routeName = addressComponents['long_name'].toString();
              d("routeName: $_routeName");
              break;
            case 'locality': // City
              _localityName = addressComponents['long_name'].toString();
              d("localityName: $_localityName");
              break;
            case 'administrative_area_level_3':
              _administrativeAreaLevel3 = addressComponents['long_name'].toString();
              d("administrativeAreaLevel3: $_administrativeAreaLevel3");
              break;
            case 'administrative_area_level_2':
              _administrativeAreaLevel2 = addressComponents['long_name'].toString();
              d("administrativeAreaLevel2: $_administrativeAreaLevel2");
              break;
            case 'administrative_area_level_1': // State
              _administrativeAreaLevel1 = addressComponents['long_name'].toString();
              d("administrativeAreaLevel1: $_administrativeAreaLevel1");
              break;
            case 'country':
              _countryName = addressComponents['long_name'].toString();
              d("countryName: $_countryName");
              break;
            case 'postal_code':
              _postalCode = addressComponents['long_name'].toString();
              d("postalCode: $_postalCode");
              break;
            default:
              break;
          }
        });

        return {
          "placeId": matchingResult['place_id'],
          "address": matchingResult['formatted_address'],
          "subPremise": _aptNumber,
          "streetNumber": _streetNumber,
          "routeName": _routeName,
          "localityName": _localityName,
          "administrativeAreaLevel3": _administrativeAreaLevel3,
          "administrativeAreaLevel2": _administrativeAreaLevel2,
          "administrativeAreaLevel1": _administrativeAreaLevel1,
          "countryName": _countryName,
          "postalCode": _postalCode,
          "lat": matchingResult['geometry']['location']['lat'].toString(),
          "lng": matchingResult['geometry']['location']['lng'].toString()
        };

      } else {
        // Handle non-200 status code
        d('Error: ${response.statusCode}');
      }

    } catch (e) {
      autoCompletePlaceId = null;
      print(e);
    }

    autoCompletePlaceId = null;

    return {"placeId": null, "address": null, "streetNumber": null, "routeName": null, "localityName": null, "administrativeAreaLevel3": null, "administrativeAreaLevel2": null, "administrativeAreaLevel1": null, "countryName": null, "postalCode": null};
  }

  Widget pin() {
    return IgnorePointer(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.place, size: 56),
            Container(
              decoration: ShapeDecoration(
                shadows: [
                  BoxShadow(
                    blurRadius: 4,
                    color: Colors.black38,
                  ),
                ],
                shape: CircleBorder(
                  side: BorderSide(
                    width: 4,
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
            SizedBox(height: 56),
          ],
        ),
      ),
    );
  }

  var dialogOpen;

  Future _checkGeolocationPermission() async {

    await Permission.locationWhenInUse
        .onDeniedCallback(() {
      // We haven't asked for permission yet or the permission has been denied before, but not permanently.
      _showDeniedDialog();
    })
        .onGrantedCallback(() {
      d("onGrantedCallback");
    })
        .onPermanentlyDeniedCallback(() {
      // The user opted to never again see the permission request dialog for this
      // app. The only way to change the permission's status now is to let the
      // user manually enables it in the system settings.
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S
                .of(context)
                .location_permanently_denied_callback_msg),
            duration: Duration(seconds: 30),
            action: SnackBarAction(
              label: S.of(context).mobile_settings,
              onPressed: () {
                openAppSettings();
              },
            ),
          )
      );
      _showDeniedForeverDialog();
    })
        .onRestrictedCallback(() {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S
                .of(context)
                .location_restricted_callback_msg),
            duration: Duration(seconds: 30),
            action: SnackBarAction(
              label: S.of(context).mobile_settings,
              onPressed: () {
                openAppSettings();
              },
            ),
          )
      );
    })
        .onLimitedCallback(() {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S
                .of(context)
                .location_limited_callback_msg),
            duration: Duration(seconds: 30),
            action: SnackBarAction(
              label: S.of(context).mobile_settings,
              onPressed: () {
                openAppSettings();
              },
            ),
          )
      );
    })
    .request();

    /*final geolocationStatus = await Geolocator.checkPermission();
    d("geolocationStatus = $geolocationStatus");

    if (geolocationStatus == LocationPermission.denied && dialogOpen == null) {
      dialogOpen = _showDeniedDialog();
    } else if (geolocationStatus == LocationPermission.deniedForever &&
        dialogOpen == null) {
      dialogOpen = _showDeniedForeverDialog();
    } else if (geolocationStatus == LocationPermission.whileInUse ||
        geolocationStatus == LocationPermission.always) {
      d('GeolocationStatus.granted');

      if (dialogOpen != null) {
        Navigator.of(context, rootNavigator: true).pop();
        dialogOpen = null;
      }
    }*/
  }

  Future _showDeniedDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            Navigator.of(context, rootNavigator: true).pop();
            Navigator.of(context, rootNavigator: true).pop();
            return true;
          },
          child: AlertDialog(
            title: Text(S.of(context).access_to_location_denied),
            content: Text(S.of(context).allow_access_to_the_location_services),
            actions: <Widget>[
              TextButton(
                child: Text(S.of(context).ok),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  _initCurrentLocation();
                  dialogOpen = null;
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future _showDeniedForeverDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            Navigator.of(context, rootNavigator: true).pop();
            Navigator.of(context, rootNavigator: true).pop();
            return true;
          },
          child: AlertDialog(
            title: Text(S.of(context).access_to_location_permanently_denied),
            content: Text(S
                .of(context)
                .allow_access_to_the_location_services_from_settings),
            actions: <Widget>[
              TextButton(
                child: Text(S.of(context).ok),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  Geolocator.openAppSettings();
                  dialogOpen = null;
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MapFabs extends StatelessWidget {
  const _MapFabs({
    Key? key,
    required this.myLocationButtonEnabled,
    required this.layersButtonEnabled,
    required this.onToggleMapTypePressed,
    required this.onMyLocationPressed,
  }) : super(key: key);

  final bool? myLocationButtonEnabled;
  final bool? layersButtonEnabled;

  final VoidCallback onToggleMapTypePressed;
  final VoidCallback onMyLocationPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      margin: const EdgeInsets.only(top: kToolbarHeight + 24, right: 8),
      child: Column(
        children: <Widget>[
          if (layersButtonEnabled!)
            FloatingActionButton(
              onPressed: onToggleMapTypePressed,
              materialTapTargetSize: MaterialTapTargetSize.padded,
              mini: true,
              child: const Icon(Icons.layers),
              heroTag: "layers",
            ),
          if (myLocationButtonEnabled!)
            FloatingActionButton(
              onPressed: onMyLocationPressed,
              materialTapTargetSize: MaterialTapTargetSize.padded,
              mini: true,
              child: const Icon(Icons.my_location),
              heroTag: "myLocation",
            ),
        ],
      ),
    );
  }
}
