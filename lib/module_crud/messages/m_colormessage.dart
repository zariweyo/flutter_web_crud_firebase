

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';


class MColorMessage extends StatelessWidget {
  String title="";
  Color value;
  dynamic Function(Color) onChange;
  dynamic Function() onPressed;
  String closeString;

  MColorMessage({
    this.title="Color",
    this.value=Colors.black,
    this.onChange,
    this.onPressed,
    this.closeString="Close"});

   Widget _messageFormater() {
     return SingleChildScrollView(
        child: ColorPicker(
          pickerColor: value,
          onColorChanged: onChange,
          showLabel: true,
          pickerAreaHeightPercent: 0.8,
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

  Widget _showMessage(BuildContext context) {

      
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

  }

  

  @override
  Widget build(BuildContext context) {
    return _showMessage(context);
  }
}
