import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

abstract class MEditableGroupObject{
  Map<String,dynamic> getReflectionAttributes();
  MEditableGroupFieldExtended getReflectionExtended({String parentAttributeName, MEditableGroupFieldExtended actual});
  void setReflectionValue(String attributeName,dynamic attributeValue);

  Map<String,String> getReflectionTranslates(){
    return new Map<String,String>();
  }
}

enum MEditableGroupFieldExtendedType{
  NONE,
  TEXTAREA
}

class MEditableGroupFieldExtended{
  MEditableGroupFieldCDN cdn = new MEditableGroupFieldCDN();
  Map<String,dynamic> groups = new Map<String,dynamic>();
  Map<String,IconData> icons = new Map<String,IconData>();
  Map<String,MEditableGroupFieldExtendedType> types = new Map<String,MEditableGroupFieldExtendedType>();
  int grid=0;
}

enum MEditableGroupFieldCDNImageMode{
  STRING,
  BASE64
}

class MEditableGroupFieldCDN{
  Uri cdnUrl = Uri.parse("");
  String replaceKey = "";
  MEditableGroupFieldCDNImageMode imageMode = MEditableGroupFieldCDNImageMode.BASE64;
  Uri getDownloadUri(Uri remoteUri){
    String _remotePath = remoteUri.toString();
    if(imageMode == MEditableGroupFieldCDNImageMode.BASE64){
      List<int> bytes =  utf8.encode(_remotePath);
      _remotePath = base64Encode(bytes);
    }

    print(cdnUrl.toString());
    print(replaceKey);
    print(_remotePath);

    String cdnString = cdnUrl.toString().replaceAll(replaceKey, _remotePath);

    print(cdnString);

    return Uri.parse(cdnString);
  }
}

class MEditableGroupFieldListItem{
  String name;
  dynamic value;
  MEditableGroupFieldListItem({@required this.name, @required this.value});
}

class MEditableGroupFieldList{
  List<MEditableGroupFieldListItem> mGroupFieldListItem = new List<MEditableGroupFieldListItem>();
  dynamic selected=null;
  MEditableGroupFieldList({this.selected});
  addItem(String name,dynamic value){
    mGroupFieldListItem.add(
      MEditableGroupFieldListItem(
        name:name,
        value:value
      )
    );
  }
  getDefaultSelected(){
    if(mGroupFieldListItem.length>0){
      selected = mGroupFieldListItem.first.value;
      return selected;
    }else{
      selected = null;
      return null;
    }
  }
}