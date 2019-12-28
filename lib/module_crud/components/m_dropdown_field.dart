import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MDropdownField extends StatefulWidget{
  Function(dynamic) onChanged;
  String title;
  dynamic selected;
  List<DropdownMenuItem<dynamic>> items;

  MDropdownField({@required this.items,this.onChanged,this.title="",this.selected});

  @override
  _MDropdownFieldState createState() => _MDropdownFieldState();

}

class _MDropdownFieldState extends State<MDropdownField>{
  dynamic selected;

  @override
  void initState() {
    selected = widget.selected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    

    return Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(color:Colors.grey,width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(5))
            ),
            child:
              Row(
                children:<Widget>[
                  Expanded(
                    flex:1,
                    child:Text(widget.title+":"),
                  ),
                  Expanded(
                    flex:3,
                    child:
                      DropdownButton(
                        items: widget.items,
                        value: selected,
                        onChanged: (_newValue){
                          setState(() {
                            selected=_newValue;
                          });
                          if(widget.onChanged!=null){
                            widget.onChanged(_newValue);
                          }
                        },
                      )
                  )
                ]
              )
          );
  }

}