class IncidentModel {
  String _address;
  String _time;
  String _description;
  String _breathing;
  String _conscious;
  String _bleedingHeavily;
  String _incident;
  String _latitude;
  String _longitude;

  String get address => _address;

  set address(address) => this._address = address;

  String get time => _time;

  set time(String value) {
    _time = value;
  }

  IncidentModel(this._address, this._time, this._incident, this._description,
      this._breathing, this._conscious, this._bleedingHeavily, this._latitude, this._longitude);

  String get incident => _incident;

  set incident(String value) {
    _incident = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get breathing => _breathing;

  set breathing(String value) {
    _breathing = value;
  }

  String get conscious => _conscious;

  set conscious(String value) {
    _conscious = value;
  }

  String get bleedingHeavily => _bleedingHeavily;

  set bleedingHeavily(String value) {
    _bleedingHeavily = value;
  }


  String get latitude => _latitude;

  set latitude(String value) {
    _latitude = value;
  }

  String get longitude => _longitude;

  set longitude(String value) {
    _longitude = value;
  }
}
