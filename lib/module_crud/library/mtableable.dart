import 'package:flutter/material.dart';
import 'package:flutter_web_crud_firebase/module_crud/index.dart';

abstract class MTableable{
  bool isDeleteable();
  String getId();
  String getTitle();
  List<Widget> getTableColumns();
  List<MTableableHeader> getTableHeader();
  String getDescription();
  bool isEditable();
}

class MTableableImplement implements MTableable{

  String id;
  String title;
  String description;
  bool deleteable;
  bool editable;

  MTableableImplement({this.id="",this.title="",this.description="",this.deleteable=false,this.editable=false});

  @override
  String getDescription() {
    return description;
  }

  @override
  String getId() {
    return id;
  }

  @override
  String getTitle() {
    return title;
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
