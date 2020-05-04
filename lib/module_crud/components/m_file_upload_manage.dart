
import 'package:flutter/material.dart';
import 'package:flutter_web_crud_firebase/module_crud/index.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../module_filehandle/base/filehandle_controller.dart';

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

  MFileUploadManage({
    @required this.path, 
    @required this.uploadContainer,
    @required this.deleteContainer, 
    this.onComplete, 
    this.showPercent=true,
    this.type = MFileUploadManageType.ALL, 
    this.size=-1, 
    this.onError
  });

  @override
  _MFileUploadManageState createState() => _MFileUploadManageState();

}

class _MFileUploadManageState extends State<MFileUploadManage>{

  //InputElement uploadInput;
  int percent=100;
  FileHandleController fileHandleController;
  bool _uploading = false;

  @override
  initState(){
    fileHandleController = new FileHandleController();
    _startFilePicker();
    super.initState();
  }

  @override
  didUpdateWidget(MFileUploadManage oldWidget){
    _startFilePicker();
    super.didUpdateWidget(oldWidget);
  }

  

  _delete(){
    fileHandleController.deleteFile(widget.path).then((value){
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
    fileHandleController.loadFilePicker(
      path: widget.path, 
      type: widget.type, 
      size: widget.size, 
      handlePercent: _handlePercent,
      onComplete: _onUploadComplete,
      onError: widget.onError
    );
  }

  _onUploadComplete(){
    print("UploadComplete");
    setState(() {
      _uploading = false;
    });
    widget.onComplete();
  }

  _handlePercent(int _percent){
    if(_percent<50){
      _uploading = true;
    }
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
    if(widget.showPercent && _uploading){
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
              fileHandleController.callFilePicker();
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

