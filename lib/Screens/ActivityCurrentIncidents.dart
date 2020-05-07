import 'package:flutter/material.dart';
import 'package:public_unity_app/constants/Constants.dart';
import 'package:public_unity_app/drawer/MainDrawer.dart';
import 'package:public_unity_app/Models/IncidentModel.dart';
import 'package:public_unity_app/screens/ActivityIncidentDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ActivityCurrentIncidents extends StatefulWidget {
  @override
  _ActivityCurrentIncidentsState createState() =>
      _ActivityCurrentIncidentsState();
}

class _ActivityCurrentIncidentsState extends State<ActivityCurrentIncidents> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  List<IncidentModel> _incidentList = List();

    void _getAllActiveIncidents() async{
      CollectionReference _documentRef =  Firestore.instance.collection("ReportedIncidents");
      List<IncidentModel> _incidentListDB = List();

      await _documentRef.getDocuments().then((ds){
        if(ds!=null){
          ds.documents.forEach((incidentFields){
            var _address='';
            var _time='';
            var _incident='';
            var _description='';
            var _breathing='';
            var _conscious='';
            var _bleedingHeavily='';
            var _latitude='';
            var _longitude='';

            incidentFields.data.forEach((String s, dynamic d){

              if(s.toString() == 'Address')
                _address = d.toString();
              if(s.toString() == 'Time')
                _time = d.toString();
              if(s.toString() == 'IncidentType')
                _incident = d.toString();
              if(s.toString() == 'Description')
                _description = d.toString();
              if(s.toString() == 'Breathing')
                _breathing = d.toString();
              if(s.toString() == 'Conscious')
                _conscious = d.toString();
              if(s.toString() == 'BleedingHeavily')
                _bleedingHeavily = d.toString();
              if(s.toString() == 'Latitude')
                _latitude = d.toString();
              if(s.toString() == 'Longitude')
                _longitude = d.toString();

            });

            print('_latitude '+_latitude);
            print('_longitude '+_longitude);
            _incidentListDB.add(new IncidentModel(_address, _time, _incident, _description, _breathing, _conscious, _bleedingHeavily, _latitude, _longitude));
          });
        }
      });

      setState(() {
        _incidentList.addAll(_incidentListDB);
        print(_incidentListDB.length);
        print(_incidentList.length);

      });

    }
  @override
  void initState() {
    _getAllActiveIncidents ();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
      body: _getBody(),
      endDrawer: MainDrawer(),
    );
  }

  _getBody() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 32.0,
          ),
          Text(
            'Current Incidents',
            style: TextStyle(
              fontSize: 30.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(top: 24.0),
              children: _incidentList.map((IncidentModel incident) {
                return Container(
                  margin: EdgeInsets.only(bottom: 30.0),
                  height: 100.0,
                  color: Constants.lightRed,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child:  Text(
                                incident.address,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 1.0,
                            ),
                            Text(
                              '${incident.time} - ${incident.incident}',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: Icon(
                            Icons.location_on,
                            color: Constants.redColor,
                            size: 50.0,
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return ActivityIncidentDetails(incident);
                            }));
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
