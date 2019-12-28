

import 'package:flutter/material.dart';


class MErrorMessage extends StatelessWidget {
  String errorMessage="";
  dynamic Function() onPressed;
  String closeString;

  MErrorMessage({this.errorMessage,this.onPressed,this.closeString="Close"});

   Widget _messageFormater() {
     return new Text(
        errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
   }

   Widget _titleFormater() {
     return new Text(
        "ERROR",
        style: TextStyle(
            fontSize: 18.0,
            height: 1.0,
            fontWeight: FontWeight.bold),
      );
   }

  Widget _showErrorMessage(BuildContext context) {
    if (errorMessage != null && errorMessage.length > 0) {
      
      return AlertDialog(
          title: _titleFormater(),
          content: _messageFormater(),
          actions: <Widget>[
            new FlatButton(
              child: new Text(closeString,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color:Colors.black54
              ),
              ),
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
