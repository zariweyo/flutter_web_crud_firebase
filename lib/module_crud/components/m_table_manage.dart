import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_web_crud_firebase/module_crud/index.dart';

class MTableManage extends StatefulWidget{
  Function() onAddItem;
  Function() onEndList;
  Function() onActionGlobal;
  Function(MTableable) onDelItem;
  List<Map<String,dynamic>> onCustomActions;
  Function(MTableable) onEditItem;
  Function(MTableable,bool) onCheckItem;
  String titleDelete;
  String messageDelete;
  String title;
  List<MTableable> items;
  List<MTableable> itemsChecked;
  EdgeInsetsGeometry margin;
  IconData iconActionGlobal;
  double height;
  bool refreshOnChange;
  

  MTableManage({Key key, this.onAddItem,this.height,this.refreshOnChange=false, @required this.items,this.margin=EdgeInsets.zero, @required this.title,this.onEndList, 
    this.onDelItem,this.itemsChecked, this.onEditItem,this.onCheckItem, this.titleDelete="",this.messageDelete="",
    this.iconActionGlobal=Icons.settings,this.onActionGlobal, this.onCustomActions  }) :super(key:key);

  @override
  _MTableManageState createState() => _MTableManageState();
}

class _MTableManageState extends State<MTableManage>{
  List<MTableable> items;
  List<String> deleting;
  ScrollController scrollcontroller;
  

  @override
  initState(){
    scrollcontroller = new ScrollController();
    _scrollcontrollerActions();
    deleting = new List<String>();
    items = new List<MTableable>();
    if(widget.items!=null){
      items=widget.items;
    }
    super.initState();
    
  }

  _scrollcontrollerActions(){
    scrollcontroller.addListener((){
      if (scrollcontroller.offset >= scrollcontroller.position.maxScrollExtent &&
        !scrollcontroller.position.outOfRange) {
          if(widget.onEndList!=null){
            widget.onEndList();
          }
      }
    });
  }

  @override
  didUpdateWidget(MTableManage oldWidget){
    if(widget.items!=null){
      setState(() {
        items=widget.items;
      });
    }
    super.didUpdateWidget(oldWidget);
  }


  _printDeleteButton(MTableable _item){

    if(_item.isDeleteable() && !deleting.contains(_item.getId()) && widget.onDelItem!=null){
            return Expanded(
              flex:1,
              child: IconButton(
                icon: Icon(Icons.delete),
                onPressed: (){
                  UtilMessages.showConfirmDialog(context, widget.titleDelete,  widget.messageDelete,
                    onAccept: (_context){
                      setState(() {
                        deleting.add(_item.getId());
                      });
                      
                      if(widget.onDelItem!=null){
                        widget.onDelItem(_item);
                      }
                      
                    }
                  );
                },
                )
              );
    }else if(_item.isDeleteable()){
      return Expanded(
              flex:1,
              child:MLoading(size:10)
            );
    }else{
      return MEmpty();
    }
  }

  _printAddButton(){
    if(widget.onAddItem==null){
      return MEmpty();
    }

    return IconButton(
      icon: Icon(Icons.add_circle_outline),
      color: Colors.black,
      iconSize: 30,
      onPressed: (){
        widget.onAddItem();
      },
    );
  }

  _printActionGlobal(){
    if(widget.onActionGlobal==null){
      return MEmpty();
    }

    return IconButton(
      icon: Icon(widget.iconActionGlobal),
      color: Colors.black,
      iconSize: 30,
      onPressed: (){
        widget.onActionGlobal();
      },
    );
  }

  _printEditButton(MTableable _item){
    if(_item.isEditable() && widget.onEditItem!=null){
      return Expanded(
      flex:1,
      child: IconButton(
        icon: Icon(Icons.edit),
        onPressed: (){
          if(widget.onEditItem!=null){
            widget.onEditItem(_item);
          }
        },
        )
      );
    }

    return MEmpty();
  }

  _printCustomActionButton(MTableable _item, Map<String,dynamic> customAction){
    if(customAction["action"] != null && customAction["icon"] != null) {
      return Expanded(
        flex:1,
        child: IconButton(
          icon: Icon(customAction["icon"]),
          onPressed: () => customAction["action"](_item),
        )
      );
    }
    
    return MEmpty();
  }

  _printCheckButton(MTableable _item){
      return Expanded(
      flex:1,
      child: Checkbox(
        activeColor: Colors.transparent,
        value: widget.itemsChecked.where((_it)=>_it.getId()==_item.getId()).length>0,
        onChanged: (selected){
          if(widget.onCheckItem!=null){
            widget.onCheckItem(_item,selected);
          }
        }
      )
      
      );


  }

