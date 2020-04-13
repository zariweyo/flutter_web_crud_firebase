import 'package:flutter/material.dart';

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
  Map<String,dynamic> groups = new Map<String,dynamic>();
  Map<String,IconData> icons = new Map<String,IconData>();
  Map<String,MEditableGroupFieldExtendedType> types = new Map<String,MEditableGroupFieldExtendedType>();
  int grid=0;
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