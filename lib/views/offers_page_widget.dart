import 'package:provider/provider.dart';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

import '../states/app_state.dart';

class OffersPageWidget extends StatefulWidget {
  const OffersPageWidget({Key key}) : super(key: key);

  @override
  _OffersPageWidgetState createState() => _OffersPageWidgetState();
}

class _OffersPageWidgetState extends State<OffersPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.arrow_back_sharp,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Offers',
          style: FlutterFlowTheme.of(context).bodyText1.override(
                fontFamily: 'Red Hat Display',
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 2,
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  children: [
                   for(var i = 0; i < appState.promocodes.length; i++)
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                        child: Material(
                          color: Colors.transparent,
                          elevation: 1,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Color(0xFFEEEEEE),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: Image
                                    .network(
                                  '',
                                )
                                    .image,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 1,
                                  color: Colors.black,
                                )
                              ],
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: FlutterFlowTheme
                                    .of(context)
                                    .secondaryText,
                                width: 1,
                              ),
                            ),

                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  5, 0, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    appState.promocodes[i]["promo_code"].toString(),
                                    style: FlutterFlowTheme
                                        .of(context)
                                        .bodyText1,
                                  ),
                                  Text(
                                    appState.promocodes[i]["promo_description"].toString(),
                                    style: FlutterFlowTheme
                                        .of(context)
                                        .bodyText1
                                        .override(
                                      fontFamily: 'Red Hat Display',
                                      color: FlutterFlowTheme
                                          .of(context)
                                          .secondaryText,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    'Valid Till : '+ appState.promocodes[i]["expiration"],
                                    style: FlutterFlowTheme
                                        .of(context)
                                        .bodyText1
                                        .override(
                                      fontFamily: 'Red Hat Display',
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
