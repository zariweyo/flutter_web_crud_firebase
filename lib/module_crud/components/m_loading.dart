
import 'package:flutter/material.dart';

/// Widget to show loading image
class MLoading extends StatelessWidget {
  bool enabled=false;
  Color color;
  double size;
  bool useCircular;

  /// Params:
  /// 
  ///   [enabled]: If false, the image is disabled
  MLoading({this.enabled=true, this.color=Colors.white, this.size=200, this.useCircular=false});

  Widget _showCircularProgress(){
    if (enabled) {
      return Center(child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(this.color),
      ));
    } return Container(height: 0.0, width: 0.0,);

  }

  @override
  Widget build(BuildContext context) {
    if(this.useCircular){
      return _showCircularProgress();
    }
    return _showCircularProgress();
  }
}
