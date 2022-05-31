import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocode/geocode.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_webservice/places.dart' hide Location ;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../requests/directions_model.dart';
import '../requests/google_maps_requests.dart';
import 'package:uuid/uuid.dart';

class AppState with ChangeNotifier{

  static const _apiKey = 'AIzaSyDuQbYTtgD64DsfsEnGhFc4-Vjfi4_7mfQ';
  static LatLng _initialPosition;
  LatLng _lastPosition = _initialPosition;
  final Set<Polyline> _polyLines = {};
  final Set<Marker> _markers = {};
  GoogleMapController _mapController;
  var uuid = Uuid();
  bool locationServiceActive = true;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  TextEditingController locationController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  final LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  GeoCode _geoCode = GeoCode();


  GeoCode get geoCode => _geoCode;
  Directions _info;
  Directions get info => _info; //GETTERS
  LatLng get initialPosition => _initialPosition;
  LatLng get lastPosition => _lastPosition;
  GoogleMapsServices get googleMapsServices => _googleMapsServices;
  GoogleMapController get mapController => _mapController;
  Set<Marker> get markers => _markers;
  Set<Polyline> get polyLines => _polyLines;
  String get apiKey => _apiKey;
  GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: _apiKey);


  String requestedDestination;
  double requestedDestinationLat;
  double requestedDestinationLng;

  AppState(){
    _getUserLocation();
    _loadingInitialPosition();
  }

//  get user Location of Device
  void _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition( desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    _initialPosition = LatLng(position.latitude, position.longitude);
    locationController.text = placemarks[0].street + " "+placemarks[0].locality;

    notifyListeners();
  }



  // ! ADD A MARKER ON THE MAO
  void _addMarker(LatLng location, String address) {
    _markers.clear();
    _markers.add(Marker(
        markerId: MarkerId(uuid.v4()),
        position: location,
        infoWindow: InfoWindow(title: address, snippet: "go here"),
        icon: BitmapDescriptor.defaultMarker));
     notifyListeners();
  }

// ! SEND REQUEST
  void sendRequest(String intendedLocation) async {
    List<Location> placemark = await locationFromAddress(intendedLocation,localeIdentifier: 'en');
    double latitude = placemark[0].latitude;
    double longitude = placemark[0].longitude;
    LatLng destination = LatLng(latitude, longitude);
    _addMarker(destination, intendedLocation);
    final directions = await GoogleMapsServices()
        .getDirections(origin: _initialPosition, destination: destination );
          _info = directions;
    mapController.animateCamera(
    _info != null
    ? CameraUpdate.newLatLngBounds(_info.bounds, 100.0)
        : CameraUpdate.newCameraPosition(CameraPosition(
      target: _initialPosition,
      zoom: 11.5,
    )),
    );
    }

  // ON CAMERA MOVE
  void onCameraMove(CameraPosition position) {
      _lastPosition = position.target;
      notifyListeners();
  }


  void onCreated(GoogleMapController controller) {
      _mapController = controller;
      notifyListeners();
  }

  //  LOADING INITIAL POSITION
  void _loadingInitialPosition()async{
    await Future.delayed(Duration(seconds: 5)).then((v) {
      if(_initialPosition == null){
        locationServiceActive = false;
        notifyListeners();
      }
    });

  }


}


