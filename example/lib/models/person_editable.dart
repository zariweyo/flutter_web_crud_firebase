import 'package:examplecrud/models/person.dart';
import 'package:flutter_web_crud_firebase/module_crud/library/meditablegroup.dart';

class PersonEditable extends Person implements MEditableGroupObject{
  @override
  Map<String,dynamic > getReflectionAttributes() {
    Map<String,dynamic > _map = new Map<String,dynamic >();

    _map['enabled'] = enabled;
    _map['picture'] = picture;
    _map['age'] = age;
    _map['eyeColor'] = eyeColor;
    _map['name'] = name;
    _map['email'] = email;
    _map['phone'] = phone;
    _map['address'] = address;
    _map['about'] = about;
    _map['latitude'] = latitude;
    _map['longitude'] = longitude;

    return _map;

  }

  @override
  MEditableGroupFieldExtended getReflectionExtended({String parentAttributeName, MEditableGroupFieldExtended actual}) {
      MEditableGroupFieldExtended _extended = new MEditableGroupFieldExtended();
      _extended.grid = 2;

      return _extended;
    }
  
    @override
    Map<String, String> getReflectionTranslates() {
      return  new Map<String, String>();
    }
  
    @override
    void setReflectionValue(String attributeName,dynamic attributeValue) {
    
    }

}