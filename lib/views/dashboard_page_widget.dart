import 'dart:async';

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
import '../states/app_state.dart';
import 'chat_page_widget.dart';
import 'package:progress_dialog/progress_dialog.dart';

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
    final appState = Provider.of<AppState>(context);
    if (appState.notifications != null) {
        print('incoming message');
        setState(() {
          appState.dragableTwoVibility = true;
          appState.dragrableOneVisibilty = false;
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
      body:

      SafeArea(

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

  Timer _debounce;




  @override
  Widget build(BuildContext context) {
    ProgressDialog loading = ProgressDialog(context);
    loading = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);


    loading.style(
        message: 'Loading....please wait.',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator( valueColor: AlwaysStoppedAnimation<Color>(Colors.black), strokeWidth: 2,),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w600)
    );
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

              LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return SizedBox(
                        height: constraints.maxHeight / 1.25,
                        child: GoogleMap(
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


                    );
                  }),

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

              //gradableOneVibilty

              Visibility(
                visible: appState.dragrableOneVisibilty,
                  child:  DraggableScrollableSheet(
                      initialChildSize: appState.dragableHeight,
                      minChildSize: 0.2,
                      maxChildSize: 1,
                      snapSizes: [0.5, 1],
                      snap: true,
                      builder: (BuildContext context, scrollSheetController) {
                        return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[300],
                                  blurRadius: 2.0,
                                  spreadRadius: 0.0,
                                  offset:  Offset(0, -3), // shadow direction: bottom right
                                )
                              ],
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



                                        Visibility(
                                          visible: appState.topContainerVisibility,
                                          child: Padding(
                                            padding: const EdgeInsets.only( top: 0, ),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 30.0,  bottom: 10),
                                                  child: Row(

                                                    children: [
                                                      Text(
                                                        'Your Route',
                                                        style: TextStyle(
                                                          fontFamily: '',
                                                          fontSize: 18.0,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),

                                                      IconButton(
                                                        onPressed: (){
                                                          appState.dragableHeight= 0.2;
                                                          appState.bottomContainerVisibility = !appState.bottomContainerVisibility;
                                                          appState.topContainerVisibility= !appState.topContainerVisibility;
                                                          setState(() {
                                                          });
                                                        },
                                                        icon: Icon(Icons.close,size: 25.0,color: Color(0xffDC143C),),
                                                      ),
                                                    ],
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 10.0),
                                                  child: SizedBox(
                                                    width: double.infinity,
                                                    child: Divider(
                                                      thickness: 1,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 8.0),
                                                  child: TextField(
                                                    cursorColor: Colors.black,
                                                    controller: appState.startController,
                                                    autofocus: false,
                                                    focusNode: appState.startFocusNode,

                                                    decoration: InputDecoration(
                                                      icon: Container(
                                                        margin: EdgeInsets.only( top: 5),
                                                        width: 10,
                                                        height: 10,
                                                        child: Icon(
                                                          Icons.location_on,
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                      hintText: "pick up",
                                                      fillColor: Colors.grey,
                                                      border:  OutlineInputBorder(
                                                          borderSide:  BorderSide(color: Colors.teal)
                                                      ),
                                                      contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
                                                        suffixIcon: appState.startController.text.isNotEmpty
                                                            ? IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              appState.predictions = [];
                                                              appState.startController.clear();
                                                            });
                                                          },
                                                          icon: Icon(Icons.clear_outlined),
                                                        )
                                                            : null,
                                                    ),
                                                    onChanged: (value) {
                                                      if (_debounce?.isActive ?? false) _debounce.cancel();
                                                      _debounce = Timer(const Duration(milliseconds: 1000), () {
                                                        if (value.isNotEmpty) {
                                                          //places api
                                                          appState.autoCompleteSearch(value);
                                                        } else {
                                                          //clear out the results
                                                          setState(() {
                                                            appState.predictions = [];
                                                            appState.startPosition = null;
                                                          });
                                                        }
                                                      });
                                                    },
                                                  ),
                                                ),
                                                TextField(
                                                  cursorColor: Colors.red,
                                                  controller: appState.destinationController,
                                                  textInputAction: TextInputAction.go,
                                                  onSubmitted: (value) async {
                                                    appState.dragableHeight= 0.2;
                                                    appState.bottomContainerVisibility = !appState.bottomContainerVisibility;
                                                    appState.topContainerVisibility= !appState.topContainerVisibility;
                                                    loading.show();
                                                    try {
                                                      await appState
                                                          .sendRequest();
                                                      //get services
                                                      await appState
                                                          .getServices();
                                                      String distance = appState
                                                          .info.totalDistance
                                                          .substring(0,
                                                          appState.info
                                                              .totalDistance
                                                              .length - 3);
                                                      loading.hide();
                                                      _bottomSheetMore(
                                                          context, appState, double.parse(
                                                          distance),loading);


                                                    }catch(e){
                                                      loading.hide();
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                          SnackBar(
                                                            content: const Text('Problems in placing request'),
                                                            backgroundColor: Colors.red,
                                                            action: SnackBarAction(
                                                              label: 'Try again',
                                                              textColor: Colors.white,
                                                              onPressed: () {
                                                                // Some code to undo the change.
                                                              },
                                                            ),
                                                          )
                                                      );
                                                    }

                                                  },

                                                  decoration: InputDecoration(
                                                    fillColor: Colors.grey,
                                                    icon: Container(
                                                      width: 10,
                                                      child: Icon(
                                                        Icons.search,
                                                        color: Colors.grey[100],
                                                      ),
                                                    ),
                                                    border:  OutlineInputBorder(
                                                        borderSide:  BorderSide(color: Colors.teal)
                                                    ),
                                                    hintText: "Where to destination? " ,
                                                    suffixIcon: appState.destinationController.text.isNotEmpty
                                                        ? IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          appState.predictions = [];
                                                          appState.destinationController.clear();
                                                        });
                                                      },
                                                      icon: Icon(Icons.clear_outlined),
                                                    )
                                                        : null,
                                                    contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
                                                  ),
                                                  onChanged: (value) {
                                                    if (_debounce?.isActive ?? false) _debounce.cancel();
                                                    _debounce = Timer(const Duration(milliseconds: 1000), () {
                                                      if (value.isNotEmpty) {
                                                        //places api
                                                        appState.autoCompleteSearch(value);
                                                      } else {
                                                        //clear out the results
                                                        setState(() {
                                                          appState.predictions = [];
                                                          appState.endPosition = null;
                                                        });
                                                      }
                                                    });
                                                  },
                                                ),

                                                ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: appState.predictions.length,
                                                    itemBuilder: (context, index) {
                                                      return ListTile(
                                                        leading: CircleAvatar(
                                                          child: Icon(
                                                            Icons.pin_drop,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        title: Text(
                                                          appState.predictions[index].description.toString(),
                                                        ),
                                                        onTap: () async {
                                                          final placeId = appState.predictions[index].placeId;
                                                          final details = await appState.googlePlace.details.get(placeId);
                                                          if (details != null &&
                                                              details.result != null &&
                                                              mounted) {
                                                            if (appState.startFocusNode.hasFocus) {
                                                              setState(() {
                                                                appState.startPosition = details.result;
                                                                appState.startController.text =
                                                                details.result.name;
                                                                appState.predictions = [];
                                                              });
                                                            } else {
                                                              setState(() {
                                                                appState.endPosition = details.result;
                                                                appState.destinationController.text = details.result.name;
                                                                appState.predictions = [];
                                                              });
                                                            }
                                                            //
                                                            // if (appState.startPosition != null && appState.endPosition != null) {
                                                            //   print('navigate');
                                                            //   Navigator.push(
                                                            //     context,
                                                            //     MaterialPageRoute(
                                                            //       builder: (context) => MapScreen(),
                                                            //     ),
                                                            //   );
                                                            // }
                                                          }
                                                        },
                                                      );
                                                    })
                                              ],
                                            ),
                                          ),

                                        ),

                                        //first search input
                                        Visibility(
                                            visible: appState.bottomContainerVisibility,
                                            child:
                                            TextField(
                                              cursorColor: Colors.black,
                                              controller: appState.destinationController,
                                              textInputAction: TextInputAction.go,

                                              onTap: (){
                                                appState.dragableHeight = 0.95;
                                                appState.bottomContainerVisibility = !appState.bottomContainerVisibility;
                                                appState.topContainerVisibility = !appState.topContainerVisibility;
                                              },

                                              decoration: InputDecoration(
                                                fillColor: Colors.grey,
                                                icon: Container(

                                                  width: 10,

                                                  child: Icon(
                                                    Icons.search,
                                                    color: Colors.grey[100],
                                                  ),
                                                ),
                                                border:  OutlineInputBorder(
                                                    borderSide:  BorderSide(color: Colors.teal)
                                                ),
                                                hintText: "Where to destination 111?" ,
                                                suffixIcon: Icon(Icons.pin_drop_outlined, color: Colors.blue,),

                                                contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
                                              ),
                                            )
                                        ),


                                      ],
                                    ));


                              },
                            ));
                      }),
              ),
              //dragableOneVisibilty end





              //gradabletwoVibilty

              Visibility(
                visible: appState.dragableTwoVibility,
                child:  DraggableScrollableSheet(
                    initialChildSize: 0.4,
                    minChildSize: 0.2,
                    maxChildSize: 1,
                    snapSizes: [0.5, 1],
                    snap: true,
                    builder: (BuildContext context, scrollSheetController) {
                      return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[300],
                                blurRadius: 2.0,
                                spreadRadius: 0.0,
                                offset:  Offset(0, -3), // shadow direction: bottom right
                              )
                            ],
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
                                      Row(
                                        children: [
                                          Text('Request Accepted', style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Red Hat Display"
                                          ),
                                          ),
                                          IconButton(
                                          icon: const Icon(Icons.message),
                                            color: Colors.green,
                                            tooltip: 'Increase volume by 10',
                                            onPressed: () async{
                                              await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => ChatPageWidget(),
                                                ),
                                              );
                                            },
                                            ),

                                        ],
                                      ),
                                      // Generated code for this ListView Widget...
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 44),
                                        child: ListView(
                                          padding: EdgeInsets.zero,
                                          primary: false,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: Divider(
                                                  thickness: 0.3,
                                                ),
                                              ),
                                            ),
                                             Container(
                                                width: double.infinity,
                                                height: 60,

                                                child: Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius: BorderRadius.circular(26),
                                                        child: Image.network(
                                                         appState.providerDetails.picture,
                                                          width: 50,
                                                          height: 50,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.max,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                appState.providerDetails.fullName,
                                                                style: FlutterFlowTheme.of(context).bodyText1,
                                                              ),
                                                              Row(mainAxisSize: MainAxisSize.max, children: [
                                                                for (var i = 0; i < 5; i++)
                                                                  Icon(Icons.star, color: Color(0xffFFD700 ),),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional.fromSTEB(
                                                                      12, 0, 0, 0),
                                                                  child: Text(
                                                                    appState.providerDetails.rating,
                                                                    style: FlutterFlowTheme.of(context)
                                                                        .bodyText2,
                                                                  ),
                                                                )
                                                              ]),
                                                            ],
                                                          ),
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: Divider(
                                                  thickness: 0.3,
                                                ),
                                              ),
                                            ),
                                           Container(
                                                width: double.infinity,
                                                height: 60,
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius: BorderRadius.circular(26),
                                                        child: Image.network(
                                                          appState.providerDetails.serviceImage,
                                                          width: 50,
                                                          height: 50,
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.max,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                appState.providerDetails.serviceName,
                                                                style: FlutterFlowTheme.of(context).bodyText1,
                                                              ),
                                                              Row(
                                                                mainAxisSize: MainAxisSize.max,
                                                                children: [
                                                                  Text(
                                                                    '3 Mins',
                                                                    style: FlutterFlowTheme.of(context).bodyText2,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        'R'+appState.providerDetails.price
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: Divider(
                                                  thickness: 0.3,
                                                ),
                                              ),
                                            ),


                                          ],
                                        ),
                                      )

                                    ],
                                  ));


                            },
                          ));
                    }),
              ),
              //dragabletwoVisibilty end
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
  void _bottomSheetMore(context, appState, double distance, ProgressDialog loading ) {

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
                  for (var service in appState.services)

                    GestureDetector(
                      onTap: () {
                        appState.setService(service['id']);
                      },
                      child: Padding(
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
                      ),
                    ), // 1
                  ],

                //  end services here!!!!!!!!
                ),
              ),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: TextButton(
                  onPressed:  () async{
                    try {
                      Navigator.pop(context);
                      _bottomSheetPay(context, appState,);
                    }catch(e){

                    }

                  },

                  child: Text('PROCEED',
                  style: TextStyle(
                    color: Colors.white
                  ),
                  ),

                  style: ButtonStyle(
                    backgroundColor:  MaterialStateProperty.all(Color(0xFF169F49))

                  ),
                ),
              ),

              //services procced  here



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
                      child: Image.network(
                        appState.estimateImage,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                    child: Text(
                      'R'+appState.estimatePrice,
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
                        onPressed: () async{

                           try{
                             await appState.sendTripRequest();
                           }catch(e){

                           }
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
