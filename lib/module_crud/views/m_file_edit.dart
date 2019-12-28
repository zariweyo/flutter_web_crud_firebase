import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_web_crud_firebase/module_crud/index.dart';

class EditMFile extends StatelessWidget{

  MFile file;

  EditMFile({@required this.file});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File")
      ),
      body:Container(
        child: MGroupField(
          mEditableGroupObject: file,
          onError: (_genError){
            UtilMessages.showErrorDialog(context, _genError.message);
          },
        )
      )
    );
  }

}