import 'dart:async';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter_web_crud_firebase/module_crud/index.dart';

class MFileAudioController extends MFileController{
  
  AudioElement _audio;
  bool isPlaying=false;

  MFileAudioController(MFile file):super(file);

  @override
  Future<bool> load() {
    Completer completer = new Completer<bool>();
    file.loadFile().then((_res){
      print(file.file.toString());
      _audio = new AudioElement(file.file.toString());
      _audio.onLoadedData.listen((_meta){
        completer.complete(true);
      }).onError((err){
        completer.completeError(err);
      });
    }).catchError((err){
      completer.completeError(err);
    });
    
    return completer.future;
  }

  @override
  dispose(){
    if(_audio!=null){
      _audio.pause();
    }
    super.dispose();
  }



  @override
  Widget toWidget() {
    if(_audio==null){
      return MEmpty();
    }

    return FlatButton(
      child:  Row(
        children:[
          Icon(
            isPlaying?Icons.pause:Icons.play_arrow,
            color: Colors.white,
          ),
              Text(Mfunctions.prettyTime(Duration(seconds:_audio.duration.toInt())))
        ]
      ),
      onPressed: (){
        if(isPlaying){
          
          isPlaying=false;
          _audio.pause();
          changeState.add(true);
        }else{
          isPlaying=true;
          _audio.play();
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