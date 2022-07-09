import 'package:cabgo_driver/services/local_notification_service.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:uuid/uuid.dart';
import '../components/side_nav_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:cabgo_driver/states/app_state.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../flutter_flow/place.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';
import 'package:slider_button/slider_button.dart';
import 'package:fswitch_nullsafety/fswitch_nullsafety.dart';
import 'package:rating_dialog/rating_dialog.dart';

class DashboardPageWidget extends StatefulWidget {
  const DashboardPageWidget({Key key}) : super(key: key);

  @override
  _DashboardPageWidgetState createState() => _DashboardPageWidgetState();
}

class _DashboardPageWidgetState extends State<DashboardPageWidget> {
  bool isFinished = false;
  bool isVisible= false;

  var placePickerValue = FFPlace();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    if (appState.notifications != null) {
      FlutterRingtonePlayer.play(fromAsset: "assets/audios/request.mp3");
      WidgetsBinding.instance.addPostFrameCallback((_) {
        show(
          context,
          appState,
          appState.notifications,
        );
      });
      Future.delayed(Duration(milliseconds: 1500), () {
        FlutterRingtonePlayer.stop();
        appState.notifications = null;
      });
    }
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      drawer: Container(
        width: MediaQuery.of(context).size.width * 0.65,
        child: Drawer(
          elevation: 16,
          child: SideNavWidget(),
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              color: Color(0xFFEEEEEE),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Map(),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.01,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xFFEEEEEE),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void show(
      BuildContext context,
      AppState appState,
      PushNotifications notifications,
      ) {
    showModalBottomSheet<void>(
      context: context,
      enableDrag: false,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 30, 0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          notifications.body.toString(),
                          style: FlutterFlowTheme.of(context).title3.override(
                            fontFamily: 'Red Hat Display',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                          child: Text(
                            appState.riderDetails.price,
                            style:
                            FlutterFlowTheme.of(context).subtitle2.override(
                              fontFamily: 'Red Hat Display',
                            ),
                          ),
                        ),
                      ]),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              'assets/images/UI_avatar@2x.png',
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(18, 0, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 5, 0, 5.0),
                                  child: Text(appState.riderDetails.fullName),
                                ),
                                Row(mainAxisSize: MainAxisSize.max, children: [
                                  for (var i = 0; i < 5; i++)
                                    Icon(Icons.star,),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12, 0, 0, 0),
                                    child: Text(
                                      '5/5 Reviews',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText2,
                                    ),
                                  )
                                ]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red[600],
                          primary: Colors.white,
                          padding:
                          const EdgeInsets.only(left: 30.0, right: 30.0),
                          textStyle: const TextStyle(
                            fontSize: 14.0,
                            fontFamily: 'Red Hat Display',
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Decline'),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xFF090f13),
                          primary: Colors.white,
                          padding:
                          const EdgeInsets.only(left: 30.0, right: 30.0),
                          textStyle: const TextStyle(
                            fontSize: 14.0,
                            fontFamily: 'Red Hat Display',
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        onPressed: () async {
                          await appState.acceptRequest(359);
                          //await appState.acceptRequest( int.parse(notifications.requestID));
                          if (appState.info != null) {
                            appState.onlineVisibility = !appState.onlineVisibility;
                            appState.pickupVisibility = !appState.pickupVisibility;
                            appState.dragableSize = 0.35;
                            Navigator.pop(context);
                          } else {
                            print('ooops');
                          }
                        },
                        child: const Text('Accept'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      isDismissible: false,
      isScrollControlled: true,
    );
  }


}


// Drop off page

final _dialog = RatingDialog(
  initialRating: 1.0,

  // your app's name?
  title: Text(
    'TRIP HAS ENDED!!',
    textAlign: TextAlign.center,
    style: const TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
    ),
  ),
  // encourage your user to leave a high rating?
  message: Text(
    'Tap a star to set your rating. Add more description here if you want.',
    textAlign: TextAlign.center,
    style: const TextStyle(fontSize: 15,fontFamily: 'Red Hat Display', ),
  ),
  // your app's logo?
  starSize: 25.0,
  submitButtonText: 'Submit' ,
  commentHint: ' your  comment ',
  onCancelled: () => print('cancelled'),
  onSubmitted: (response) {
    print('rating: ${response.rating}, comment: ${response.comment}');

    // TODO: add your own logic
    if (response.rating < 3.0) {
      // send their comments to your email or anywhere you wish
      // ask the user to contact you instead of leaving a bad review
    } else {
      // _rateAndReviewApp();
    }
  },
);


