import 'package:cabgo/views/help_page_widget.dart';
import 'package:cabgo/views/offers_page_widget.dart';
import 'package:cabgo/views/home_page_widget.dart';
import 'package:cabgo/views/payment_page_widget.dart';
import 'package:cabgo/views/settings_widget.dart';
import 'package:cabgo/views/trips_page_widget.dart';
import 'package:cabgo/views/wallet_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:cabgo/states/app_state.dart';
import 'package:share_plus/share_plus.dart';
import 'package:provider/provider.dart';

import '../../flutter_flow/flutter_flow_theme.dart';

class SideNavWidget extends StatefulWidget {
  const SideNavWidget({Key key}) : super(key: key);

  @override
  _SideNavWidgetState createState() => _SideNavWidgetState();
}

class _SideNavWidgetState extends State<SideNavWidget> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: BoxDecoration(
        color: Color(0xFFEEEEEE),
      ),
      child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 8),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 80,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).lineColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.transparent,
                  )
                ],
                borderRadius: BorderRadius.circular(0),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(26),

                      child: (appState.user.picture != null) ? Image.network(
                        appState.user.picture,
                        width: 36,
                        height: 36,
                        fit: BoxFit.cover,
                      ):
                      Image.network(
                        'https://images.unsplash.com/photo-1463453091185-61582044d556?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzJ8fHVzZXJ8ZW58MHx8MHx8&auto=format&fit=crop&w=900&q=60',
                        width: 36,
                        height: 36,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                appState.user.fullName,
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF0F1113),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    appState.user.email,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText2
                                        .override(
                                          fontFamily: 'Outfit',
                                          color: Color(0xFF57636C),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width,
            ),
            decoration: BoxDecoration(
              color: Color(0x00EEEEEE),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                  child: InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentPageWidget(),
                        ),
                      );
                    },
                    child: Text(
                      'Payment',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Red Hat Display',
                            fontSize: 18,
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                  child: InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TripsPageWidget(),
                        ),
                      );
                    },
                    child: Text(
                      'My Trips',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Red Hat Display',
                            fontSize: 18,
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                  child: InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OffersPageWidget(),
                        ),
                      );
                    },
                    child: Text(
                      'Offers',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Red Hat Display',
                            fontSize: 18,
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                  child: InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WalletPageWidget(),
                        ),
                      );
                    },
                    child: Text(
                      'Wallet',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Red Hat Display',
                            fontSize: 18,
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                  child: InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingsWidget(),
                        ),
                      );
                    },
                    child: Text(
                      'Settings',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Red Hat Display',
                            fontSize: 18,
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                  child: InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HelpPageWidget(),
                        ),
                      );
                    },
                    child: Text(
                      'Help',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Red Hat Display',
                            fontSize: 18,
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                  child: InkWell(
                    onTap: () async {
                      await Share.share('');
                    },
                    child: Text(
                      'Share',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Red Hat Display',
                            fontSize: 18,
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                  child: InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WalletPageWidget(),
                        ),
                      );
                    },
                    child: Text(
                      'Become a driver',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Red Hat Display',
                            fontSize: 18,
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                  child: InkWell(
                    onTap: () async {
                      try {
                        await appState.passangerLogout();
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePageWidget(),
                          ),
                        );
                      }catch(e){
                        print(e);
                      }
                    },
                    child: Text(
                      'Logout',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Red Hat Display',
                            fontSize: 18,
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
    );
  }
}
