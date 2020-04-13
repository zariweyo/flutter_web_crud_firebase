import 'dart:async';
//import 'package:firebase/firebase.dart' as Firebase;
import 'package:flutter_web_crud_firebase/module_crud/index.dart';
import 'package:uuid/uuid.dart';

class Mfunctions{

  static String generateUuid() {
    var uuid = new Uuid();
    return uuid.v4();
  }

  static String getStringTypes(MFileUploadManageType type){
    switch(type){
      case MFileUploadManageType.IMAGE:
        return "image/*";
        break;
      case MFileUploadManageType.AUDIO:
        return "audio/*";
        break;
      case MFileUploadManageType.VIDEO:
        return "video/*";
        break;
      case MFileUploadManageType.PDF:
        return "application/pdf";
        break;
      case MFileUploadManageType.ALL:
      default:
        return "*";
    }
  }

/*
  static Future<dynamic> deleteFile(String path) {
    return Firebase.storage().ref(path).delete();

  }
*/

  static bool imageIsCDN(Uri uri){
    if(!uri.hasScheme){
      return false;
    }
    return uri.scheme.substring(0,4).toLowerCase()=="http";
  }

/*
  static Future<bool> uploadFile(String blob,String path,{Function(int) onChangePercent}) {
    Completer completer = new Completer<bool>();
    Firebase.UploadTask _uploadTask = Firebase.storage().ref(path).putString(blob,'data_url');

    

    StreamSubscription<Firebase.UploadTaskSnapshot> _stream;
    _stream = _uploadTask.onStateChanged.listen((_data){
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
        print(err);
        completer.completeError(err);
      },
      cancelOnError: true
    );

    return completer.future;
  }
*/

  static String prettyTime(Duration _dur){
    String res = "";
    if(_dur.inHours>0) res += _dur.inHours.toString() +":";
    if(_dur.inMinutes>0) res += ((_dur.inMinutes%60)<10?"0":"") + (_dur.inMinutes%60).toString() +":";
    res += ((_dur.inSeconds%60)<10?"0":"") + (_dur.inSeconds%60).toString() +".";
    res += (_dur.inMilliseconds%1000).toString();

    return res;
  }
  
  /*
  static Future<String> pathFileLoadFromStorage(Firebase.StorageReference imageReference,{ bool cached=true }) {
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
  */
}