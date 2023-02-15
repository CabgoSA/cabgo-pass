import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:cabgo/states/app_state.dart';

class CarsCardList extends StatefulWidget {
  @override
  _CarsCardListState createState() => _CarsCardListState();
}

class _CarsCardListState extends State<CarsCardList> {
  late List<dynamic> products;
  var isLoading = false;
  int _selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  _fetchProducts() async {
    setState(() {
      isLoading = true;
    });


    final response = await http.get(Uri.parse("https://fakestoreapi.com/products"));
    if (response.statusCode == 200) {
      products = json.decode(response.body);
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load trips');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          :   Row(
                  mainAxisSize: MainAxisSize.max,
                  //services here!!!!!

                  children: [
                    for (var service in appState.services)
                      InkWell(
                        onTap: () async {
                          try {
                            bool result =
                                await InternetConnectionChecker().hasConnection;
                            if (result) {
                              appState.setService(service['id']);
                              setState(() {
                                appState.selectedService == service['id']
                                    ? appState.currentColor
                                    : Colors.white;
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                appState.SnackBarCaller(
                                    "No internet connection!"),
                              );
                            }
                          } catch (_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              appState.SnackBarCaller("There was problem!"),
                            );
                          }
                        },
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                          child: Container(
                            decoration: BoxDecoration(
                                color:
                                    (appState.selectedService == service['id'])
                                        ? appState.currentColor
                                        : Colors.white, // Here we checked!
                                border: Border.all(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 5),
                                  child: Text(
                                    'R' +
                                        (appState.dp(
                                                distance *
                                                    double.parse(
                                                        service['price']),
                                                3))
                                            .toString(), // estimated price of ride
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
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 5, 0, 0),
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
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 5, 0, 0),
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
                        ),
                      ), // 1
                  ],

                  //  end services here!!!!!!!!
                ),
    );
  }
}

