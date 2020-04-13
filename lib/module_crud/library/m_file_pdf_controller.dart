import 'dart:async';
//import 'package:firebase/firebase.dart' as Firebase;
import 'package:flutter/material.dart';
import 'package:flutter_web_crud_firebase/module_crud/index.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../module_filehandle/base/filehandle_controller.dart';

class MFilePDFController extends MFileController{
  
  bool isLoad=false;

  MFilePDFController(MFile file):super(file);

  @override
  Future<bool> load() {
    Completer completer = new Completer<bool>();
    file.loadFile().then((_res){
      isLoad=true;
      completer.complete(true);
    }).catchError((err){
      isLoad=false;
      completer.completeError(err);
    });
    
    return completer.future;
  }

  @override
  dispose(){
    super.dispose();
  }

  _launchURL(String _url) async {
    if (await canLaunch(_url)) {
      await launch(_url);
    } else {
      throw 'Could not launch $_url';
    }
  }

  _download(){

    Uri _filePath = Uri.parse(file.path);
    FileHandleController fileHandleController = new FileHandleController();
    fileHandleController.loadImage(_filePath).then((_pathResolved){
      _launchURL(_pathResolved);
    }).catchError((err){
      
    });
  }

  @override
  Widget toWidget() {
    if(!isLoad){
      return MEmpty();
    }

    return FlatButton(
      onPressed: _download,
      child:Icon(Icons.picture_as_pdf)
    );
  }

  @override
  MFileUploadManageType getType() {
    return MFileUploadManageType.PDF;
  }
  
}