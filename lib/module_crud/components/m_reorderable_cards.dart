
import 'package:flutter/material.dart';
import 'package:flutter_web_crud_firebase/module_crud/index.dart';

class MReorderableCards extends StatefulWidget {
  @required List<MReorderableObject> reorderableObjects;
  Function(MReorderableObject) onItemPressed;
  Function(MReorderableObject) onEditPressed;
  Function(MReorderableObject) onDelete;
  Function(MReorderableObject) onPriorityChange;
  Function() onAdd;

  String deleteTitleMessage;
  String deleteBodyMessage;
  String notEmptyTitleMessage;
  String notEmptyBodyMessage;
  String title;
  bool canDrag;

  Color cardTitleColor;
  Color cardTextColor;
  Color cardBackgroundColor;
  Color cardBorderColor;

  Color headerTextColor;
  Color headerBackgroundColor;

  Color backgroundColor;

  MReorderableCards({Key key,
    this.reorderableObjects,
    this.onItemPressed,
    this.onEditPressed,
    this.deleteTitleMessage="",
    this.deleteBodyMessage="",
    this.notEmptyTitleMessage="",
    this.notEmptyBodyMessage="",
    this.onPriorityChange,
    this.onAdd,
    this.onDelete,
    this.canDrag=true,
    this.title="",
    this.cardTitleColor=Colors.black,
    this.cardTextColor=Colors.black,
    this.cardBackgroundColor=Colors.white,
    this.cardBorderColor=Colors.black,
    this.headerTextColor=Colors.white,
    this.headerBackgroundColor=Colors.black,
    this.backgroundColor=Colors.white,
  }
  ) : super(key: key);

  @override
  _MReorderableCardsState createState() => _MReorderableCardsState();
}

class _MReorderableCardsState extends State<MReorderableCards> {

 // bool loading=true;
  List<String> initNameInPage=[];
  String objectIdPressed="";
  List<MReorderableObject> reorderableObjects;
  List<CrudCard> cards = new List<CrudCard>();
  String title="";


  bool isInDrag=false;

  @override
  void initState() {
    title = widget.title;
    reorderableObjects=widget.reorderableObjects;
    reLoadCards();
    super.initState();
  }

  @override
  didUpdateWidget(MReorderableCards oldWidget){
    reorderableObjects=widget.reorderableObjects;
    reLoadCards();
    super.didUpdateWidget(oldWidget);
  }

  _objectSorted(){
    reorderableObjects.sort((_objA,_objB){
      return _objA.priority.compareTo(_objB.priority);
    });
  }

  CrudCard _printCrudCard(MReorderableObject _object ){
    return CrudCard(
            key:Key(_object.reorderableId()),
            rightIcon: _object.reorderableIcon(),
            title: _object.reorderableTitle(),
            description: _object.reorderableDescription(),
            description2: _object.reorderableDescription2(),
            image: _object.reorderableImage(),
            pressed: objectIdPressed==_object.reorderableId(),
            titleTextColor: _object.enabled? widget.cardTitleColor:Colors.grey,
            textColor: _object.enabled? widget.cardTextColor:Colors.grey,
            backgroundcolor: widget.cardBackgroundColor,
            borderColor: widget.cardBorderColor,
            borderWidth: 1.0,
            backgroundcolorActive: Color(0xFF7AC2EC),
            onPress: (){
              if(objectIdPressed==_object.reorderableId()){
                objectIdPressed="";
                if(widget.onItemPressed!=null) widget.onItemPressed(null);
              }else{
                objectIdPressed=_object.reorderableId();
                if(widget.onItemPressed!=null) widget.onItemPressed(_object);
              }

              

              setState(() {
                objectIdPressed=objectIdPressed;
              });
              
            },
          );
  }



  List<Widget> reLoadCards(){
    cards = new List<CrudCard>();
    _objectSorted();
    
    reorderableObjects.forEach((_object){
      cards.add(
        _printCrudCard(_object)
      );
    });

  }

  changePressedCard(){
    int i = 0;
    reorderableObjects.forEach((_object){
      if(objectIdPressed==_object.reorderableId() || cards[i].pressed==true){
        cards[i]=_printCrudCard(_object);
      }else{
        cards[i].pressed = false;
      }
      
      i++;
    });
  }

