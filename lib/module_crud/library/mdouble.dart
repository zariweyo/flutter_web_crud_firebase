class MDouble{
  double value;
  MDouble(this.value);
  get(){
    return value;
  }  

  set(double _v){
    value=_v;
  }

  @override
  String toString() {
    return value.toString();
  }
}