import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocode/geocode.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_webservice/places.dart' hide Location ;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cabgo/requests/directions_model.dart';
import 'package:cabgo/requests/google_maps_requests.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cabgo/requests/login.dart';
import 'package:cabgo/requests/trip_request.dart';

import '../requests/push_notifications.dart';

class AppState with ChangeNotifier{


  static LatLng _initialPosition;
  LatLng destination;
  LatLng _lastPosition = _initialPosition;
  final Set<Polyline> _polyLines = {};
  final Set<Marker> _markers = {};
  String _accessToken;
  String _refreshToken;
  GoogleMapController _mapController;
  var uuid = Uuid();
  bool locationServiceActive = true;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  TextEditingController locationController = TextEditingController();
  TextEditingController destinationController = TextEditingController();

  //LOGIN CONTOLLER
 TextEditingController emailAddressController = TextEditingController();
 TextEditingController passwordController = TextEditingController();

 //REGISTER CONTROLLER

  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerFirstNameController = TextEditingController();
  TextEditingController registerLastNameController = TextEditingController();
  TextEditingController registerPhoneController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController registerConfirmPasswordController = TextEditingController();

 //local storage
  final _storage = const FlutterSecureStorage();
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );



  final LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  GeoCode _geoCode = GeoCode();
  bool incomeMessage = false;
  bool _isOnline = false;
  bool get isOnline => _isOnline;
  GeoCode get geoCode => _geoCode;
  bool _isLoggedIn = false;

  FirebaseMessaging _messaging;
  PushNotifications notifications;

  Directions _info;
  Directions get info => _info; //GETTERS
  LatLng get initialPosition => _initialPosition;
  LatLng get lastPosition => _lastPosition;
  GoogleMapsServices get googleMapsServices => _googleMapsServices;
  GoogleMapController get mapController => _mapController;
  Set<Marker> get markers => _markers;
  Set<Polyline> get polyLines => _polyLines;
  String get accessToken => _accessToken;
  String get refreshToken => _refreshToken;
  bool get isLoggedIn => _isLoggedIn;
  GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: dotenv.get('API_KEY'));


  String requestedDestination;
  double requestedDestinationLat;
  double requestedDestinationLng;

  //dragable bottom sheet
  double dragableHeight = 0.2;
  bool topContainerVisibility = false;
  bool bottomContainerVisibility = true;

  bool dragrableOneVisibilty = false;
  bool dragableTwoVibility = true;

  // chat height
  double chatHeight = 1.5;


  //Errors
  String loginError;
  bool isLoading = false;



  // //on background handler
  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();
    print("Handling a background message: ${message.messageId}");
  }

  AppState(){
    _getUserLocation();
    _loadingInitialPosition();
    _getTokens();
    _registerNotification();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }


  //    register notification
  void _registerNotification() async {
    await Firebase.initializeApp();

    _messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permision ');
      final fcmToken = await FirebaseMessaging.instance.getToken();
      print('Your token : $fcmToken');

    }

    //on foregroud
    FirebaseMessaging.onMessage.listen((RemoteMessage message)  {
      notifications =   PushNotifications(message.data['message'], message.data['requestID']);
      incomeMessage = true;
      notifyListeners();

    });

  //  on background

  }

//  get user Location of Device
  void _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition( desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    _initialPosition = LatLng(position.latitude, position.longitude);
    locationController.text = placemarks[0].street + " "+placemarks[0].locality;
    notifyListeners();
  }

  //get user token
  void _getTokens() async{
     _accessToken =  await readSecureData('access_token');
     _refreshToken =  await readSecureData('refresh_token');
  }


  //check user is logged in
  bool isUserLogged() {
    _isLoggedIn = (accessToken != null) ? true : false;
   return _isLoggedIn;
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
    destination = LatLng(latitude, longitude);
    _addMarker(destination, intendedLocation);
    final directions = await GoogleMapsServices()
        .getDirections(origin: _initialPosition, destination: destination,);
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

  //user Auth
  // ! SEND REQUEST
  Future<void> passangerLogin() async {
    try{
    final response = await ApiClient().login(emailAddressController.text,passwordController.text );
   if(response['access_token'] != null) {
     _addNewItem('access_token', response['access_token']);
     _addNewItem('refresh_token', response['refresh_token']);
      _isLoggedIn = true;
      notifyListeners();
    }else{
     throw InvalidCredentials();
   }

    } on InvalidCredentials{

      loginError = 'Invalid login details';
    }


    }

  // ! SEND REQUEST

  void passangerRegister({@required String email, @required String firstName, @required String lastName, @required String phone, @required String password, }) async {

    final response = await ApiClient().registerUser(registerEmailController.value.text,
                                                    registerFirstNameController.value.text,
                                                    registerLastNameController.value.text,
                                                    registerPhoneController.value.text,
                                                    registerPhoneController.value.text,
                                                      );

  }


  // ! SEND REQUEST
  Future<void> passangerLogout() async {
    await _storage.delete(key: 'access_token', aOptions: _getAndroidOptions());
    await _storage.delete(key: 'refresh_token', aOptions: _getAndroidOptions());
    _isLoggedIn = false;
    notifyListeners();
  }

  Future<String> readSecureData(String key) async {
    var readData =
    await _storage.read(key: key, aOptions: _getAndroidOptions());
    return readData;
  }


  void _addNewItem(String key, String value) async {
      await _storage.write(
        key: key,
        value: value,
        aOptions: _getAndroidOptions(),
    );
  }

  //get services

  Future<dynamic> getServices() async {

    dynamic data = await TripRequest().getServices();
    print('test');
    print(data);
    return data;

  }
  Future<dynamic> getUserDetails() async {

    dynamic data = await ApiClient().getServices(_accessToken);
    print('test');
    print(data);
    return data;

  }

  //get services

  Future<dynamic> sendTripRequest(int type, double distance) async {

    dynamic data = await TripRequest().sendRequest(_initialPosition, destination , type, distance, );

    return data;

  }

  void changeHeight(double height){
      chatHeight = height;
      notifyListeners();
  }



}


