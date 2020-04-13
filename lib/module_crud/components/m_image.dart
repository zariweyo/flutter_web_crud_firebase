import 'package:flutter/material.dart';
//import 'package:firebase/firebase.dart' as Firebase;
import 'package:flutter_web_crud_firebase/module_canvaskit/index.dart';
import 'package:flutter_web_crud_firebase/module_crud/index.dart';
import '../../module_filehandle/base/filehandle_controller.dart';



class MImage extends StatefulWidget{

  Uri image;
  double width;
  double height;
  EdgeInsetsGeometry padding;
  EdgeInsetsGeometry margin;
  bool cached;


  MImage({Key key,@required this.image,this.width=50,this.height=50, 
    this.padding=EdgeInsets.zero, this.margin=EdgeInsets.zero,this.cached=true}):super(key:key);

  @override
  _MImageState createState() => _MImageState();

}

class _MImageState extends State<MImage>{
  String _imagePath;
  bool errorLoad;

  @override
  initState(){
    _loadImage();
    super.initState();
  }

  @override
  didUpdateWidget(MImage oldWidget){
    if(widget.image.toString()!=oldWidget.image.toString()){
      _loadImage();
    }
    super.didUpdateWidget(oldWidget);
  }

  _loadImage(){
   
    errorLoad = false;
    FileHandleController fileHandleController = new FileHandleController();
    fileHandleController.loadImage(widget.image).then((_imagePathResolved){
      setState(() {
        _imagePath = _imagePathResolved;
      });
    }).catchError((err){
      setState(() {
        errorLoad = true;
      });
    });
    
  }

  Widget _printImage(){
    
    if(_imagePath!=null && _imagePath.length>10){
      String _key = _imagePath;
      if(!widget.cached){
        _key = Mfunctions.generateUuid();
      }
      
      return Container(
        width: widget.width,
        height: widget.height,
        child:CKNetworkImage(
          src:_imagePath, 
          key:ValueKey(_key),
          width: widget.width, 
          height: widget.height,)
      );
    }else{
      if(errorLoad){
        return Center(
          child:Icon(Icons.warning)
        );
      }

      if(widget.image==null){
        return MEmpty();
      }

      return Center(
        child:MLoading()
      );
    }
  }

 

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      padding: widget.padding,
      width: widget.width,
      height: widget.height,
      child: _printImage()
    );
  }
  
}