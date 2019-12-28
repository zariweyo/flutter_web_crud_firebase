class GenericError{
  String code="0000";
  String message="NO MESSAGE";
  Type origin=GenericError;

  GenericError({this.code,this.message,this.origin});

  @override
  String toString() {
    String _dev = "";
    _dev += "[CODE: "+code+"]";
    _dev += "[MESSAGE: "+message+"]";
    _dev += "[ORIGIN: "+origin.toString()+"]";
    return _dev;
  }

}