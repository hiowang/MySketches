interface GUIEvent{
  void happen();
}
class GUIDefaultEvent implements GUIEvent{
  void happen(){
  }
}
class GUIPrintEvent implements GUIEvent{
  String str;
  GUIPrintEvent(String s){
    str=s;
  }
  void happen(){
    println(str);
  }
}