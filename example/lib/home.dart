import 'package:examplecrud/components/tablePerson.dart';
import 'package:examplecrud/controllers/personController.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PersonController personController;
  @override
  void initState() {
    personController = new PersonController(
      onChange: onChangePerson
    );
    super.initState();
  }

  onChangePerson(){
    setState(() {
      
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height-100,
        child: TablePerson(
              persons: personController.getPersonsListable(),
            ),
      ),
    );
  }
}
