import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import '../states/app_state.dart';
import './login_page_widget.dart';
import './new_password_widget.dart';

class OtpVerificationWidget extends StatefulWidget {
  const OtpVerificationWidget({Key key}) : super(key: key);

  @override
  _OtpVerificationWidgetState createState() => _OtpVerificationWidgetState();
}

class _OtpVerificationWidgetState extends State<OtpVerificationWidget> {
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
          'OTP Verification ',
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 50),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Enter OTP send to *****' +
                            appState.resetPhoneNumber.text.substring(5),
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff0F0F0F),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              SizedBox(
                                width: 50,
                                height: 60,
                                child: TextField(
                                  textInputAction: TextInputAction.next,
                                  maxLength: 1,
                                  maxLengthEnforcement:
                                      MaxLengthEnforcement.none,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(4.0),
                                      ),
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                  maxLines: 1,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              SizedBox(
                                width: 50,
                                height: 60,
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  maxLength: 1,
                                  maxLengthEnforcement:
                                      MaxLengthEnforcement.enforced,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(4.0),
                                      ),
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                  maxLines: 1,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              SizedBox(
                                width: 50,
                                height: 60,
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  maxLength: 1,
                                  maxLengthEnforcement:
                                      MaxLengthEnforcement.enforced,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(4.0),
                                      ),
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                  maxLines: 1,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              SizedBox(
                                width: 50,
                                height: 60,
                                child: TextFormField(
                                  maxLength: 1,
                                  maxLengthEnforcement:
                                      MaxLengthEnforcement.enforced,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(4.0),
                                      ),
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                  maxLines: 1,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ]),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('Didn’t recieve code? '),
                                GestureDetector(
                                  onTap: () async {
                                    try {
                                      bool result =
                                          await InternetConnectionChecker()
                                              .hasConnection;
                                      if (result) {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                LoginPageWidget(),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          appState.SnackBarCaller(
                                              "No Internet Connection!"),
                                        );
                                      }
                                    } catch (_) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        appState.SnackBarCaller(
                                            "There was a problem!"),
                                      );
                                    }
                                  },
                                  child: Text(
                                    'Resend code',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w900),
                                  ),
                                )
                              ])),
                      Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: TextButton(
                            onPressed: () async {
                              try {
                                bool result = await InternetConnectionChecker()
                                    .hasConnection;
                                if (result) {
                                  await appState.passwordReset();
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NewPasswordWidget(),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    appState.SnackBarCaller(
                                        "No internet connection!"),
                                  );
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  appState.SnackBarCaller("Incorect OTP"),
                                );
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 50.0, right: 50, top: 6.0, bottom: 6.0),
                              child: Text(
                                'Verify',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: "Red Hat Display",
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: Color(0xff02A702),
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              )),
                            )),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Go back to '),
                              GestureDetector(
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPageWidget(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'sign in',
                                  style: TextStyle(fontWeight: FontWeight.w900),
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