  Widget dataBody(){
    //changePressedCard();


    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color: widget.backgroundColor,
        border: Border.all(color: widget.cardBorderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 5),
          ),
        ],
      ),
      
      
      child:MReorderableListView(
        header: _printHeader(),
        sizeHeader: 60,
        onReorder: reorderObjects,
        onStartDrag: (){
          setState(() {
            isInDrag=true;
          });
        },
        onOffsetOut: (int _index,Offset _offset){
          _detectDelete(_index,_offset);
          setState(() {
            isInDrag=false;
          });
        },
        dragDirection: Axis.vertical,
        children: cards,
        colorOnDrag: Colors.transparent,//Colors.blueGrey[400],
        canDrag: widget.canDrag,
      )
      
    );
  }

    

    List<Widget> _printEditableZone(){
      MReorderableObject _objectSelected = reorderableObjects.where((_obj) => _obj.reorderableId() == objectIdPressed).first;
      if(_objectSelected==null){
        return [MEmpty()];
      }

      return <Widget>[
        widget.onEditPressed!=null?IconButton(
          icon:Icon(Icons.edit, color: widget.headerTextColor),
          iconSize: 30,
          onPressed: (){
            if(widget.onEditPressed!=null) widget.onEditPressed(_objectSelected);
          },
        ):MEmpty(),
        widget.onDelete!=null?IconButton(
          icon:Icon(Icons.delete_forever, color: widget.headerTextColor),
          iconSize: 30,
          onPressed: (){
            print("DEL " + _objectSelected.reorderableTitle());
            _objectSelected.isDeleteable().then((_isDeleteable){
              if(_isDeleteable){
                UtilMessages.showConfirmDialog(context, widget.deleteTitleMessage, 
                  widget.deleteBodyMessage
                  ,onAccept: (_context){
                    if(widget.onDelete!=null) widget.onDelete(_objectSelected);
                    setState(() {
                      reorderableObjects.removeWhere((_obj)=> _obj.reorderableId()==_objectSelected.reorderableId());
                      reLoadCards();
                      objectIdPressed="";
                    });
                  }
                );
              }else{
                UtilMessages.showInfoDialog(context, widget.notEmptyTitleMessage, 
                  widget.notEmptyBodyMessage
                );
              }
            });
          },
        ):MEmpty()
      ];
    }

    List<Widget> _printZoneNew(){
      return <Widget>[
        widget.onAdd!=null?IconButton(
          icon:Icon(Icons.add_circle, color: widget.headerTextColor),
          iconSize: 30,
          onPressed: (){
            
            if(widget.onAdd!=null) widget.onAdd();
            
          },
        ):MEmpty()
      ];
    }

    Widget _printTitle(){
      return Expanded(
        flex:1,
        child:Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: widget.headerTextColor,
            fontSize: 20
          ),
        )
      );
    }

    _printHeader(){

      List<Widget> _widgets = new List<Widget>();
      _widgets.add(_printTitle());
      if(objectIdPressed!=""){
        _widgets.addAll(_printEditableZone());
      }else{
        _widgets.addAll(_printZoneNew());
      }
      
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: widget.headerBackgroundColor,
          //border: Border.all(color:Colors.white),
        ),
        alignment: Alignment.centerRight,
        width: MediaQuery.of(context).size.width,
        
        child:Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: _widgets
        ),
        height: 60,
      );
    }

    _detectDelete(int index,Offset _offset){
      print(_offset);
      if(_offset.dy<100){
        print("Delete "+reorderableObjects[index].reorderableTitle());
      }
    }

    reorderObjects(int start, int current){
      print("$start - $current");
      MReorderableObject _objectToChange = reorderableObjects[start];
      List<MReorderableObject> _objectsReordered = new List<MReorderableObject>();
      bool inserted=false;
      reorderableObjects.forEach((_object){
        
        if(_objectToChange.reorderableId()==_object.reorderableId()){
          return;
        }
        if(_objectsReordered.length==current){
          

          _objectToChange.reorderableNewPriority(_objectsReordered.length);

          _objectsReordered.add(_objectToChange);
          inserted=true;
        }
        
        _object.reorderableNewPriority(_objectsReordered.length);
        _objectsReordered.add(_object);
      
      });

      if(!inserted){
        _objectToChange.reorderableNewPriority(_objectsReordered.length);
        _objectsReordered.add(_objectToChange);
      }

      _objectsReordered.sort((_objA,_objB){
        return _objA.priority-_objB.priority;
      });

      _objectsReordered.forEach((_obj){
        if(widget.onPriorityChange!=null) widget.onPriorityChange(_obj);
      });

      reLoadCards();

      setState(() {
        reorderableObjects = _objectsReordered;
        isInDrag=false;
      });
    }

    



  @override
  Widget build(BuildContext context) {
    return dataBody();

  }
}
