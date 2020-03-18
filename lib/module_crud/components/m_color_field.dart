import 'package:flutter/material.dart';
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

  @override
  initState(){
    color = widget.value;
    super.initState();
  }

  _onChanged(Color _value){
    if(widget.onChanged!=null){
      widget.onChanged(_value);
    }
    setState(() {
      color = _value;
    });
  }


  _onPressed(){
    MUtilMessages.showColorDialog(context,widget.title,color,
      onChange: _onChanged
    );
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width,
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
          Container(
            margin: EdgeInsets.only(left:20),
            width: MediaQuery.of(context).size.width/10,
            child: FlatButton(
              onPressed: _onPressed,
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
          )
        ]
      )
    );
  }

}