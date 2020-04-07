import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_web_crud_firebase/module_crud/index.dart';

class MTextArea extends StatelessWidget{

  Function(String) onChanged;
  Function(String,int,int) onSelection;
  String hintText;
  IconData icon;
  String value;
  TextEditingController _textEditingController;
  bool enabled;
  int minLines;
  int maxLines;

  int _initSelect = -1;
  TextSelection _lastSelection;

  MTextArea({this.onChanged,this.hintText="",this.value, this.enabled=true, this.onSelection,this.minLines=5, this.maxLines=10}){
    _textEditingController = new TextEditingController();
    _textEditingController.text = value;

    _textEditingController.addListener(_textEditingControllerListener);
   

  }


  _textEditingControllerListener(){
    if(_lastSelection==null){
      _lastSelection = _textEditingController.selection;
    }

    

    if(_textEditingController.selection.start != _textEditingController.selection.end){
      

      if(onSelection!=null){
        onSelection(_textEditingController.text,_textEditingController.selection.start,_textEditingController.selection.end);
      }
    }

  }

  _printTextField(){
    return TextField(
        textAlign: TextAlign.left,
        textAlignVertical: TextAlignVertical.top,
        keyboardType: TextInputType.multiline,

        enabled: enabled,
        minLines: minLines,
        maxLines: null,
        controller: _textEditingController,
        onChanged: onChanged,
        enableInteractiveSelection: true,
        
        decoration: new InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
          hintText: hintText,
          labelText: hintText
        ),
      );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: _printTextField()
    );
  }

}