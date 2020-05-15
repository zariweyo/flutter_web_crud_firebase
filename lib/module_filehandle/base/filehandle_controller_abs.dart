import 'package:flutter/material.dart';
import 'package:flutter_web_crud_firebase/module_crud/index.dart';

abstract class FileHandleControllerBase{

  callFilePicker();

  Future deleteFile(String path);

  Future<String> loadImage(Uri image);
  
  loadFilePicker({
    @required String path,
    @required MFileUploadManageType type,
    @required int size,
    @required Function(int) handlePercent,
    Function(GenericError) onError,
    Function() onComplete,
  });

  loadFileUri({
    @required String path,
    @required Function(int) handlePercent,
    Function(GenericError) onError,
    Function() onComplete,
  });


}