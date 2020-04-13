import 'package:flutter/material.dart';

import 'package:flutter_web_crud_firebase/module_crud/index.dart';


class MFileField extends StatefulWidget{

  Function(dynamic) onError;
  Function() onUpload;
  MFile file;
  String name;
  MFileField({this.file,this.name="",this.onError,this.onUpload});

  @override
  _MFileFieldState createState() => _MFileFieldState();


}

class _MFileFieldState extends State<MFileField>{

  MFile _file;
  bool loading = true;
  
  MFileController controller;

  @override
  initState(){
    _file = widget.file; 
    _loadController();
    super.initState();
  }

  _loadController(){
    if(controller!=null){
      controller.dispose();
    }

    switch(_file.type){
      case MFileType.AUDIO:
        controller = new MFileAudioController(_file);
        break;
      case MFileType.IMAGE:
        controller = new MFileImageController(_file);
        break;
      case MFileType.PDF:
        controller = new MFilePDFController(_file);
        break;
      default:
    }

    if(controller!=null){
      controller.load().then((_res){
        setState(() {
          loading = false;
        });
      }).catchError((err){
        setState(() {
          loading = false;
        });
      });

      controller.onChangeState(
        (_result){
          if(_result){
            setState(() { 
            });
          }
      });
    }
  }

  @override
  dispose(){
    if(controller!=null){
      controller.dispose();
    }
    super.dispose();
  }

  Widget _printFile(){
    if(controller!=null){
      return controller.toWidget();
    }else{
      return Text(_file.path);
    }
  }

  MFileUploadManageType _getType(){
    if(controller!=null){
      return controller.getType();
    }

    return MFileUploadManageType.ALL;
  }

  _mUpload(){
    return 
    Row(
      children:[
        _printFile(),
        MFileUploadManage(
          uploadContainer: Icon(Icons.file_upload),
          deleteContainer: Icon(Icons.delete),
          path:_file.path,
          type: _getType(),
          size: _file.maxBytes,
          onError: (err){
            if(widget.onError!=null) widget.onError(err);
            setState(() {
              loading=false;
            });
          },
          onComplete: (){
            //FWCFGlobals.filesPathsCache[_file.path]=null;
            _file.file=new Uri();
            setState(() {
              _loadController();
            });
            if(widget.onUpload!=null) widget.onUpload();
          },
        )
      ]
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
        children:[
          Container(
            margin:EdgeInsets.only(left:5),
            child:Text(widget.name)
          ),
          loading?
            Center(child: CircularProgressIndicator()):
            _mUpload()
        ]
      )
    );
    
  }

}
