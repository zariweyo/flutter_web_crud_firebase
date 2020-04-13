import 'dart:convert';

import 'package:examplecrud/models/person.dart';
import 'package:examplecrud/models/person_listable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PersonController{

  List<Person> persons;
  Function() onChange;

  PersonController({
    @required this.onChange
  }){
    persons = new List<Person>();
    _loadData();
  }

  _loadData() async{
    persons = new List<Person>();
    String data = await rootBundle.loadString("assets/data/persons.json");
    List<dynamic> jsonResult = json.decode(data);

    jsonResult.forEach((_map) {
      Person _person = new Person();
      _person.fromMap(_map);
      persons.add(_person);
    });

    this.onChange();

  }

  getPersonsListable(){
    List<PersonListable> personsListable = new List<PersonListable>();
    persons.forEach((_person) {
      PersonListable _pListable = new PersonListable();
      _pListable.fromPerson(_person);
      personsListable.add(_pListable);
    });
    return personsListable;
  }
}