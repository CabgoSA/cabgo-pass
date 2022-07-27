import 'package:flutter/cupertino.dart';

class ProviderDetails{
  final String providerID;
  final String fullName;
  final String picture;
  final String rating;
  final String price;
  final String serviceImage;
  final String serviceName;
  ProviderDetails({@required this.providerID, @required this.fullName, @required this.picture,
                   @required this.rating, @required this.price, @required this.serviceImage,
                   @required this.serviceName,});
}