// drop off page

class Map extends StatefulWidget {
  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  var uuid = Uuid();

  @override
  void initState() {
    super.initState();
  }

  bool isDone = false;
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    if (appState.isOnline) {
      appState.slideIcon = appState.forwardIcon;
    } else {
      appState.slideIcon = appState.backIcon;
    }

    return appState.initialPosition == null
        ? Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SpinKitFadingCircle(
                  itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: index.isEven ? Colors.black54 : Colors.green,
                      ),
                    );
                  },
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Visibility(
              visible: appState.locationServiceActive == false,
              child: Text(
                "Please enable location services!",
                style: TextStyle(color: Colors.grey, fontSize: 18, fontFamily: 'Red Hat Display'),
              ),
            ),
          ],
        ))
        : Stack(
      children: <Widget>[
        LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SizedBox(
                height: constraints.maxHeight / 1.25,
                child: (appState.routeDriver == null)
                    ? GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: appState.initialPosition, zoom: 14),
                  onMapCreated: appState.onCreated,
                  myLocationEnabled: true,
                  mapType: MapType.normal,
                  onCameraMove: appState.onCameraMove,
                  compassEnabled: true,
                )
                    : GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: appState.initialPosition, zoom: 20),
                  onMapCreated: appState.onCreated,
                  myLocationEnabled: true,
                  mapType: MapType.normal,
                  onCameraMove: appState.onCameraMove,
                  compassEnabled: true,
                  markers: {
                    Marker(
                        markerId: MarkerId(uuid.v4()),
                        position: appState.routeDriver.markerSource,
                        infoWindow: InfoWindow(
                            title: 'My Location', snippet: "go here"),
                        icon: BitmapDescriptor.defaultMarker),
                    Marker(
                        markerId: MarkerId(uuid.v4()),
                        position:
                        appState.routeDriver.markerDestination,
                        infoWindow: InfoWindow(
                            title: 'Rider Location',
                            snippet: "go here"),
                        icon: BitmapDescriptor.defaultMarker),
                  },
                  polylines: {
                    Polyline(
                      polylineId: const PolylineId('overview_polyline'),
                      color: Colors.red,
                      width: 5,
                      points: appState.routeDriver.polypoints
                          .map((e) => LatLng(e.latitude, e.longitude))
                          .toList(),
                    ),
                  },
                ),
              );
            }),


        DraggableScrollableSheet(
            initialChildSize: appState.dragableSize,
            minChildSize: 0.2,
            maxChildSize: 1,
            snapSizes: [0.5, 1],
            snap: true,
            builder: (BuildContext context, scrollSheetController) {
              return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0)),
                    border: Border(
                      top: BorderSide(width: 1.0, color: Colors.grey[300]),
                      left: BorderSide(width: 1.0, color: Colors.grey[300]),
                      right:
                      BorderSide(width: 1.0, color: Colors.grey[300]),
                      bottom:
                      BorderSide(width: 1.0, color: Colors.grey[300]),
                    ),
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: ClampingScrollPhysics(),
                    controller: scrollSheetController,
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {


                      return Padding(
                          padding: EdgeInsets.only(left: 8.0, top: 1.0,right: 8.0,bottom: 8.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: SizedBox(
                                  width: 50,
                                  child: Divider(
                                    thickness: 2,
                                  ),
                                ),
                              ),


                              // GO ONLINE BUTTON
                              Visibility(
                                visible: appState.onlineVisibility,
                                child: FSwitch(
                                  width: 300,
                                  height: 68,
                                  openColor: Color(0xff090f13),
                                  sliderColor: Color(0xff090f13),

                                  onChanged: (v) async {
                                    print("test ===========");
                                    if (appState.isOnline) {
                                      await appState.goOnline('offline');
                                    } else {
                                      await appState.goOnline('active');
                                    }
                                  },
                                  closeChild: Text(
                                    "GO ONLINE",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18, fontFamily: 'Red Hat Display',
                                        fontWeight: FontWeight.w300
                                    ),
                                  ),
                                  openChild: Text(
                                    "GO OFFLINE",
                                    style: TextStyle(
                                      color: Colors.white, fontSize: 18,
                                      fontFamily: 'Red Hat Display',

                                    ),
                                  ),
                                  sliderChild: appState.slideIcon,
                                ),
                              ),
                              //  GO ONLINE BUTTON END

                              //  PICKUP PAGE
                              Visibility(
                                  visible: appState.pickupVisibility,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 12),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: 50,
                                                  height: 50,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Image.asset(
                                                    'assets/images/UI_avatar@2x.png',
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  EdgeInsetsDirectional.fromSTEB(18, 0, 0, 0),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                            0, 5, 0, 5.0),
                                                        child: (appState.riderDetails != null) ? Text(appState.riderDetails.fullName) : Text('test'),
                                                      ),
                                                      Row(mainAxisSize: MainAxisSize.max, children: [
                                                        for (var i = 0; i < 5; i++)
                                                          Icon(Icons.star_border_outlined),
                                                        Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                              12, 0, 0, 0),
                                                          child: TextButton(
                                                            style: TextButton.styleFrom(
                                                              backgroundColor: Colors.red[600],
                                                              primary: Colors.white,
                                                              textStyle: const TextStyle(
                                                                fontSize: 14.0,
                                                                fontFamily: 'Red Hat Display',
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.w300,
                                                              ),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.pop(context);
                                                            },
                                                            child: const Text('Cancel Ride',


                                                            ),
                                                          ),
                                                        )
                                                      ]),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 25),
                                        child: SliderButton(
                                          action: () async {
                                            await appState.driveToRiderDestination();
                                            appState.pickupVisibility = !appState.pickupVisibility;
                                            appState.dropoffVisibility = !appState.dropoffVisibility;
                                            appState.dragableSize = 0.2;
                                            // dropOff(context, appState);
                                          },
                                          label: Text(
                                            "SLIDE TO PICKUP",
                                            style: TextStyle(
                                              color: Color(0xff090f13), fontWeight: FontWeight.w300, fontSize: 18,fontFamily: 'Red Hat Display',),
                                          ),
                                          icon: Center(
                                              child: Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                color: Color(0xff090f13),
                                                size: 40.0,
                                                semanticLabel: 'Text to announce in accessibility modes',
                                              )),
                                          width: double.infinity,
                                          buttonColor: Colors.white,
                                          backgroundColor: Color(0xff090f13),
                                          highlightedColor: Colors.white,
                                          baseColor: Colors.white,

                                        ),

                                      ),
                                    ],
                                  )
                              ),

                              //  PICKUP PAGE END

                              //  DROPOFF PAGE START
                              Visibility(
                                visible: appState.dropoffVisibility,

                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 25),
                                      child: SliderButton(
                                        action: () async {
                                          showDialog(
                                            context: context,
                                            barrierDismissible: true, // set to false if you want to force a rating
                                            builder: (context) => _dialog,
                                          );
                                          appState.onlineVisibility = !appState.onlineVisibility;

                                        },
                                        label: Text(
                                          "SLIDE TO DROP OFF",
                                          style: TextStyle(
                                            color: Color(0xff090f13), fontWeight: FontWeight.w300, fontSize: 18, fontFamily: 'Red Hat Display',),
                                        ),
                                        icon: Center(
                                            child: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: Color(0xff090f13),
                                              size: 40.0,
                                              semanticLabel: 'Text to announce in accessibility modes',
                                            )),
                                        width: double.infinity,
                                        buttonColor: Colors.white,
                                        backgroundColor: Color(0xff090f13),
                                        highlightedColor: Colors.white,
                                        baseColor: Colors.white,

                                      ),

                                    ),
                                  ],
                                ),
                              ),
                              //  DROPOFF PAGE ENDS
                            ],
                          ));


                    },
                  ));
            }),

        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: AlignmentDirectional(-1, -1),
                  child: FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 30,
                    borderWidth: 1,
                    buttonSize: 60,
                    icon: Icon(
                      Icons.menu_sharp,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () async {
                      appState.scaffoldKey.currentState.openDrawer();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.01,
          height: 100,
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
          ),
        ),
      ],
    );
  }
}
