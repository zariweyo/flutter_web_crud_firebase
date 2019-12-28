
import 'package:flutter/material.dart';

class MAddFieldMessage extends StatelessWidget {
  final String message;
  final String title;
  final String hintText;
  dynamic Function(String) onAccept;
  dynamic Function() onDeny;
  String _result="";

  MAddFieldMessage({this.message,this.onAccept,this.hintText="",this.onDeny,this.title});
   
   Widget _messageFormater() {
     return Container(
       alignment: Alignment.centerLeft,
       height: 200,
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
            Text(
              message,
              style: TextStyle(
                  fontSize: 13.0,
                  height: 1.0,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(height: 10,),
            _fieldMessage()
          ]
       )
     ); 
   }

   Widget _titleFormater() {
     return new Text(
        title,
        style: TextStyle(
            fontSize: 18.0,
            height: 1.0,
            fontWeight: FontWeight.bold),
      );
   }

   changeField(String _data){
     _result = _data;
   }

   Widget _fieldMessage(){
     return TextField(
                onChanged: changeField,
                style: TextStyle(
                  color: Colors.black
                ),
                decoration: new InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                  ),
                  hintText: hintText,
                  labelText: hintText,
                  prefixIcon: new Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 16,
                  )
                ),
              );
   }

  Widget _showConformationMessage(BuildContext context) {
    if (message != null && message.length > 0) {
      
      return AlertDialog(
          title: _titleFormater(),
          content: _messageFormater(),
          actions: <Widget>[
            new FlatButton(
              child: new Icon(
                Icons.done,
                color:Colors.green
              ),
              onPressed: (){
                onAccept(_result);
              }
            ),
            new FlatButton(
              child: new Icon(
                Icons.cancel,
                color:Colors.red
              ),
              onPressed: onDeny
            ),
          ],
        );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return _showConformationMessage(context);
  }
}
