import 'package:cabgo/views/components/side_nav_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:cabgo/states/app_state.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'LocationAccessScreen.dart';

class DashboardPageWidget extends StatefulWidget {
  const DashboardPageWidget({Key key}) : super(key: key);

  @override
  _DashboardPageWidgetState createState() => _DashboardPageWidgetState();
}

class _DashboardPageWidgetState extends State<DashboardPageWidget> {
  var placePickerValue = FFPlace();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
}

class Map extends StatefulWidget {
  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
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
                          color: index.isEven ? Colors.red : Colors.green,
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
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
              )
            ],
          ))
        : Stack(
            children: <Widget>[
              GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: appState.initialPosition, zoom: 18),
                onMapCreated: appState.onCreated,
                myLocationEnabled: true,
                mapType: MapType.normal,
                markers: appState.markers,
                onCameraMove: appState.onCameraMove,
                compassEnabled: true,
                polylines: {
                  if (appState.info != null)
                    Polyline(
                      polylineId: const PolylineId('overview_polyline'),
                      color: Colors.red,
                      width: 5,
                      points: appState.info.polylinePoints
                          .map((e) => LatLng(e.latitude, e.longitude))
                          .toList(),
                    ),
                },
              ),
              if (appState.info != null)
                Positioned(
                  top: 15.0,
                  left: 100.0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6.0,
                      horizontal: 12.0,
                    ),
                    decoration: BoxDecoration(
                      color:  Color(0xFF169F49),
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 6.0,
                        )
                      ],
                    ),
                    child: Text(
                      '${appState.info.totalDistance}, ${appState.info.totalDuration}',
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
              Positioned(
                top: 60.0,
                right: 15.0,
                left: 15.0,
                child: Container(
                  height: 50.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(1.0, 5.0),
                          blurRadius: 10,
                          spreadRadius: 3)
                    ],
                  ),
                  child: TextField(
                    cursorColor: Colors.black,
                    controller: appState.locationController,
                    decoration: InputDecoration(
                      icon: Container(
                        margin: EdgeInsets.only(left: 20, top: 5),
                        width: 10,
                        height: 10,
                        child: Icon(
                          Icons.location_on,
                          color: Colors.black,
                        ),
                      ),
                      hintText: "pick up",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 120.0,
                right: 15.0,
                left: 15.0,
                child: Container(
                  height: 50.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black87,
                          offset: Offset(1.0, 0.1),
                          blurRadius: 1,
                          spreadRadius: 0.2)
                    ],
                  ),
                  child: TextField(
                    cursorColor: Colors.black,
                    controller: appState.destinationController,
                    textInputAction: TextInputAction.go,
                    onSubmitted: (value) async {
                      appState.sendRequest(value);
                      //get services
                      dynamic data = await appState.getServices();
                     String distance = appState.info.totalDistance.substring(0, appState.info.totalDistance.length - 3);
                     print('------------------------------------------------------------------------------');
                      print(data);

                      _bottomSheetMore(context, appState, data, double.parse(distance));
                    },

                    decoration: InputDecoration(
                      icon: Container(
                        margin: EdgeInsets.only(left: 20, top: 5),
                        width: 10,
                        height: 10,
                        child: Icon(
                          Icons.local_taxi,
                          color: Colors.black,
                        ),
                      ),
                      hintText: "destination?",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
                    ),
                  ),
                ),
              ),
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

//bottomsheet start
  void _bottomSheetMore(context, appState,  dynamic services, double distance) {

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      builder: (builder) {
        return Container(
          height: 300,
          padding: EdgeInsets.only(
            left: 5.0,
            right: 5.0,
            top: 5.0,
            bottom: 0.0,
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0))),
          child: Column(
            children: <Widget>[
              //sercices here
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,

                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  //services here!!!!!

                  children: [
                  for (var service in services)

                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [

                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                            child: Text(
                                'R' + (distance * double.parse(service['price'])).toString(), // estimated price of ride
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Red Hat Display',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                            ),
                          ),
                          Image.network(
                            service['image'],
                            width: 100,
                            height: 100,
                            fit: BoxFit.contain,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                            child: Text(
                              service['capacity'],
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Red Hat Display',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                            child: Text(
                              service['name'],
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Red Hat Display',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ), // 1
                  ],

                //  end services here!!!!!!!!
                ),
              ),


              //services procced  here
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFF169F49),
                  ),
                  alignment: AlignmentDirectional(-0.09999999999999998, 0),
                  child: InkWell(
                    onTap: () async{
                      await appState.sendTripRequest(1 , distance);
                      Navigator.pop(context);
                      _bottomSheetPay(context, appState,);
                    },
                   child: Text(
                      'PROCEED',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Red Hat Display',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),


            ],
          ),
        );
      },
    );
  }
//  bottomsheet end

// ride now bottom sheet

  void _bottomSheetPay(context, appState,) {

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      builder: (builder) {

        return Container(
          height: 200,
          padding: EdgeInsets.only(

            top: 5.0,
            bottom: 0.0,
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0))),
          child: // Generated code for this Column Widget...
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                    child: Text(
                      'Estimated Fare',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Red Hat Display',
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        'assets/images/Xpress.png',
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                    child: Text(
                      'R401.00',
                      style: FlutterFlowTheme.of(context).bodyText1,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Caupon',
                          textAlign: TextAlign.start,
                          style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                          child: Text(
                            'Payment: Cash',
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'View Coupons ',
                          style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                          child: Text(
                            'CHANGE',
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                      child: FFButtonWidget(
                        onPressed: () {
                           Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  LocationAccessScreen(),
                            ),
                          );
                        },
                        text: 'RIDE NOW',
                        options: FFButtonOptions(

                          color: FlutterFlowTheme.of(context).primaryColor,
                          textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                            fontFamily: 'Red Hat Display',
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: 5,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                      child: FFButtonWidget(
                        onPressed: () {
                          print('Button pressed ...');
                        },
                        text: 'SCHEDULE RIDE',
                        options: FFButtonOptions(
                          width: 130,
                          height: 40,
                          color: FlutterFlowTheme.of(context).primaryColor,
                          textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                            fontFamily: 'Red Hat Display',
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: 5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
          ,
        );
      },
    );
  }
// ride now bottom sheet end

}