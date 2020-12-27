import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppConstants{


  static final String API_SERVICE_LINK = "http://esptiles.imperoserver.in/api/API/Product";
  static final String DashBoard = API_SERVICE_LINK + "/DashBoard";
  static final String ProductList = API_SERVICE_LINK + "/ProductList";

  static final String CategoryId = "CategoryId";
  static final String DeviceManufacturer = "DeviceManufacturer";
  static final String DeviceModel = "DeviceModel";
  static final String DeviceToken = "DeviceToken";
  static final String PageIndex = "PageIndex";




  static showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Ok"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("No Internet"),
      content: Text("Internet connection is not available"),
      actions: [
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  static Future<bool> checkInternetConnectivity() async {

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

}