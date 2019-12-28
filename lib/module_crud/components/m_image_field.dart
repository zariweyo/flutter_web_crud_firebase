import 'package:flutter/material.dart';
import 'package:flutter_web_crud_firebase/module_crud/index.dart';



class MImageField extends StatefulWidget{

  Function(dynamic) onError;
  Function() onUpload;
  String path;
  double width;
  double height;
  String name;
  int maxBytes;
  MImageField({this.path,this.name="",this.onError,this.width=100,this.height=100,this.onUpload,this.maxBytes=-1});


  
  
  @override
  _MImageFieldState createState() => _MImageFieldState();


}

class _MImageFieldState extends State<MImageField>{

  Uri _image;
  bool loading = false;

  @override
  initState(){
    _image = new Uri(path: widget.path); 

    super.initState();
  }

  _mUpload(){
    return MFileUploadManage(
      uploadContainer: MImage(image: _image,width: widget.width, height: widget.height, margin:EdgeInsets.all(10),cached: false,),
      deleteContainer: Icon(Icons.delete),
      path:widget.path,
      type: MFileUploadManageType.IMAGE,
      onError: (err){
        if(widget.onError!=null) widget.onError(err);
        setState(() {
          loading=false;
        });
      },
      onComplete: (){
        if(widget.onUpload!=null) widget.onUpload();
        //if(FWCFGlobals.filesPathsCache[_image.toString()]!=null){
        //  FWCFGlobals.filesPathsCache.removeWhere((_key,__)=> _key==_image.toString() );
        //}
      },
    );
  }

  @override
  Widget build(BuildContext context) {


    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(color:Colors.grey,width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(5))
      ),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Container(
            margin:EdgeInsets.only(left:5),
            child:Text(widget.name)
          ),
          loading?
            Center(child: CircularProgressIndicator()):
            _mUpload()
        ]
      )
    );
    
  }

}
