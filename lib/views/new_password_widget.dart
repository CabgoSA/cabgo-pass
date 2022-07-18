import 'dart:ui';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import './otp_verification.dart';

class NewPasswordWidget extends StatefulWidget {
  const NewPasswordWidget({Key key}) : super(key: key);

  @override
  _NewPasswordWidgetState createState() => _NewPasswordWidgetState();
}

class _NewPasswordWidgetState extends State<NewPasswordWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
          'Reset Password',
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
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 50),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Enter your cellphone number you sed for regitering',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff0F0F0F),

                        ),

                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: TextField(
                          keyboardType: TextInputType.visiblePassword,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(

                            hintText: "Enter new password",
                            fillColor: Color(0xffE0E0E0),
                            enabledBorder:  OutlineInputBorder(
                                borderSide: BorderSide(width: 1, color: Color(0xff169F49)),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            border:  OutlineInputBorder(
                              borderSide: BorderSide(width: 1, color: Color(0xff169F49)),
                              borderRadius: BorderRadius.circular(10),

                            ),
                            contentPadding: EdgeInsets.only(left: 15.0, top: 25.0),
                            filled: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: TextField(
                          keyboardType: TextInputType.visiblePassword,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(

                            hintText: "Confirm new password",
                            fillColor: Color(0xffE0E0E0),
                            enabledBorder:  OutlineInputBorder(
                                borderSide: BorderSide(width: 1, color: Color(0xff169F49)),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            border:  OutlineInputBorder(
                              borderSide: BorderSide(width: 1, color: Color(0xff169F49)),
                              borderRadius: BorderRadius.circular(10),

                            ),
                            contentPadding: EdgeInsets.only(left: 15.0, top: 25.0),
                            filled: true,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: TextButton(
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OtpVerificationWidget(),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 50.0, right: 50, top: 6.0, bottom: 6.0),
                              child: Text('Submit',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: "Red Hat Display",
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            ),

                            style: TextButton.styleFrom(
                              backgroundColor: Color(0xff02A702),
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10),

                              )

                              ),
                            )
                        ),
                      ),
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
