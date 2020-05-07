import 'package:flutter/material.dart';
import 'package:public_unity_app/Screens/ActivityCurrentIncidents.dart';
import 'package:public_unity_app/Screens/ActivityIncidentDetails.dart';
import 'package:public_unity_app/Screens/ReportIncident.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:public_unity_app/Screens/login.dart';
import 'package:public_unity_app/utils/firebase_auth.dart';
import 'package:public_unity_app/Models/IncidentModel.dart';
// ignore: must_be_immutable
class LocationDialog_FirstResponder extends StatefulWidget {

  IncidentModel _incident;
  LocationDialog_FirstResponder(this._incident);
  @override
  _LocationDialog_FirstResponder createState() => _LocationDialog_FirstResponder(_incident);
}

class _LocationDialog_FirstResponder extends State<LocationDialog_FirstResponder>
    with SingleTickerProviderStateMixin {
  PermissionStatus _status;
  IncidentModel _incident;

  _LocationDialog_FirstResponder(this._incident);


  @override
  void initState() {
    print("LocationDialog_FirstResponder initState called");
    super.initState();

    runFirst();

  }

  runFirst() async {
    // var isEnabled = await Permission.locationWhenInUse.serviceStatus.isEnabled;
    await Permission.locationWhenInUse.status.then(_updateStatus);


    if (_status.toString() == PermissionStatus.granted.toString()) {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => new ActivityIncidentDetails(_incident)));
    }
    else {
      await _requestPerms();

      if (_status.toString() == PermissionStatus.granted.toString()) {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => new ActivityIncidentDetails(_incident)));
      }
      else {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => new ActivityCurrentIncidents()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven ? Colors.red : Colors.green,
          ),
        );
      },
    );
  }

  Future<void> _requestPerms() async {
    Map<Permission, PermissionStatus> statuses = await
    [
      Permission.locationWhenInUse,
      Permission.locationAlways
    ].request();

    _updateStatus(statuses[Permission.locationWhenInUse]);
  }

  void _updateStatus(PermissionStatus value) {
    setState(() {
      _status = value;
    });
  }

  // ignore: missing_return
  void _navigateTo(String _blnIsFirstResponder, bool permissionGranted) {
  print("navigateTo called");
    if(permissionGranted) {
      if (_blnIsFirstResponder == "true") {

        print("navigateTo called for ActivityCurrentIncidents");
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => new ActivityCurrentIncidents()));
        //return new ActivityCurrentIncidents();
      }
      else {
        print("navigateTo called for ReportIncident");

        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => new ReportIncident()));
        //return new ReportIncident();
      }
    }
    else {
      print("navigateTo called for Login");

      AuthProvider().logOut();
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => new Login()));
      //return new Login();
    }
  }
}
