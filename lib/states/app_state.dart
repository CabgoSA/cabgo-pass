import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocode/geocode.dart';
import 'package:google_maps_webservice/places.dart' hide Location ;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cabgo/requests/directions_model.dart';
import 'package:cabgo/requests/google_maps_requests.dart';
import 'package:google_place/google_place.dart'  hide Location;
import 'package:uuid/uuid.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cabgo/requests/login.dart';
import 'package:cabgo/requests/trip_request.dart';
import 'package:cabgo/requests/device_info.dart';
import '../exceptions/exceptions.dart';
import '../requests/providerDetails.dart';
import '../requests/push_notifications.dart';
import '../requests/user.dart';

class AppState with ChangeNotifier{

  static LatLng _initialPosition;
  LatLng destination;
  LatLng _lastPosition = _initialPosition;
  LatLng placeA;
  LatLng placeB;
  final Set<Polyline> _polyLines = {};
  Set<Marker> _markers = {};
  String _accessToken;
  String _refreshToken;
  GoogleMapController _mapController;
  var uuid = Uuid();
  bool locationServiceActive = true;

  GoogleMapsServices _googleMapsServices = GoogleMapsServices();

  TextEditingController startController = TextEditingController();
  TextEditingController destinationController = TextEditingController();

  DetailsResult startPosition;
  DetailsResult endPosition;

   FocusNode startFocusNode;
   FocusNode endFocusNode;

  GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];


  //LOGIN CONTOLLER
 TextEditingController emailController = TextEditingController();
 TextEditingController passwordController = TextEditingController();

 //REGISTER CONTROLLER

  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerFirstNameController = TextEditingController();
  TextEditingController registerLastNameController = TextEditingController();
  TextEditingController registerPhoneController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController registerConfirmPasswordController = TextEditingController();

  //verify
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  TextEditingController textController3 = TextEditingController();
  TextEditingController textController4 = TextEditingController();
  // TextEditingController textController5 = TextEditingController();

  //user phone
  String userRegisterPhone;

  User user;
  var currentColor = Colors.white;

  //reset password
  TextEditingController resetPhoneNumber = TextEditingController();

  //new password
  TextEditingController newPassword = TextEditingController();
  TextEditingController newPasswordConfirm = TextEditingController();

 //local storage
  final _storage = const FlutterSecureStorage();
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );

  //  device information
   String _fcmToken;
  String _deviceType;
  String _deviceID;



  final LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );
  ProviderDetails providerDetails;
  GeoCode _geoCode = GeoCode();
  bool incomeMessage = false;
  String rideNotification;
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

  bool dragrableOneVisibilty = true;
  bool dragableTwoVibility = false;


  double rating = 3.0;

  // chat height
  double chatHeight = 1.5;

  int _selectedService;

  dynamic services;

  dynamic promocodes;


  int get selectedService => _selectedService;

  String estimateImage;
  String estimatePrice;
  //Errors
  String loginError;
  bool isLoading = false;



  AppState(){
    _getUserLocation();
    _loadingInitialPosition();
    _getTokens();
    _registerNotification();
    _getDeviceData();
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    googlePlace = GooglePlace(dotenv.get('API_KEY'));
    startFocusNode = FocusNode();
    endFocusNode = FocusNode();
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
      _fcmToken = await FirebaseMessaging.instance.getToken();
      
    }

    //on foregroud
    FirebaseMessaging.onMessage.listen((RemoteMessage message)  async {
       print("test ------- incoming message");
      if (message.data['message'] == 'Ride accepted Request') {
        //print('incoming text');
        Response data = await ApiClient().fetchRideDetails(
            message.data['requestID'], _accessToken);
        Map<String, dynamic> rideData = jsonDecode(data.toString());

        if (rideData != null) {
          //create notification
           notifications = PushNotifications(
           message.data['message'], message.data['requestID']);
            providerDetails = ProviderDetails(
            providerID: rideData['provider']['id'], 
            fullName: rideData['provider']['first_name'] + ' ' +
                rideData['provider']['last_name'],
            picture: (rideData['provider']['avatar'] == null) ? null : dotenv
                .get('BASE_URL') + rideData['provider']['avatar'],
            phone: rideData['provider']['mobile'],
            rating: rideData['provider']['rating'],
            price: (double.parse(rideData['service_type']['price']) *
                double.parse(rideData['distance'])).toString(),
            serviceImage: rideData['service_type']['image'],
            serviceName: rideData['service_type']['name'],
          );

          incomeMessage = true;
        }
      }
      if (message.data['message'] == 'Ride Started') {
        updateNotification();
        rideNotification = 'Ride Started';
        dragrableOneVisibilty = false;
        dragableTwoVibility = false;
      }
      if (message.data['message'] == 'Ride Completed') {
        updateNotification();
        rideNotification = 'Ride Completed';
        providerDetails = null;
      }

      notifyListeners();
    });

  //  on background

  }

  Future<void> delete() async {
      await ApiClient().delete(_accessToken);
      _isLoggedIn = false;
      notifyListeners();
  }


  void updateNotification(){
    dragrableOneVisibilty = true;
    dragableTwoVibility = false;
    notifyListeners();
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null ) {
      print(result.predictions.first.description);
        predictions = result.predictions;
        notifyListeners();
    }
  }

 void setService(int serviceID){
    _selectedService = serviceID;
    currentColor = Colors.blue;
    estimateImage = services[_selectedService-1]['image'];
    estimatePrice = (double.parse(services[_selectedService-1]['price']) * double.parse(_info.totalDistance.substring(0,_info.totalDistance.length - 3))).toString();
  }

  Future<void> _getUserLocation() async {
    //start
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    try {
      if (!serviceEnabled) {
        throw LocationServiceDisabled();
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw LocationServiceDenied();
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        throw LocationDeniedForever();
      }
      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      Geolocator.getPositionStream(locationSettings: locationSettings).listen(
              (Position position) {
            _initialPosition = LatLng(position.latitude, position.longitude);

          });




    //  end
    }catch(e){
      throw GeneralError();
    }

    notifyListeners();
  }

  //get user token
  void _getTokens() async{
     _accessToken =  await readSecureData('access_token');
     _refreshToken =  await readSecureData('refresh_token');
  }

  //device info
  void _getDeviceData() async{

    try {
      await DeviceInfo.getDeviceDetails().then((value) {
        _deviceID = value[0];
        _deviceType = value[1];
      });

    }catch(e){
      throw DeviceInfoError();
    }

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
  Future<void> sendRequest() async {

    if(startPosition != null){
      placeA = LatLng(startPosition.geometry.location.lat, startPosition.geometry.location.lng);
    }else{
      placeA = LatLng(_initialPosition.latitude, _initialPosition.longitude);
    }

    placeB = LatLng(endPosition.geometry.location.lat, endPosition.geometry.location.lng);

    _addMarker(LatLng(placeA.latitude,placeA.latitude), 'Start position' );
    _addMarker(LatLng(endPosition.geometry.location.lat,endPosition.geometry.location.lng), endPosition.adrAddress );

    final directions = await GoogleMapsServices()
        .getDirections(origin: placeA, destination: placeB);
          _info = directions;
    mapController.animateCamera(
    _info != null
    ? CameraUpdate.newLatLngBounds(_info.bounds, 100.0)
        : CameraUpdate.newCameraPosition(CameraPosition(
      target: placeA,
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

    final response = await ApiClient().login(emailController.text,passwordController.text,_fcmToken, _deviceID,);

           _accessToken = response['access_token'];
           if(_accessToken != null){
           await getUserDetails();
           dynamic data =  await ApiClient().getUser(_accessToken);
           user = User(fullName: data['first_name']+ ' '+data['last_name'],
                       phone: data['mobile'], email: data['email'],
                       picture: data['picture'], rating: data['rating']);
            _isLoggedIn = true;
           await ApiClient().setFcmToken(_accessToken, _fcmToken);
           promocodes = await TripRequest().getPromocode(_accessToken);
           notifyListeners();
           } else{
              _isLoggedIn = false;
              notifyListeners();
            return  "Invalid_login_details";
           }   
           
    } on InvalidCredentials{
      _isLoggedIn = false;
      notifyListeners();
      return 'Invalid_login_details';
    }



    }


  // ! SEND REQUEST

  Future<void> register() async {

    try {
      dynamic response = await ApiClient().registerUser(email: registerEmailController.value.text,
        firstName: registerFirstNameController.value.text,
        lastName: registerLastNameController.value.text,
        phone: registerPhoneController.value.text,
        password: registerPasswordController.value.text,
        passwordConfirmation: registerConfirmPasswordController.value.text,
        deviceToken: _fcmToken,
        deviceId: _deviceID,
        deviceType: _deviceType,
      );

      //create User
      userRegisterPhone = response['mobile'];
      notifyListeners();
    }catch(e){
      print(e);
      throw UserRegistrationError();
    }

  }

  Future<void> verifyOtp() async {
    try {
      String otpCode = textController1.text;
             otpCode += textController2.text;
            otpCode += textController3.text;
            otpCode += textController4.text;

      dynamic response = await ApiClient().verifyOtp(
        userRegisterPhone,
        otpCode,
      );

    }catch(e){
      throw OtpVerificationError();
    }


  }

  Future<void> requestResetOtp() async {
    try {
       await ApiClient().requestResetOtp(resetPhoneNumber.text);

    } on ResetPasswordError catch(e){
      throw ResetPasswordError();
    }
  }

  Future<dynamic> passwordReset() async {

    dynamic data =  await ApiClient().passwordReset(resetPhoneNumber.text, newPassword.text, newPasswordConfirm.text);
    return data;
  }


  // ! SEND REQUEST
  Future<void> passangerLogout() async {
    try {
      await _storage.delete(
          key: 'access_token', aOptions: _getAndroidOptions());
      await ApiClient().logout(_accessToken);

      _isLoggedIn = false;
      incomeMessage = true;

      topContainerVisibility = false;
      bottomContainerVisibility = true;
      dragrableOneVisibilty = true;
      dragableTwoVibility = false;

      notifyListeners();
    }catch(e){
      print(e);
    }
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

  Future<void> getServices() async {
      try {
        services  = await TripRequest().getServices(_accessToken);
      }catch(e){
       throw ErrorGettingServices();
      }
  }


  Future<dynamic> getUserDetails() async {
  try {
    dynamic data = await ApiClient().getUser(_accessToken);

    return data;
  } on ErrorGettingUser {
    throw ErrorGettingUser();
    } catch(e){
    throw GeneralError();
  }
  }

  //get services

  Future<dynamic> sendTripRequest() async {
  try {
    dynamic data = await TripRequest().sendRequest(
      _accessToken,placeA, placeB, _selectedService, double.parse(_info.totalDistance.substring(0,_info.totalDistance.length - 3)),);
    return data;
  }on NoDriversAvailable catch(e){

    throw NoDriversAvailable();
  } catch(e){
      throw ErrorTripRequest();
  }

  }

  void changeHeight(double height){
      chatHeight = height;
      notifyListeners();
  }

  Future<void> callDriver() async{

    try{
      await ApiClient().callDriver(_accessToken, user.phone,providerDetails.phone);
    }catch(e){
      throw ErrorCallingDriver;
    }


  }

  double dp(double val, int places){
    num mod = pow(10.0, places);
    return ((val * mod).round().toDouble() / mod);
  }

  Future<void> rateRide(double value) async{

    String comment;
    try{
      if(value.toInt() == 1){
        comment = 'terrible';
      }else if(value.toInt() == 2){
        comment = 'poor';
      }else if(value.toInt() == 3){
        comment = 'ok';
      } else if(value.toInt() == 4){
        comment = 'good';
      }else if(value.toInt() == 5){
        comment = 'excellent';
      }
      await TripRequest().rateProvider(_accessToken,notifications.requestID, value.toInt(), comment);
      topContainerVisibility = false;
      bottomContainerVisibility = true;
      dragrableOneVisibilty = true;
      dragableTwoVibility = false;
      rideNotification = null;
      notifications = null;
      _info = null;
      notifyListeners();
    }catch(e){
     print(e);
    }
  }


}


