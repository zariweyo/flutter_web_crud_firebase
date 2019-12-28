import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_web_crud_firebase/module_crud/index.dart';


abstract class MFileController{
  final MFile file;
  MFileController(this.file);
  StreamController<bool> changeState = new StreamController();


  Future<bool> load();
  Widget toWidget();
  MFileUploadManageType getType();

  void dispose(){
    changeState.close();
  }

  StreamSubscription<bool> onChangeState(void Function(bool) onData, {Function onError, void Function() onDone, bool cancelOnError}){
    return changeState.stream.listen(onData,onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }
}