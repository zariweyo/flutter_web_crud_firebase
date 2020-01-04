import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_web_crud_firebase/module_crud/index.dart';
import 'package:firebase/firebase.dart' as Firebase;

enum MFileType{
  EMPTY,
  UNDEFINED,
  IMAGE,
  VIDEO,
  AUDIO,
  PDF
}

class MFile implements MTableable,MEditableGroupObject{
  String id = Mfunctions.generateUuid();
  String description = "";
  Uri file = new Uri();
  int maxBytes=-1;
  String path;
  MFileType type = MFileType.EMPTY;
  List<MFileType> types = MFileType.values;

  MFile(this.path);

  static MFileType parseType(String name){
    MFileType _dev = MFileType.EMPTY;
    MFileType.values.forEach((_val){
      if(_val.toString()=="MFileType."+name){
        _dev=_val;
      }
    });

    return _dev;
  }

  Future<bool> loadFile({bool cached = true}){
    
    Completer completer = new Completer<bool>();

    if(file.toString()!=""){
      completer.complete(true);
      return completer.future;
    }
    
    Firebase.StorageReference _storageRef = Firebase.storage().ref(path);
    Mfunctions.pathFileLoadFromStorage(_storageRef,cached: cached).then((_pathImageResolved){
      
      if(_pathImageResolved!=null && _pathImageResolved!=""){
        file = Uri.parse(_pathImageResolved);
        completer.complete(true);
      }else{
        completer.complete(false);
      }
    })
    .catchError((err){
      completer.completeError(err);
    });

    return completer.future;
  }

  settypeByMimeString(String _mime){
    if(_mime.startsWith("video/")){
    //  type = MFileType.VIDEO;
    }else if(_mime.startsWith("image/")){
      type = MFileType.IMAGE;
    }else if(_mime.startsWith("application/pdf")){
      type = MFileType.PDF;
    }else if(_mime.startsWith("audio/")){
    //  type = MFileType.AUDIO;
    }else{
      print(_mime);
      type = MFileType.UNDEFINED;
    }
  }

  fromMap(Map<String,dynamic> _map){
    if(_map['description']==null || !(_map['description'] is String)){
      return;
    }
    description = _map['description'];
    if(_map['type']!=null) type= MFile.parseType(_map['type']);

    if(_map['path']!=null) {
      path = _map['path'];
    }
    if(_map['id']!=null) {
      id = _map['id'];
    }
  }

  toMap(){
    Map<String,dynamic> _map = new Map<String,dynamic>();
    _map['description'] = description;
    _map['path'] = path;
    _map['id'] = id;
    _map['type'] = type.toString().split(".")[1];
    return _map;
  }

  _typeToMime(MFileType _type){
    String mime = "";
    switch(_type){
      case MFileType.IMAGE:
        mime="image/*";
        break;
        
      case MFileType.VIDEO:
        mime="video/*";
        break;
      case MFileType.AUDIO:
        mime="audio/*";
        break;
        
      case MFileType.PDF:
        mime="application/pdf";
        break;
      case MFileType.UNDEFINED:
      default:
        mime = "";
    }

    return mime;
  }

  List<String> toAcceptMimes(){
    List<String> _mimes = new List<String>();
    types.forEach((_type){
      _mimes.add(_typeToMime(_type));
    });

    return _mimes;

  }


  @override
  String getDescription() {
    return "";
  }

  @override
  String getId() {
    return id;
  }

  @override
  String getTitle() {
    return description;
  }

  @override
  bool isDeleteable() {
    return true;
  }

  @override
  bool isEditable() {
    return true;
  }

  @override
  List<Widget> getTableColumns() {
    return new List<Widget>();
  }

  @override
  List<MTableableHeader> getTableHeader() {
    return List<MTableableHeader>();
  }

  @override
  Map<String,dynamic > getReflectionAttributes() {
    Map<String,dynamic> _map = new Map<String,dynamic>();
    _map['Description'] = description;
    _map['File'] = this;
    return _map;
  }

  @override
  MEditableGroupFieldExtended getReflectionExtended({String parentAttributeName, MEditableGroupFieldExtended actual}) {
    MEditableGroupFieldExtended _extended = new MEditableGroupFieldExtended();
    _extended.grid=2;
    
    Map<String,dynamic> _map = new  Map<String,dynamic>();
    _map['Description']="Description";
    _extended.groups = _map;

    return _extended;
  }

  @override
  void setReflectionValue(String attributeName, attributeValue) {
    switch(attributeName){
      case "Description":
        description=attributeValue;
        break;
      case "File":
        file=attributeValue;
        break;
    }
  }

}