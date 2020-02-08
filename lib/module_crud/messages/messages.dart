
import 'package:flutter/material.dart';
import 'package:flutter_web_crud_firebase/module_crud/index.dart';


class MUtilMessages
{
  static showInfoDialog(BuildContext _context, String title, String infoMessage,{VoidCallback onFinish}) {
    showDialog(
      context: _context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return new MInfoMessage(
          title: title,
          infoMessage: infoMessage,
          onPressed: () {
            if(onFinish!=null) onFinish();
            Navigator.of(context).pop();
          }

        );
      },
    );
  }

  static showConfirmDialog(BuildContext _context, String title, String confirmationMessage,{Function(BuildContext) onAccept, Function(BuildContext) onDeny}) {
    if(_context==null){
      return;
    }
    showDialog(
      context: _context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return new MConfirmationMessage(
          title: title,
          confirmationMessage: confirmationMessage,
          onAccept: () {
            
            
            Navigator.of(context).pop();
            if(onAccept!=null) onAccept(context);
          },
          onDeny: () {
            
            Navigator.of(context).pop();
            if(onDeny!=null) onDeny(context);
          },

        );
      },
    );
  }

  static showDecisionDialog(BuildContext _context, String title, String infoMessage,List<MDecisionMessageOption> options) {
    showDialog(
      context: _context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return new MDecisionMessage(
          title: title,
          infoMessage: infoMessage,
          options:options

        );
      },
    );
  }

  static showAddFieldDialog(BuildContext _context, String title, String message,{Function(BuildContext, String) onAccept, Function(BuildContext) onDeny}) {
    if(_context==null){
      return;
    }
    showDialog(
      context: _context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return new MAddFieldMessage (
          title: title,
          message: message,
          onAccept: (_data) {
            
            Navigator.of(context).pop();
            if(onAccept!=null) onAccept(context, _data);
          },
          onDeny: () {
            
            Navigator.of(context).pop();
            if(onDeny!=null) onDeny(context);
          },

        );
      },
    );
  }

  

  static showErrorDialog(BuildContext _context, String _errorMessage,{VoidCallback onFinish}) {
    if(_context==null){
      return;
    }
    if (_errorMessage != null && _errorMessage.length > 0) {
      showDialog(
        context: _context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new MErrorMessage(
            errorMessage: _errorMessage,
            onPressed: (){
              if(onFinish!=null) onFinish();
              Navigator.of(context).pop();
            },
            
          );
        },
      );
    }
  }
}