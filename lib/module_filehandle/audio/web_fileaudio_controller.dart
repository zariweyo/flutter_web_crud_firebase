import 'dart:async';

import 'fileaudio_controller_abs.dart';
import 'dart:html';

class FileAudioController implements FileAudioControllerBase{
  AudioElement _audio;

  FileAudioController(String src){
    _audio = new AudioElement(src);
  }

  @override
  Future<bool> onLoaded(){
    Completer completer = new Completer<bool>();
    _audio.onLoadedData.listen((_meta){
        completer.complete(true);
      }).onError((err){
        completer.completeError(err);
      });
    return completer.future;
  }

  @override
  destroy(){
    _audio.pause();
  }

  @override
  int getSeconds(){
    if(_audio!=null && _audio.duration!=null){
      return _audio.duration.toInt();
    }
    
    return 0;
  }

  @override
  play(){
    _audio.play();
  }

  @override
  pause(){
    _audio.pause();
  }
}