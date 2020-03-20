import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MTextField extends StatelessWidget{

  Function(String) onChanged;
  String hintText;
  IconData icon;
  TextInputType keyboardType;
  String value;
  TextEditingController _controller;
  bool enabled;
  List<TextInputFormatter> inputFormatters;
  Function() onPressEnter;
  bool obscureText;

  MTextField({this.onChanged,this.hintText="",this.obscureText=false, this.inputFormatters, this.onPressEnter, this.icon=Icons.input, this.value, this.keyboardType=TextInputType.text, this.enabled=true}){
    _controller=new TextEditingController();
    _controller.text = value;
    _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
    
    if(inputFormatters==null){
      inputFormatters=[];
    }
  }

  _printTextField(){
    return TextField(
        obscureText: obscureText,
        inputFormatters: inputFormatters,
        enabled: enabled,
        controller: _controller,
        keyboardType: keyboardType,
        onChanged: onChanged,
        decoration: new InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
          hintText: hintText,
          labelText: hintText,
          prefixIcon: new Icon(
            icon,
            color: Colors.white70,
          )
        ),
      );
  }

  _printKeyListener(){
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (event) {
        if (event.runtimeType == RawKeyDownEvent &&
          (event.logicalKey.keyId == 54)) {
            this.onPressEnter();
          } 
      },
      child: _printTextField()
    );
  }

  _printChild(){
    if(this.onPressEnter!=null){
      return _printKeyListener();
    }

    return _printTextField();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: _printChild()
    );
  }

}