  List<Widget> _widgetsZoneButtons(MTableable _item){
    List<Widget> _widgetsButtons = new List<Widget>();

    if(widget.onDelItem!=null){
      _widgetsButtons.add(_printDeleteButton(_item));
    }
    if(_item.isEditable() && widget.onEditItem!=null){
      _widgetsButtons.add(_printEditButton(_item));
    }
    if(widget.onCheckItem!=null && widget.itemsChecked!=null){
      _widgetsButtons.add(_printCheckButton(_item));
    }
    if(widget.onCustomActions!=null){
      widget.onCustomActions.forEach((customAction) => _widgetsButtons.add(_printCustomActionButton(_item, customAction)));
    }

    return _widgetsButtons;
  }

  _widgetsZoneData(MTableable _item){
    List<Widget> _widgets = new List<Widget>();
    List<Widget> _widgetsButtons = _widgetsZoneButtons(_item);

    if(_widgetsButtons.length>0){
      _widgets.add(
          Expanded(
             flex: (_widgetsButtons.length/2).floor()+1,
             child: Container(
               padding: EdgeInsets.only(left: 20),
               child:Row(children: _widgetsButtons,),
             )
          )
      );
    }

    if(_item.getTableColumns()==null || _item.getTableColumns().length==0){
      _widgets.add(  
          Expanded(
             flex:6,
             child: Container(
               padding: EdgeInsets.only(left: 20),
               child:Text(_item.getTitle()),
             )
          )
      );



      _widgets.add(  
          Expanded(
             flex:4,
             child: Container(
               padding: EdgeInsets.only(left: 10,right: 5),
               child:Text(
                _item.getDescription(),
                textAlign: TextAlign.right,
               ),
             )
               
          )
      );
    }else{
      _item.getTableColumns().forEach((_wid){
        _widgets.add(
          Expanded(
             flex:4,
             child: Container(
               padding: EdgeInsets.symmetric(horizontal: 5),
               child:_wid,
             )
               
          )
        );
      });
    }
    

    return _widgets;
  }

  _printHeader(MTableable item){
    

    List<Widget> _widgets = new List<Widget>();

    int _initFlex = (_widgetsZoneButtons(item).length/2).floor()+1;
    _widgets.add(
        Expanded(
             flex:_initFlex,
             child:MEmpty()
        )
    );

    item.getTableHeader().forEach((_mhead){
      _widgets.add(
        Expanded(
             flex:4,
             child: Container(
               padding: EdgeInsets.symmetric(horizontal: 5),
               child:Text(
                 _mhead.title,
                 textAlign: TextAlign.center,
                ),
             )
               
        )
      );
    });

    return Row(
      children: _widgets,
    );
  }

  _printCards(){
    List<Widget> _widgets = new List<Widget>();
    _widgets.add(
      Flexible(
        flex:3,
        child:Container(
          padding:EdgeInsets.only(top:10,left:10,bottom: 5),
          margin:EdgeInsets.only(top:0,left:0,bottom: 10,right: 0),
          width:MediaQuery.of(context).size.width,

          color:Colors.white,
          child:Row(
            children: <Widget>[
              Expanded(
                flex:10,
                child:Text(
                    widget.title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20
                    ),
                  )
              ),
              Expanded(
                flex:1,
                child: _printAddButton()
                ),
                Expanded(
                flex:1,
                child: _printActionGlobal()
                ),
                
            ]
          )
        )
      )
    );
    if(items.length>0 && items[0].getTableHeader() != null && items[0].getTableHeader().length>0){
      _widgets.add(
        Expanded(
          flex:1,
          child:_printHeader(items[0])
        )
      );
    }
    List<Widget> cards = new List<Widget>();
    items.forEach((_item){
      
      cards.add(
        Row(
         children: _widgetsZoneData(_item)
        )
        
      );
    });

    ValueKey _valueKey = ValueKey("__");
    if(widget.refreshOnChange){
      _valueKey = ValueKey(Mfunctions.generateUuid());
    }

    _widgets.add(
      Expanded(
        flex:10,
        child:Container(
          //height: 300,
          //child:Scrollbar(
            child:ListView(
              key:_valueKey,
              controller: scrollcontroller,
              children:cards
            )
          //)
        )
      )
    );
    return _widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:widget.margin,
      alignment: Alignment.centerLeft,
      width:MediaQuery.of(context).size.width,    
      height: widget.height,  
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(5))
      ),
      child:Column(
        children: _printCards(),
      )
    );
  }

}