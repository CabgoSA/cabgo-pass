import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class LocationAccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/9_Location Error.png",
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.15,
            left: MediaQuery.of(context).size.width * 0.3,
            right: MediaQuery.of(context).size.width * 0.3,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 13),
                    blurRadius: 25,
                    color: Color(0xFFD27E4A).withOpacity(0.17),
                  ),
                ],
              ),
              child: TextButton(



                style: TextButton.styleFrom(
                  primary: Colors.white,  //Text Color
                  backgroundColor:  FlutterFlowTheme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),//Button Background Color



                  onPressed: () async {

                  },
                child: Text(
                  "Enable".toUpperCase(),
                  style: TextStyle(color: Colors.white,  fontFamily: 'Red Hat Display',),

                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}