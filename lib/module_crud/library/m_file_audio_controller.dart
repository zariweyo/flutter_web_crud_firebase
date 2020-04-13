import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_web_crud_firebase/module_crud/index.dart';
import '../../module_filehandle/audio/fileaudio_controller.dart';

class MFileAudioController extends MFileController{
  
  FileAudioController fileAudioController;
  bool isPlaying=false;

  MFileAudioController(MFile file):super(file);

  @override
  Future<bool> load() {
    Completer completer = new Completer<bool>();
    file.loadFile().then((_res){
      fileAudioController = new FileAudioController(file.file.toString());
      fileAudioController.onLoaded().then((_loaded){
        completer.complete(_loaded);
      }).catchError((err){
        completer.completeError(err);
      });

    }).catchError((err){
      completer.completeError(err);
    });
    
    return completer.future;
  }

  @override
  dispose(){

    if(fileAudioController!=null){
      fileAudioController.destroy();
    }
    super.dispose();
  }



  @override
  Widget toWidget() {
    if(fileAudioController==null){
      return MEmpty();
    }

    return FlatButton(
      child:  Row(
        children:[
          Icon(
            isPlaying?Icons.pause:Icons.play_arrow,
            color: Colors.white,
          ),
          Text(Mfunctions.prettyTime(Duration(seconds:fileAudioController.getSeconds())))
        ]
      ),
      onPressed: (){
        if(isPlaying){
          
          isPlaying=false;
          fileAudioController.pause();
          changeState.add(true);
        }else{
          isPlaying=true;
          fileAudioController.play();
          changeState.add(true);
        }
      },
    );
  }

  @override
  MFileUploadManageType getType() {
    return MFileUploadManageType.AUDIO;
  }
  
}