
import 'package:flutter/material.dart';

class MDecisionMessage extends StatelessWidget {
  final String infoMessage;
  final String title;
  List<MDecisionMessageOption> options;

  MDecisionMessage({this.infoMessage,this.options,this.title});

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

  printOptions(BuildContext context){
    List<Widget> _options = new List<Widget>();
    options.forEach((_option){
      _options.add(
        FlatButton(
          color: Colors.black,
              child: new Text(_option.title,
              style: TextStyle(
              ),),
              onPressed: () {
                _option.onPress(context);
              }
            )
      );
    });
    return _options;
  }

  Widget _showErrorMessage(BuildContext context) {
    if (infoMessage != null && infoMessage.length > 0) {
      
      return AlertDialog(
          title: _titleFormater(),
          content: _messageFormater(),
          actions: printOptions(context),
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

class MDecisionMessageOption{
  String title;
  Function(BuildContext) onPress;

  MDecisionMessageOption({@required this.title, @required this.onPress});

}
