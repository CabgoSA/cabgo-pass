
import 'package:flutter/cupertino.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';




class ChatPageWidget extends StatefulWidget {
  const ChatPageWidget({Key key}) : super(key: key);

  @override
  _ChatPageWidgetState createState() => _ChatPageWidgetState();
}

class _ChatPageWidgetState extends State<ChatPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 80.0,
        backgroundColor: FlutterFlowTheme
            .of(context)
            .primaryColor,
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
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.network(
                'https://picsum.photos/seed/940/600',
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(

                children: [
                  Text(
                    'Nkanyiso Ncube',
                    style: FlutterFlowTheme
                        .of(context)
                        .title2
                        .override(
                      fontFamily: 'Red Hat Display',
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    'Online',
                    style: FlutterFlowTheme
                        .of(context)
                        .title2
                        .override(
                      fontFamily: 'Red Hat Display',
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),



          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: IconButton(onPressed: (){}, icon: Icon(Icons.phone, color: Colors.white, size: 30.0,)),
          )
        ],
        centerTitle: false,
        elevation: 2,
      ),
      backgroundColor: FlutterFlowTheme
          .of(context)
          .primaryBackground,
      body: SafeArea(

        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/chat.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [

              LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return SizedBox(
                      height: constraints.maxHeight / 1.4,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Today - 9:45', style: TextStyle(
                                    fontFamily: 'Red Hat Display',
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400
                                ),),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [


                                Flexible(

                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 3 / 5,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        padding: EdgeInsets.all(14),
                                        decoration: BoxDecoration(
                                          color: Color(0xff056905),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),

                                          boxShadow: [ BoxShadow(
                                            color: Colors.black54,
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: Offset(
                                                0, 2), // changes position of shadow
                                          ),
                                          ],
                                        ),
                                        child: Text(
                                          'testing some text and some more text and more yes more text ',
                                          style: TextStyle(color: Colors.white, fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ),

                                ),

                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/940/600',
                                  ),
                                ),
                                Flexible(
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 3 / 5,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        padding: EdgeInsets.all(14),
                                        decoration: BoxDecoration(
                                          color: Color(0xff02A702),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),

                                          boxShadow: [ BoxShadow(
                                            color: Colors.black54,
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: Offset(
                                                0, 2), // changes position of shadow
                                          ),
                                          ],
                                        ),
                                        child: Text(
                                          'testing some text from driver  text from driver ',
                                          style: TextStyle(color: Colors.white, fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ),

                                ),

                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 3 / 5,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        padding: EdgeInsets.all(14),
                                        decoration: BoxDecoration(
                                          color: Color(0xff02A702),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),

                                          boxShadow: [ BoxShadow(
                                            color: Colors.black54,
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: Offset(
                                                0, 2), // changes position of shadow
                                          ),
                                          ],
                                        ),
                                        child: Text(
                                          'testing some text from driver  text from driver ',
                                          style: TextStyle(color: Colors.white, fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ),

                                ),

                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 3 / 5,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        padding: EdgeInsets.all(14),
                                        decoration: BoxDecoration(
                                          color: Color(0xff02A702),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),

                                          boxShadow: [ BoxShadow(
                                            color: Colors.black54,
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: Offset(
                                                0, 2), // changes position of shadow
                                          ),
                                          ],
                                        ),
                                        child: Text(
                                          'testing some text from driver  text from driver ',
                                          style: TextStyle(color: Colors.white, fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ),

                                ),

                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 3 / 5,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        padding: EdgeInsets.all(14),
                                        decoration: BoxDecoration(
                                          color: Color(0xff02A702),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),

                                          boxShadow: [ BoxShadow(
                                            color: Colors.black54,
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: Offset(
                                                0, 2), // changes position of shadow
                                          ),
                                          ],
                                        ),
                                        child: Text(
                                          'testing some text from driver  text from driver ',
                                          style: TextStyle(color: Colors.white, fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ),

                                ),

                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 3 / 5,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        padding: EdgeInsets.all(14),
                                        decoration: BoxDecoration(
                                          color: Color(0xff02A702),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),

                                          boxShadow: [ BoxShadow(
                                            color: Colors.black54,
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: Offset(
                                                0, 2), // changes position of shadow
                                          ),
                                          ],
                                        ),
                                        child: Text(
                                          'testing some text from driver  text from driver ',
                                          style: TextStyle(color: Colors.white, fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ),

                                ),

                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 3 / 5,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        padding: EdgeInsets.all(14),
                                        decoration: BoxDecoration(
                                          color: Color(0xff02A702),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),

                                          boxShadow: [ BoxShadow(
                                            color: Colors.black54,
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: Offset(
                                                0, 2), // changes position of shadow
                                          ),
                                          ],
                                        ),
                                        child: Text(
                                          'testing some text from driver  text from driver ',
                                          style: TextStyle(color: Colors.white, fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ),

                                ),

                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 3 / 5,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        padding: EdgeInsets.all(14),
                                        decoration: BoxDecoration(
                                          color: Color(0xff02A702),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),

                                          boxShadow: [ BoxShadow(
                                            color: Colors.black54,
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: Offset(
                                                0, 2), // changes position of shadow
                                          ),
                                          ],
                                        ),
                                        child: Text(
                                          'testing some text from driver  text from driver ',
                                          style: TextStyle(color: Colors.white, fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ),

                                ),

                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 3 / 5,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        padding: EdgeInsets.all(14),
                                        decoration: BoxDecoration(
                                          color: Color(0xff02A702),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),

                                          boxShadow: [ BoxShadow(
                                            color: Colors.black54,
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: Offset(
                                                0, 2), // changes position of shadow
                                          ),
                                          ],
                                        ),
                                        child: Text(
                                          'testing some text from driver  text from driver ',
                                          style: TextStyle(color: Colors.white, fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ),

                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),




              Positioned(
                bottom: -10,
                left: 0.0,
                height: MediaQuery.of(context).size.height*1/4,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Positioned(
                      bottom: 0,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width/4,

                                  child: Divider(
                                    thickness: 1,
                                    color: Colors.black,
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(right:8.0, left: 8.0),
                                  child: Text('Quick messages'),
                                ),
                                SizedBox(
                                  width:  MediaQuery.of(context).size.width/4,
                                  child: Divider(
                                    thickness: 1,
                                    color: Colors.black,

                                  ),
                                ),
                              ],

                            ),
                          ),
                        0


                        ],
                      ),

                    ),
                  ],
                ),
              )








            ],
          ),
        ),
      ),
    );
  }
}

