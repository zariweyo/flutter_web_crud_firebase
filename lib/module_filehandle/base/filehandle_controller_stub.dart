import 'package:flutter/material.dart';
import 'package:flutter_web_crud_firebase/module_crud/index.dart';

import 'filehandle_controller_abs.dart';

class FileHandleController implements FileHandleControllerBase{

  FileHandleController();

  @override
  callFilePicker() {
    throw UnimplementedError();
  }

  @override
  Future deleteFile(String path) {
      throw UnimplementedError();
  }

  @override
  Future<String> loadImage(Uri image){
    throw UnimplementedError();
  }
  
  @override
  loadFilePicker({
    @required String path,
    @required MFileUploadManageType type,
    @required int size,
    @required Function(int) handlePercent,
    Function(GenericError) onError,
    Function() onComplete,
  }){
    throw UnimplementedError();
  }

  @override
  loadFileUri({
    @required Uri uri,
    @required String path,
    @required Function(int) handlePercent,
    @required MFileUploadManageType type,
    @required int size,
    Function(GenericError) onError,
    Function() onComplete,
  }){
    // TODO: implement loadFileUri
    throw UnimplementedError();
  }


}
