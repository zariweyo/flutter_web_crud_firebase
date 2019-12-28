import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class McheckField extends StatefulWidget{

  Function(bool) onChanged;
  String title;
  IconData icon;
  TextInputType keyboardType;
  bool value;
  bool enabled;

  McheckField({this.onChanged,this.title="", this.icon=Icons.input, this.value, this.keyboardType=TextInputType.text, this.enabled=true});

  @override
  _McheckFieldState createState() => _McheckFieldState();

}

class _McheckFieldState extends State<McheckField>{

  bool enabled;

  @override
  initState(){
    enabled = widget.value;
    super.initState();
  }

  _onChanged(bool _value){
    if(widget.onChanged!=null){
      widget.onChanged(_value);
    }
    setState(() {
      enabled = _value;
    });
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
            child: Switch(
              onChanged: widget.enabled?_onChanged:null,
              value: enabled,
              activeColor: Colors.white,
              activeTrackColor: Colors.green,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.grey
            ),
          )
        ]
      )
    );
  }

}