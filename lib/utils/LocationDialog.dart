import 'package:flutter/material.dart';
import 'package:public_unity_app/Screens/NewReportIncident.dart';
import 'package:public_unity_app/Screens/ReportIncident.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LocationDialog extends StatefulWidget {
  @override
  _LocationDialogState createState() => _LocationDialogState();
}

class _LocationDialogState extends State<LocationDialog>
    with SingleTickerProviderStateMixin {
  PermissionStatus _status;

  @override
  void initState() {
    runFirst();
    super.initState();
  }

  runFirst() async {
    // var isEnabled = await Permission.locationWhenInUse.serviceStatus.isEnabled;
    await Permission.locationWhenInUse.status.then(_updateStatus);


    if (_status.toString() == PermissionStatus.granted.toString()) {
       Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewReportIncident()));
      //Navigator.of(context).pushNamed('/NewReportIncident');

      //FocusScope.of(this.context).requestFocus();

    }
    else {
      await _requestPerms();

      if (_status.toString() == PermissionStatus.granted.toString()) {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewReportIncident()));
      /*  Navigator.of(context).pushNamed('/NewReportIncident');
        FocusScope.of(this.context).requestFocus();*/
      }
      else {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ReportIncident()));
       /* Navigator.of(context).pushNamed('/ReportIncident');

        FocusScope.of(this.context).requestFocus();*/
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
}
