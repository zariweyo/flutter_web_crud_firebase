import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CKNetworkImage extends StatefulWidget {
  final String src;
  final double height;
  final double width;

  CKNetworkImage({
    Key key,
    this.src,
    this.height,
    this.width
  }):super(key:key);

  

  @override
  _CKNetworkImageState createState() => _CKNetworkImageState();
}

class _CKNetworkImageState extends State<CKNetworkImage> {
  Uint8List _bytes;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  void didUpdateWidget(CKNetworkImage oldWidget) {
    if(oldWidget.src!=widget.src){
      _fetchData();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _fetchData() async {
    _bytes = (await http.get(widget.src)).bodyBytes;

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return _bytes != null
        ? Image.memory(
          _bytes,
          height: widget.height,
          width: widget.width,
        )
        : Container();
  }
}