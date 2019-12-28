import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_web_crud_firebase/module_crud/index.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

enum MFileUploadManageType{
  ALL,
  IMAGE,
  AUDIO,
  VIDEO,
  PDF
}

class MFileUploadManage extends StatefulWidget{
  String path;
  MFileUploadManageType type;
  int size;
  Function(GenericError) onError;
  Function() onComplete;
  Widget uploadContainer;
  Widget deleteContainer;
  bool showPercent;

  MFileUploadManage({@required this.path, @required this.uploadContainer,@required this.deleteContainer, this.onComplete, this.showPercent=true,
    this.type = MFileUploadManageType.ALL, this.size=-1, this.onError});

  @override
  _MFileUploadManageState createState() => _MFileUploadManageState();

}

class _MFileUploadManageState extends State<MFileUploadManage>{

  InputElement uploadInput;
  int percent=100;

  @override
  initState(){
    _startFilePicker();
    super.initState();
  }

  _getStringTypes(){
    switch(widget.type){
      case MFileUploadManageType.IMAGE:
        return "image/*";
        break;
      case MFileUploadManageType.AUDIO:
        return "audio/*";
        break;
      case MFileUploadManageType.VIDEO:
        return "video/*";
        break;
      case MFileUploadManageType.PDF:
        return "application/pdf";
        break;
      case MFileUploadManageType.ALL:
      default:
        return "*";
    }
  }

  _delete(){
    Mfunctions.deleteFile(widget.path).then((_){
      if(widget.onComplete!=null) widget.onComplete();
    }).catchError((err){
          if(widget.onError!=null) widget.onError(
            GenericError(
                code: "DELETE_001",
                message: "Delete_file_error",
                origin: MFileUploadManage
            )
          );
    });
  }


  _startFilePicker(){
    uploadInput = FileUploadInputElement();
    uploadInput.accept = _getStringTypes();
    final reader = new FileReader();

    reader.onLoadEnd.listen((e) {
      if(widget.size>=0 && e.total>widget.size){
        if(widget.onError!=null){
          widget.onError(GenericError(
            code: "UPLOAD_001",
            message: "Max_size_upload_exceded",
            origin: MFileUploadManage
          ));
        }
      }else{
        Mfunctions.uploadFile(reader.result, widget.path,onChangePercent: _handlePercent).then((_uploaded){
          if(_uploaded){
            if(widget.onComplete!=null) widget.onComplete();
          }else{
            if(widget.onError!=null) widget.onError(
              GenericError(
                code: "UPLOAD_002",
                message: "Upload_failed",
                origin: MFileUploadManage
              )
            );
          }
        }).catchError((err){
          if(widget.onError!=null) widget.onError(
            GenericError(
                code: "UPLOAD_003",
                message: "Upload_error",
                origin: MFileUploadManage
            )
          );
        });
      }
    });

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      if (files.length == 1) {
        final file = files[0];
        reader.readAsDataUrl(file);
      }
    });
  }

  _handlePercent(int _percent){
    if(widget.showPercent){
      setState(() {
        percent = _percent;
      });
    }
  }

  _showPercent(){
    return new CircularPercentIndicator(
        radius: 60.0,
        lineWidth: 5.0,
        percent: percent/100,
        center: new Text(percent.toString()+"%"),
        progressColor: Colors.green,
    );
  }

  @override
  Widget build(BuildContext context) {
    if(widget.showPercent && percent<100){
      return _showPercent();
    }
    
    return Container(
      margin: EdgeInsets.only(left: 20),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          FlatButton(
            child:widget.uploadContainer,
            onPressed: (){
              uploadInput.click();
            },
          ),
          FlatButton(
            child:widget.deleteContainer,
            onPressed: (){
              _delete();
            },
          )
        ]
      )
    );
  }


}

