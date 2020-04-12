import 'package:flutter/material.dart';
import 'package:flutter_web_crud_firebase/module_crud/index.dart';

abstract class MTableable{
  bool isDeleteable();
  String getId();
  List<Widget> getTableColumns();
  List<MTableableHeader> getTableHeader();
  bool isEditable();
}

class MTableableImplement implements MTableable{

  String id;
  bool deleteable;
  bool editable;

  MTableableImplement({this.id="",this.deleteable=false,this.editable=false});

  @override
  String getId() {
    return id;
  }

  @override
  bool isDeleteable() {
    return deleteable;
  }

  @override
  bool isEditable() {
    return editable;
  }

  @override
  List<Widget> getTableColumns() {
    return new List<Widget>();
  }

  @override
  List<MTableableHeader> getTableHeader() {
    return List<MTableableHeader>();
  }

}
