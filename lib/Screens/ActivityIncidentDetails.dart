import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:public_unity_app/Screens/ActivityCurrentIncidents.dart';
import 'package:public_unity_app/constants/Constants.dart';
import 'package:public_unity_app/drawer/MainDrawer.dart';
import 'package:public_unity_app/Models/IncidentModel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

class ActivityIncidentDetails extends StatefulWidget {
  IncidentModel _incident;

  ActivityIncidentDetails(this._incident);

  @override
  _ActivityIncidentDetailsState createState() =>
      _ActivityIncidentDetailsState(_incident);
}

class _ActivityIncidentDetailsState extends State<ActivityIncidentDetails> {
  IncidentModel _incident;
  double latitudeDoubleValue;
  double longitudeDoubleValue;
  static PermissionStatus _status;

  var _scaffoldKey = GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _controller = Completer();

  _ActivityIncidentDetailsState(this._incident);



  static Future<void> openMap(String incidentAddress) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query={$incidentAddress}';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }


  @override
  void initState() {
    //checkLocationPermission();
    latitudeDoubleValue = double.tryParse(_incident.latitude);
    longitudeDoubleValue = double.tryParse(_incident.longitude);

    print('_incident.latitude:' +_incident.latitude);
    print('_incident.longitude:' +_incident.longitude);

    Marker mMarker = Marker(
      markerId: MarkerId('demo'),
      position: LatLng(latitudeDoubleValue, longitudeDoubleValue),
    );
    _markers.add(mMarker);
    super.initState();
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(latitudeDoubleValue, longitudeDoubleValue),
      zoom: 12.0,
    )));
  }

  Set<Marker> _markers = Set();


  checkLocationPermission() async {
    // var isEnabled = await Permission.locationWhenInUse.serviceStatus.isEnabled;
    await Permission.locationWhenInUse.status.then(_updateStatus);


    if (_status.toString() != PermissionStatus.granted.toString()) {
      await _requestPerms();

      if (_status.toString() == PermissionStatus.granted.toString()) {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => new ActivityCurrentIncidents()));
      }
    }
  }

  void _updateStatus(PermissionStatus value) {
    setState(() {
      _status = value;
    });
  }

  Future<void> _requestPerms() async {
    Map<Permission, PermissionStatus> statuses = await
    [
      Permission.locationWhenInUse,
      Permission.locationAlways
    ].request();

    _updateStatus(statuses[Permission.locationWhenInUse]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          'Public Unity Safety',
          style: TextStyle(
            fontSize: 25.0,
          ),
        ),
        backgroundColor: Constants.redColor,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState.openEndDrawer();
            },
          ),
        ],
      ),
      //body: _getBody(),
      body: SingleChildScrollView(child: _getBody()),

      endDrawer: MainDrawer(),
    );
  }

  _getBody() {
    return Center(
      child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.all(32.0),
        children: <Widget>[
          Text(
            'Incidents Details',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            color: Constants.lightRed,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 32.0,
                ),
                Text(
                  _incident.address,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Text(
                  '${_incident.time} - ${_incident.incident}',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Emergency Description: ',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Text(_incident.description),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Patient Breathing: ',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Text(_incident.breathing),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Patient Conscious: ',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Text(_incident.conscious),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Patient Bleeding Heavily: ',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Text(_incident.bleedingHeavily),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Medical Emergency Type: ',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Text(_incident.incident),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            height: 250.0,
            child: GoogleMap(
              markers: _markers,
              mapType: MapType.normal,
              //initialCameraPosition: _kGooglePlex,
              initialCameraPosition: CameraPosition(
                target: LatLng(latitudeDoubleValue, longitudeDoubleValue),
                zoom: 12.4746,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                _goToTheLake();
              },
            ),
          ),
        ],
      ),
    );
  }


}
