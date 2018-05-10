int leftAlign=0, rightAlign=0;
int makeAlignLeft() {
  if (leftAlign==-1)return RIGHT;
  if (leftAlign==0)return CENTER;
  return LEFT;
}
int makeAlignRight() {
  if (rightAlign==-1)return BOTTOM;
  if (rightAlign==0)return BASELINE;
  if (rightAlign==1)return CENTER;
  return TOP;
}
String str_makeAlignLeft() {
  if (leftAlign==-1)return "RIGHT";
  if (leftAlign==0)return "CENTER";
  return "LEFT";
}
String str_makeAlignRight() {
  if (rightAlign==-1)return "BOTTOM";
  if (rightAlign==0)return "BASELINE";
  if (rightAlign==1)return "CENTER";
  return "TOP";
}


void setup() {
  size(512, 512);
  textFont(loadFont("Monospaced-30.vlw"));
}
void draw() {
  background(50);
  stroke(200, 200, 255);
  line(width/2, 0, width/2, height);
  line(0, height/2, width, height/2);
  textAlign(makeAlignLeft(), makeAlignRight());
  fill(200,255,200);
  stroke(200,255,200);
  ellipse(width/2,height/2,20,20);
  fill(255);
  stroke(255);
  text(str_makeAlignLeft()+", "+str_makeAlignRight(), width/2, height/2);
}
void keyPressed() {
  //if(key==CODED){
  if (key=='a') {
    if (leftAlign>-1)leftAlign--;
  }
  if(key=='d'){
    if(leftAlign<1)leftAlign++;
  }
  if(key=='w'){
    if(rightAlign>-1)rightAlign--;
  }
  if(key=='s'){
    if(rightAlign<2)rightAlign++;
  }
  //}
}