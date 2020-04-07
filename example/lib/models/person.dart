import 'package:uuid/uuid.dart';

enum PersonGender{
  male,
  female
}

class Person{
  String id="";
  String guid="";
  bool enabled=true;
  Uri picture=Uri.parse("");
  int age=0;
  String eyeColor="";
  String name="";
  PersonGender gender = PersonGender.male;
  String email = "@";
  String phone = "";
  String address = "";
  String about = "";
  double latitude = 0;
  double longitude = 0;
  List<String> tags = [];

  Person(){
    Uuid uuid = Uuid();
    id = uuid.v4();
  }

  _tagsToMap(){
    List<dynamic> _map = [];
    tags.forEach((element) {
      _map.add(element);
    });
    return _map;
  }

  _mapToTags(List<dynamic> _map){
    tags = new List<String>();
    _map.forEach((element) {
      tags.add(element);
    });

    return tags;
  }

  fromPerson(Person _p){
    fromMap(_p.toMap());
  }

  toMap(){
    Map<String,dynamic> _map = new Map<String,dynamic>();
    _map['id'] = id;
    _map['guid'] = guid;
    _map['enabled'] = enabled;
    _map['picture'] = picture.toString();
    _map['age'] = age;
    _map['eyeColor'] = eyeColor;
    _map['name'] = name;
    _map['gender'] = gender.toString().split(".")[1];
    _map['email'] = email;
    _map['phone'] = phone;
    _map['address'] = address;
    _map['about'] = about;
    _map['latitude'] = latitude;
    _map['longitude'] = longitude;
    _map['tags'] = _tagsToMap();
    return _map;
  }

  fromMap(Map<String,dynamic> _map){
    id = _map['id'];
    guid = _map['guid'];
    enabled = _map['enabled'];
    picture = Uri.parse(_map['picture']);
    age = _map['age'];
    eyeColor = _map['eyeColor'];
    name = _map['name'];
    gender = PersonGender.values.firstWhere((element) => element.toString().split(".")[1]==_map['gender']);
    email = _map['email'];
    phone = _map['phone'];
    address = _map['address'];
    about = _map['about'];
    latitude = _map['latitude'];
    longitude = _map['longitude'];
    tags = _mapToTags(_map['tags']);
  }

}
