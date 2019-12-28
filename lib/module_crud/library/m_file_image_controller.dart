import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_web_crud_firebase/module_crud/index.dart';

class MFileImageController extends MFileController{
  
  bool isPlaying=false;

  MFileImageController(MFile file):super(file);

  @override
  Future<bool> load() {
    Completer completer = new Completer<bool>();
    file.loadFile().then((_res){
      completer.complete(true);
    }).catchError((err){
      completer.completeError(err);
    });
    
    return completer.future;
  }

  @override
  dispose(){
    super.dispose();
  }



  @override
  Widget toWidget() {
    if(file.file==null){
      return MEmpty();
    }

    return MImage(image: file.file,);
  }

  @override
  MFileUploadManageType getType() {
    return MFileUploadManageType.IMAGE;
  }
  
}