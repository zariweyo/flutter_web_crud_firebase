import 'package:examplecrud/models/person.dart';
import 'package:examplecrud/models/person_editable.dart';
import 'package:examplecrud/models/person_listable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_crud_firebase/flutter_web_crud_firebase.dart';

class EditPerson extends StatefulWidget{
  PersonEditable person;

  EditPerson({
    @required this.person
  });

  @override
  _EditPersonState createState() => _EditPersonState();
}

class _EditPersonState extends State<EditPerson>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.all(10),
        child: MGroupField(
          mEditableGroupObject: widget.person
        )
      )
    );
  }


}