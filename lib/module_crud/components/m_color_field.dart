import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_crud_firebase/module_crud/components/m_text_field.dart';
import 'package:flutter_web_crud_firebase/module_crud/index.dart';
import 'package:flutter_web_crud_firebase/module_crud/messages/messages.dart';

class MColorField extends StatefulWidget{

  Function(Color) onChanged;
  String title;
  IconData icon;
  TextInputType keyboardType;
  Color value;
  bool enabled;

  MColorField({
    this.onChanged,
    this.title="", 
    this.icon=Icons.input, 
    this.value=Colors.black, 
    this.keyboardType=TextInputType.text, 
    this.enabled=true
  });

  @override
  _MColorFieldState createState() => _MColorFieldState();

}

class _MColorFieldState extends State<MColorField>{

  Color color;
  String colorSt="";
  TextEditingController _controller;

  @override
  initState(){
    color = widget.value;
    colorSt = color.value.toRadixString(16).toUpperCase();

    _controller=new TextEditingController();
    _controller.text = colorSt;
    _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));

    super.initState();
  }

  _onChanged(Color _value){
    if(widget.onChanged!=null){
      widget.onChanged(_value);
    }
    setState(() {
      color = _value;
      colorSt = color.value.toRadixString(16).toUpperCase();
      
    });
  }


  _onPressed(){
    MUtilMessages.showColorDialog(context,widget.title,color,
      onChange: (_col){
        _controller.text = colorSt;
        _onChanged(_col);
      }
    );
  }

  _buttonColor(){
    return Container(
      margin: EdgeInsets.only(left:20),
      width: MediaQuery.of(context).size.width/10,
      child: InkWell(
        onTap: _onPressed,
        child: Container(
          width:40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(),
            color: color
          ),
        ),
      ),
    );
  }

  Color _fromHex(String hexString) {
    /*
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
    */
    return Color(int.parse(hexString, radix: 16));

  }

  _textField(){
    return Container(
      width:50,
      margin:EdgeInsets.only(left:10),
      child:TextFieldBIS(
        
        controller: _controller,
        onChanged: (_newValue){
          RegExp onlyHex = RegExp(r"[0-9A-F]");
          if(onlyHex.hasMatch(_newValue)){
            colorSt = _newValue;
            color = _fromHex(colorSt);
            _onChanged(color);
          }

          
        },
      )
    );
  }

  _field(){
    return Container(
      width:300,
      child:Row(
        children: <Widget>[
          Expanded(
            flex:1,
            child: _buttonColor(),
          ),
          Expanded(
            flex:4,
            child: _textField(),
          )
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color:Colors.grey,width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(5))
      ),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:<Widget>[
          Container(
            margin:EdgeInsets.only(left:5),
            child:Text(widget.title),
          ),
          _field()
        ]
      )
    );
  }

}