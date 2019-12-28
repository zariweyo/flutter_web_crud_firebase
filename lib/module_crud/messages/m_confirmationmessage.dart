
import 'package:flutter/material.dart';

class MConfirmationMessage extends StatelessWidget {
  final String confirmationMessage;
  final String title;
  dynamic Function() onAccept;
  dynamic Function() onDeny;

  MConfirmationMessage({this.confirmationMessage,this.onAccept,this.onDeny,this.title});

   Widget _messageFormater() {
     return new Text(
        confirmationMessage,
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

  Widget _showConformationMessage(BuildContext context) {
    if (confirmationMessage != null && confirmationMessage.length > 0) {
      
      return AlertDialog(
          title: _titleFormater(),
          content: _messageFormater(),
          actions: <Widget>[
            new FlatButton(
              child: new Icon(
                Icons.done,
                color:Colors.green
              ),
              onPressed: onAccept
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
