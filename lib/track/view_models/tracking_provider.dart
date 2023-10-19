import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../core/utils/secrets.dart';

class TrackProvider with ChangeNotifier {
  bool _fetchingLocation = false;

  LocationData? _currentLocation;
  final Location _locationController = new Location();
  final LatLng _destination = const LatLng(19.9794, 73.7947);

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  Set<Polyline> _polyLines = {};

  BitmapDescriptor _currentLocationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor _destinationIcon = BitmapDescriptor.defaultMarker;

  final Completer<void> _locationCompleter = Completer<void>();

  LocationData? get currentLocation => _currentLocation;

  Location get locationController => _locationController;

  LatLng get destination => _destination;

  Completer<GoogleMapController> get mapController => _mapController;

  Set<Polyline> get polyline => _polyLines;

  BitmapDescriptor get currentLocationIcon => _currentLocationIcon;

  BitmapDescriptor get destinationIcon => _destinationIcon;

  bool get fetchingLocation => _fetchingLocation;

  setPolyLine(Polyline polyline) {
    _polyLines.add(polyline);
    notifyListeners();
  }

  setCurrentLocation(LocationData currentLocation) {
    _currentLocation = currentLocation;
    notifyListeners();
  }

  setCurrentLocationMarker(BitmapDescriptor currentBitmapDescriptor) {
    _currentLocationIcon = currentBitmapDescriptor;
    notifyListeners();
  }

  setDestionationMarker(BitmapDescriptor destinationBitmapDescriptor) {
    _destinationIcon = destinationBitmapDescriptor;
    notifyListeners();
  }

  setFetchingLocation(bool value) {
    _fetchingLocation = value;
    notifyListeners();
  }

  // Constructor
  TrackProvider(){
    initializeLocation();
  }

  // Initialize the data
  void initializeLocation() async {
    await getLocationUpdates();
    setCustomMarkerIcon();
    _locationCompleter.future.then((_) {
      print("Current Location: $_currentLocation");
      getPolyPoints(
        LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!), 
        destination).then((coordinates){
          print("Rececived Co-ordinates : $coordinates");
          generatePolylineFromPoints(coordinates!);
        });
    });
  }

  //  Get all the points between curren position and destionaton
  Future<List<LatLng>?> getPolyPoints(
      LatLng currentLocation, LatLng destination) async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();

    if (_currentLocation == null) {
      return null;
    }

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      google_api_key,
      PointLatLng(currentLocation.latitude, currentLocation.longitude),
      PointLatLng(
        destination.latitude,
        destination.longitude,
      ),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) =>
          polylineCoordinates.add(LatLng(point.latitude, point.longitude)));
    }

    return polylineCoordinates;
  }

  // whenever the location changes update the camera postition
  Future<void> cameraPosition(LocationData position) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition newCameraPosition = CameraPosition(
        target: LatLng(position.latitude!, position.longitude!), zoom: 13);

    await controller
        .animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }

  
  // Generate Poly Line on Map
  void generatePolylineFromPoints(List<LatLng> polylineCoordinates) async {
    PolylineId id = PolylineId("routes");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.blue,
        points: polylineCoordinates,
        width: 8);

    setPolyLine(polyline);
  }

  // Load asset icons for marker
  void setCustomMarkerIcon() {
    print("Yeh Chala ki nahi lode ");
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/icons/car.png")
        .then((icon) {
      setCurrentLocationMarker(icon);
    });

    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/icons/destination.png")
        .then((icon) {
      setDestionationMarker(icon);
    });
  }


  // Fetch current location of user
  Future<void> getLocationUpdates() async {
    print("BC idhar aa bhi nahi raha hai 1");
    setFetchingLocation(true);
    bool serviceEnabeled;
    PermissionStatus permissonGranted;

    serviceEnabeled = await _locationController.serviceEnabled();

    if (serviceEnabeled) {
      serviceEnabeled = await _locationController.requestService();
    } else {
      return;
    }

    permissonGranted = await _locationController.hasPermission();

    if (permissonGranted == PermissionStatus.denied) {
      permissonGranted = await _locationController.requestPermission();
      if (permissonGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        print("Current Location data : $currentLocation");
        setCurrentLocation(currentLocation);
        cameraPosition(currentLocation);
        // Notify the Completer that location has been updated
        _locationCompleter.complete();
      }

      print("Current Location:$currentLocation");
    });

    setFetchingLocation(false);
  }
}
