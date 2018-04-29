class GUIButton{
  color normCol,clickCol,hoverCol,strokeNorm,textCol;
  float x,y,w,h;
  String txt;
  float txtoffx,txtoffy;
  boolean isDropdown;
  GUIEvent event;
  //key bindings!!
  boolean keyPressedLast=false;
  ArrayList<Character>keys=new ArrayList<Character>();
  GUIButton(float x,float y,float w,float h,String txt,float txtoffx,float txtoffy){
    event=new GUIDefaultEvent();
    this.isDropdown=false;
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
    this.txt=txt;
    this.txtoffx=txtoffx;
    this.txtoffy=txtoffy;
    //fill=color(200);
    //bg=color(
    strokeNorm=color(255);
    normCol=color(0);
    clickCol=color(100);
    hoverCol=color(50);
    textCol=color(255);
  }
  void expandMenus(){
  }
  void hideMenus(){
  }
  void addKey(char k){
    keys.add(k);
  }
  void keyCheck(){
    if(!keyPressed&&keyPressedLast){
      if(keys.contains(key))event.happen();
    }
    keyPressedLast=keyPressed;
  }
  boolean hover=false,click=false;
  void display(){
    if(isDropdown){
      normCol=color(50);
      clickCol=color(150);
      hoverCol=color(100);
    }
    boolean prevClick=click;
    boolean prevHover=hover;
    hover=click=false;
    if(mouseX>x&&mouseY>y&&mouseX<x+w&&mouseY<y+h){
      if(mousePressed){
        click=true;
      }else{
        hover=true;
      }
    }
    if(!click&&prevClick){
      event.happen();
    }
    stroke(strokeNorm);
    fill(normCol);
    if(hover)fill(hoverCol);
    if(click)fill(clickCol);
    rect(x,y,w,h);
    fill(textCol);
    noStroke();
    textAlign(LEFT,TOP);
    text(txt,x+txtoffx,y+txtoffy);
    String chars="";
    for(char c:keys)chars+=Character.toUpperCase(c);
    textAlign(RIGHT,TOP);
    text(chars,x+w-txtoffx,y+txtoffy);
    textAlign(LEFT,TOP);
  }
}