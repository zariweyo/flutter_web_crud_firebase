import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_crud_firebase/module_crud/index.dart';

class MGroupField extends StatelessWidget{
  MEditableGroupObject mEditableGroupObject;
  MEditableGroupFieldExtended _extended;
  MEditableGroupFieldExtended actualExtended;
  Function(String,dynamic) onSetReflectionValue;
  Function(GenericError) onError;
  String parentAttributeName;

  MGroupField({@required this.mEditableGroupObject,this.onSetReflectionValue,this.onError,this.actualExtended,this.parentAttributeName=""});

  _setReflectionValue(String attrName, dynamic attrValue){
    mEditableGroupObject.setReflectionValue(attrName,attrValue);
    if(this.onSetReflectionValue!=null){
      this.onSetReflectionValue(attrName,mEditableGroupObject);
    }
    
    
  }


  _getAtributesEditableWidgets(){
    List<Widget> widgets = new List<Widget>();
    mEditableGroupObject.getReflectionAttributes().forEach((_attrNameDef,_attrValue){
      String _attrName = mEditableGroupObject.getReflectionTranslates()[_attrNameDef];
      if(_attrName==null || _attrName==""){
        _attrName = _attrNameDef;
      }

      if(_attrValue is MEditableGroupFieldList){
        MEditableGroupFieldList _itemsEditable = _attrValue;

        List<DropdownMenuItem> _items = new List<DropdownMenuItem>();
        _itemsEditable.mGroupFieldListItem.forEach((_mEditableGroupFieldListItem){
          _items.add(DropdownMenuItem(
            value:_mEditableGroupFieldListItem.value,
            child: Text(
              _mEditableGroupFieldListItem.name,
              overflow: TextOverflow.fade,
            ),
          ));
        });

        widgets.add(
          MDropdownField(
            items: _items,
            selected: _itemsEditable.selected,
            title: _attrName,
            onChanged: (_newValue){
              _setReflectionValue(_attrNameDef,_newValue);
            },
          )

        );
      }else if(_attrValue is String && _extended!=null && _extended.types[_attrName]!=null && _extended.types[_attrName]==MEditableGroupFieldExtendedType.TEXTAREA){
      
        widgets.add(
          MTextArea(
            hintText: _attrName,
            value: _attrValue.toString(),
            onChanged: (_newValue){
              if(_attrValue is MDouble || _attrValue is double){
                _setReflectionValue(_attrNameDef,double.parse(_newValue));
              }else if(_attrValue is int){
                _setReflectionValue(_attrNameDef,int.parse(_newValue));
              }else{
                _setReflectionValue(_attrNameDef,_newValue);
              }
              
            },
          )
        );
      
      }else if(_attrValue is String || _attrValue is int || _attrValue is double || _attrValue is MDouble){
        IconData _icon = Icons.text_fields;
        if(_extended!=null && _extended.icons[_attrName]!=null){
          _icon = _extended.icons[_attrName];
        }

        
        
        List<TextInputFormatter> _inputFormatters = new List<TextInputFormatter>();
        if(_attrValue is int){
          _inputFormatters.add(WhitelistingTextInputFormatter(RegExp(r"[\-0-9]")));
        }
        if(_attrValue is MDouble || _attrValue is double){
          _inputFormatters.add(WhitelistingTextInputFormatter(RegExp(r"[\-0-9\.]")));
        }

        widgets.add(
          MTextField(
            inputFormatters: _inputFormatters,
            icon: _icon,
            hintText: _attrName,
            value: _attrValue.toString(),
            onChanged: (_newValue){
              if(_attrValue is MDouble || _attrValue is double){
                _setReflectionValue(_attrNameDef,double.parse(_newValue));
              }else if(_attrValue is int){
                _setReflectionValue(_attrNameDef,int.parse(_newValue));
              }else{
                _setReflectionValue(_attrNameDef,_newValue);
              }
              
            },
          )
        );
      }else if(_attrValue is bool){
        widgets.add(
          McheckField(
            title: _attrName,
            value: _attrValue,
            onChanged: (_newValue){
              _setReflectionValue(_attrNameDef,_newValue);
            },
          )
        );
      
      }else if(_attrValue is Uri){
        Uri _image = _attrValue;
        widgets.add(
          MImageField(
            name: _attrName,
            path: _image.path,
            //maxBytes: FWCFGlobals.MAXBYTESIMAGEUPLOAD,
            width: 150,
            height: 150,
            onUpload: (){
                _attrValue = Uri.parse(_image.path);
            },
            onError: (err){
              if(onError!=null) onError(err);
            },
          )
        );
        
      }else if(_attrValue is MFile){
        MFile _mFile = _attrValue;
        widgets.add(
          MFileField(
            name: _attrName,
            file: _mFile,
            //maxBytes: FWCFGlobals.MAXBYTESUPLOAD,
            onUpload: (){
              _attrValue = _mFile;
            },
            onError: (err){
              if(onError!=null) onError(err);
            },
          )
        );
        
      }else{
        
        if(_extended!=null && _extended.groups!=null && _extended.groups[_attrNameDef]!=null){
          String _headText = mEditableGroupObject.getReflectionTranslates()[_extended.groups[_attrNameDef]];
          if(_headText==null){
            _headText = _extended.groups[_attrNameDef];
          }

          widgets.add(
            Container(
              padding:EdgeInsets.only(left: 10),
              margin:EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(color:Colors.grey,width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Text(_headText),
                  MGroupField(
                    actualExtended:_extended,
                    parentAttributeName: _attrName,
                    mEditableGroupObject: _attrValue,
                    onError: (_genError){
                      if(onError!=null) onError(_genError);
                    },
                    onSetReflectionValue: (_newAttrName,_newAttrValue){
                      _setReflectionValue(_attrNameDef,_newAttrValue);
                    },
                  )
                ]
              )
            )
          );

        }else{
          widgets.add(
            MGroupField(
              mEditableGroupObject: _attrValue,
              actualExtended:_extended,
              parentAttributeName: _attrName,
              onError: (_genError){
                if(onError!=null) onError(_genError);
              },
              onSetReflectionValue: (_newAttrName,_newAttrValue){
                _setReflectionValue(_attrNameDef,_newAttrValue);
              },
            )
          );
        }
      }
    });

    return widgets;
  }


  @override
  Widget build(BuildContext context) {
    if(mEditableGroupObject==null){
      return MEmpty();
    }
    _extended = mEditableGroupObject.getReflectionExtended(parentAttributeName: parentAttributeName, actual:actualExtended);
    if(_extended!=null && _extended.grid>1){
      List<Widget> widgets = new List<Widget>();
      _getAtributesEditableWidgets().forEach((_fieldWidget){
        widgets.add(Flexible(
          flex:1,
          child: _fieldWidget
        ));
      });

      List<Widget> rows = new List<Widget>();
      for(int i=0;i<widgets.length; i+=_extended.grid){
        int last = i+_extended.grid;
        if(last>widgets.length) last=widgets.length;
        rows.add(
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widgets.sublist(i,last)
          )
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:rows
      );
    }
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _getAtributesEditableWidgets(),
    );
  }

}


