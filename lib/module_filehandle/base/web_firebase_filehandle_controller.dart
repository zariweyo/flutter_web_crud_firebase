import 'dart:async';
import 'dart:html';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_crud_firebase/module_crud/index.dart';
//import 'package:http/http.dart';

import 'filehandle_controller_abs.dart';



class FileHandleController implements FileHandleControllerBase{

  InputElement uploadInput;

  @override
  Future<dynamic> deleteFile(String path) {
    return FirebaseStorage.instance.ref(path).delete();
  }

  @override
  Future<void> loadFileUri({
    @required Uri uri,
    @required String path,
    @required Function(int) handlePercent,
    @required MFileUploadManageType type,
    @required int size,
    Function(GenericError) onError,
    Function() onComplete,
  }) async{
    String url = uri.toString(); 
    print(url);
    Response<List<int>> response = await Dio().get<List<int>>(url, options: Options(responseType: ResponseType.bytes)); 

    int sizeFile = response.data.length;

    print(sizeFile);

    if(size>=0 && sizeFile>size){
        if(onError!=null){
          onError(GenericError(
            code: "UPLOAD_001",
            message: "Max_size_upload_exceded",
            origin: MFileUploadManage
          ));
        }
      }else{

        _uploadFileBytes(response.data, path,onChangePercent: handlePercent).then((_uploaded){
            if(_uploaded){
              if(onComplete!=null) onComplete();
            }else{
              if(onError!=null) onError(
                GenericError(
                  code: "UPLOAD_012",
                  message: "Upload_failed",
                  origin: MFileUploadManage
                )
              );
            }
          }).catchError((err){
            if(onError!=null) onError(
              GenericError(
                  code: "UPLOAD_013",
                  message: "Upload_error",
                  origin: MFileUploadManage
              )
            );
          });
      }
    
    
  }

  Future<bool> _uploadFileBytes(List<int> blob,String path,{Function(int) onChangePercent}) {
    UploadTask _uploadTask = FirebaseStorage.instance.ref(path).putBlob(blob);

    return _uploadFileData(_uploadTask,onChangePercent:onChangePercent);
  }

  Future<bool> _uploadFile(String blob,String path,{Function(int) onChangePercent}) {
    UploadTask _uploadTask = FirebaseStorage.instance.ref(path).putString(blob,format: PutStringFormat.dataUrl);

    return _uploadFileData(_uploadTask,onChangePercent:onChangePercent);
  }

  Future<bool> _uploadFileData(UploadTask _uploadTask,{Function(int) onChangePercent}) {
    Completer completer = new Completer<bool>();

    StreamSubscription<TaskSnapshot> _stream;
    _stream = _uploadTask.snapshotEvents.listen((_data){
        print(_data.state);
        print(_data.bytesTransferred.toString()+" / "+_data.totalBytes.toString());
        if(onChangePercent!=null){
          int _percent = ((_data.bytesTransferred*100)~/_data.totalBytes);
          onChangePercent(_percent);
        }
        
      },
      onDone: (){
        _stream.cancel();
        _uploadTask.cancel();
        completer.complete(true);
      },
      onError: (err){
        completer.completeError(err);
      },
      cancelOnError: true
    );

    return completer.future;
  }


  @override
  callFilePicker(){
    uploadInput.click();
  }

  
  Future<String> _pathFileLoadFromStorage(Reference imageReference,{ bool cached=true }) {
    Completer completer = new Completer<String>();
    if(imageReference.fullPath==""){
      completer.completeError(GenericError(code:"IM230",message:"Error_storage_path_is_empty",origin: Mfunctions));
      return completer.future;
    }
    
    //if (cached && FWCFGlobals.filesPathsCache[imageReference.fullPath] != null) {
    //  completer.complete(FWCFGlobals.filesPathsCache[imageReference.fullPath].toString());
    //} else {
        
    imageReference.getDownloadURL().then((_pathImage) {
      if (_pathImage != null ) {
       // if (cached) FWCFGlobals.filesPathsCache[imageReference.fullPath] = _pathImage;
        completer.complete(_pathImage.toString());
      }else{
        completer.complete("");
      }
    }).catchError((onError) {
      completer.completeError(onError);
    });
      
    //}
    return completer.future;
  }

  @override
  Future<String> loadImage(Uri image){
    Completer completer = new Completer<String>();
    if(!Mfunctions.imageIsCDN(image)){
        Reference _storageRef = FirebaseStorage.instance.ref(image.toString());
        _pathFileLoadFromStorage(_storageRef,cached: false).then((_pathImageResolved){
          
          completer.complete(_pathImageResolved);
        })
        .catchError((err){
          completer.completeError(err);
        });
    }else{
      completer.complete(image.toString());
    }

    return completer.future;
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
    
    uploadInput = FileUploadInputElement();
    uploadInput.accept = Mfunctions.getStringTypes(type);
    final reader = new FileReader();

    reader.onLoadEnd.listen((e) {
      
      if(size>=0 && e.total>size){
        if(onError!=null){
          onError(GenericError(
            code: "UPLOAD_001",
            message: "Max_size_upload_exceded",
            origin: MFileUploadManage
          ));
        }
      }else{
        
        _uploadFile(reader.result, path,onChangePercent: handlePercent).then((_uploaded){
          if(_uploaded){
            if(onComplete!=null) onComplete();
          }else{
            if(onError!=null) onError(
              GenericError(
                code: "UPLOAD_002",
                message: "Upload_failed",
                origin: MFileUploadManage
              )
            );
          }
        }).catchError((err){
          if(onError!=null) onError(
            GenericError(
                code: "UPLOAD_003",
                message: "Upload_error",
                origin: MFileUploadManage
            )
          );
        });
      }
    });

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      if (files.length == 1) {
        final file = files[0];
        reader.readAsDataUrl(file);
      }
    });
    
  }

  

}

