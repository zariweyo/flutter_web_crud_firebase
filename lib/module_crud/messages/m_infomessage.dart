
import 'package:flutter/material.dart';

class MInfoMessage extends StatelessWidget {
  final String infoMessage;
  final String title;
  dynamic Function() onPressed;

  MInfoMessage({this.infoMessage,this.onPressed,this.title});

   Widget _messageFormater() {
     return new Text(
        infoMessage,
        textAlign: TextAlign.justify,
        style: TextStyle(
            fontSize: 13.0,
            height: 1.0,
            fontWeight: FontWeight.w300),
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

  Widget _showErrorMessage(BuildContext context) {
    if (infoMessage != null && infoMessage.length > 0) {
      
      return AlertDialog(
          title: _titleFormater(),
          content: _messageFormater(),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Accept",
              style: TextStyle(
                color:Colors.black54
              ),),
              onPressed: onPressed
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
    return _showErrorMessage(context);
  }
}
