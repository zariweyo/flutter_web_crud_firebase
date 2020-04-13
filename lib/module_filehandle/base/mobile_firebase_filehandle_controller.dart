import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_crud_firebase/module_crud/components/m_file_upload_manage.dart';
import 'package:flutter_web_crud_firebase/module_crud/index.dart';

import 'filehandle_controller_abs.dart';



class FileHandleController implements FileHandleControllerBase{

  @override
  Future<dynamic> deleteFile(String path) {
    return FirebaseStorage.instance.ref().child(path).delete();
  }

  @override
  callFilePicker() {
    // TODO: implement callFilePicker
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
    // TODO: implement callFilePicker
    throw UnimplementedError();
  }

  @override
  Future<String> loadImage(Uri image) {
    throw UnimplementedError();
  }

  
}
