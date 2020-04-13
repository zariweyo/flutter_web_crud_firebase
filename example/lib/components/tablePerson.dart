import 'package:examplecrud/components/editPerson.dart';
import 'package:examplecrud/models/person.dart';
import 'package:examplecrud/models/person_editable.dart';
import 'package:examplecrud/models/person_listable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_crud_firebase/flutter_web_crud_firebase.dart';

class TablePerson extends StatefulWidget{
  List<PersonListable> persons;

  TablePerson({
    @required this.persons
  });

  @override
  _TablePersonState createState() => _TablePersonState();
}

class _TablePersonState extends State<TablePerson>{

  _editPerson(MTableable _personLi){
    PersonEditable _personEd = new PersonEditable();
    _personEd.fromPerson(_personLi as Person);
    Navigator.push(context,
      new MaterialPageRoute(builder: (context) => new EditPerson(
        person: _personEd,
      )),
    ).then((_return){
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child:MTableManage(
        title: "Persons",
        items: widget.persons,
        editIconColor: Colors.blue,
        deleteIconColor: Colors.red,
        messageDelete: "Do you really want to delete this person?",
        titleDelete: "Delete person",
        onDelItem: (_item){
          setState(() {
            widget.persons.removeWhere((element) => _item.getId()==element.id);
          });
        },
        onEditItem: _editPerson,
        onAddItem: (){
          PersonListable _person = new PersonListable();
          _person.name="New";
          setState(() {
            widget.persons.add(_person);
          });
        },
      )
    );
  }


}