import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_web_crud_firebase/module_crud/index.dart';

class MTableFiles extends StatefulWidget{

  bool editable;
  String title;
  String titleDelete;
  String messageDelete;
  List<MTableable> files;
  Function() onChange;
  String pathBase;

  MTableFiles({
    @required this.title,
    @required this.titleDelete,
    @required this.messageDelete,
    @required this.files,
    @required this.pathBase,
    this.editable=true,
    this.onChange
  });


  @override
  _MTableFilesState createState() => _MTableFilesState();


}

class _MTableFilesState extends State<MTableFiles>{

  
  _goFileDetail(MFile _file){
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => EditMFile(file:_file)),
    ).then((res){
      if(widget.onChange!=null) widget.onChange();
    });
  }
  

  onEditFile(MTableable _file){
    _goFileDetail(_file);
  }

  onDelFile(MTableable _file){
    setState(() {
      widget.files.removeWhere((_fi)=> _file.getId()==_fi.getId());
      if(widget.onChange!=null) widget.onChange();
    });
  }

  onAddFile(){
    String _path = widget.pathBase+"/"+Mfunctions.generateUuid();
    MFile _newFile = new MFile(_path);
    _newFile.description = "New_file";
    setState(() {
      widget.files.add(_newFile);
      if(widget.onChange!=null) widget.onChange();
    });
  }

  _printTableFile(){
    
    return Container(
      margin: EdgeInsets.only(top:10,bottom: 10),
      child:MTableManage(
        title: widget.title,
        height: 300,
        titleDelete: widget.titleDelete,
        messageDelete: widget.messageDelete,
        items: widget.files,
        
        onEditItem: widget.editable?onEditFile:null,
        onDelItem: widget.editable?onDelFile:null,
        onAddItem: widget.editable?onAddFile:null,
      )
    );
  }


  @override
  Widget build(BuildContext context) {
    return _printTableFile();
  }

}