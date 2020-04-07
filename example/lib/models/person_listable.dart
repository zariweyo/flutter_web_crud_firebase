import 'package:examplecrud/models/person.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_crud_firebase/module_crud/index.dart';

class PersonListable extends Person implements MTableable {
  PersonListable():super();

  @override
  String getDescription() {
    return email;
  }

  @override
  String getId() {
    return id;
  }

  @override
  List<Widget> getTableColumns() {
    List<Widget> columns = new List<Widget>();
    columns.add(Text(email, textAlign: TextAlign.center,));
    columns.add(Text(name, textAlign: TextAlign.center));
    columns.add(Image.network(
      picture.toString(),
      height: 60,
    ));
    return columns;
  }

  @override
  List<MTableableHeader> getTableHeader() {
    List<MTableableHeader> columns = new List<MTableableHeader>();
    columns.add(MTableableHeader(
      title: "Email"
    ));
    columns.add(MTableableHeader(
      title: "Name"
    ));
    columns.add(MTableableHeader(
      title: "Picture"
    ));
    return columns;
  }

  @override
  String getTitle() {
    return name;
  }

  @override
  bool isDeleteable() {
    return true;
  }

  @override
  bool isEditable() {
    return true;
  }
  
}