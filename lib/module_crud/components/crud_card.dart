
import 'package:flutter_web_crud_firebase/module_crud/index.dart';
import 'package:flutter/material.dart';


class CrudCard extends StatefulWidget{
  String title;
  String description;
  String description2;
  Uri image;
  double borderWidth;
  Function() onPress;
  bool pressed;
  Color backgroundcolorActive;
  Color backgroundcolor;
  Color foregroundColor;
  Color titleTextColor;
  Color textColor;
  Color borderColor;
  IconData rightIcon;
  List<IconButton> actionButtons;

  CrudCard({Key key, @required this.title,this.actionButtons, this.pressed=false, this.description, this.description2, this.onPress, this.image, this.borderWidth=1.0,
   this.backgroundcolorActive=Colors.white12, this.backgroundcolor=Colors.black26, this.titleTextColor, this.textColor,this.borderColor=Colors.white,this.rightIcon=Icons.arrow_forward_ios
   ,this.foregroundColor=Colors.white
   }):super(key:key);

  @override
  _CrudCardState createState() => _CrudCardState();

}

class _CrudCardState extends State<CrudCard>{

  Color backgroundcolor;
  Uri image;

  @override
  initState(){
    image=widget.image;
    backgroundcolor=widget.pressed?  widget.backgroundcolorActive : widget.backgroundcolor ;
    super.initState();
    
  }


  @override
  didUpdateWidget(CrudCard oldWidget){
    if(backgroundcolor!=oldWidget.backgroundcolor || image.toString()!=oldWidget.image.toString()){
      backgroundcolor=widget.pressed?  Colors.white12 : Colors.black26 ;
      image=widget.image;
    }
    if(widget.pressed != oldWidget.pressed){
      print("PRESSED");
      setState(() {
        
      });
    }
    super.didUpdateWidget(oldWidget);
  }


  _printText(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(widget.title,
              style: TextStyle(
                color:widget.titleTextColor==null?widget.foregroundColor:widget.titleTextColor,
                fontSize: 18
              ),
            ),
        widget.description!=null?Text(widget.description,
              style: TextStyle(
                color:widget.textColor==null?widget.foregroundColor:widget.textColor,
                fontSize: 15
              ),
            ):MEmpty(),
        widget.description2!=null?Text(widget.description2,
              style: TextStyle(
                color:widget.textColor==null?widget.foregroundColor:widget.textColor,
                fontSize: 15
              ),
            ):MEmpty()
      ]
    );
  }

  _printActionButtons(){
    if(widget.actionButtons==null){
      return MEmpty();
    }

    List<Widget> _widgets = new List<Widget>();
    widget.actionButtons.forEach((_actionButton){
      _widgets.add(
        Flexible(
          flex:1,
          child:Container(
            child:_actionButton
          )
        )
      );
    });

    return Expanded(
      flex:1,
      child:Column(
        children: _widgets,
      )
    );
  }


  Widget _row(){
    return Row(
        children:<Widget>[
          _printActionButtons(),
          image!=null?Expanded(
            flex:2,
            child:MImage(image: image,width: 50, height: 50, margin:EdgeInsets.all(10))
          ):MEmpty(),
          Expanded(
            flex:4,
            child:_printText()
          ),
          Expanded(
            flex:1,
            child:Icon(widget.rightIcon,
              color: widget.textColor==null?widget.foregroundColor:widget.textColor,
            )
          ),
        ]
      );
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin:EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color:backgroundcolor,
        borderRadius: BorderRadius.all(
            Radius.circular(10.0),
        ),
        border: Border.all(color: widget.borderColor, width: widget.borderWidth)
      ),
      child: FlatButton(
        onPressed: widget.onPress,
        child: _row(),
      )
    );
  }
  
}