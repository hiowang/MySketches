void settings(){
  size(987+pad*2,610+pad*2);
}
void setup(){
  textFont(loadFont("Monospaced-30.vlw"));
}
int pad=0;
void draw(){
  background(255);
  //drawBox(2,2,width-2,height-2);
  stroke(0);
  noFill();
  textSize(20);
  textAlign(LEFT,TOP);
  text("my phi="+(987.0/610.0)+"\nphi=1.6180339887\ndiff="+abs(1.6180339887-987.0/610),10,10);
  rect(pad/2,pad/2,width-pad,height-pad);
  translate(pad/2,pad/2);
  tx=ty=rot=0;
  drawBox(width-pad,height-pad);
  //rect(5,5,width-10,height-10);
}
float tx=0,ty=0;
float rot=0;
void drawBox(float w,float h){
  //a=h
  //a+b=w
  //b=w-h
  stroke(0);
  noFill();
  arc(h,h,h*2,h*2,radians(180),radians(270));
  if(w<10||h<10)return;
  if(w/2+h/2>20){
    pushMatrix();
    fill(0);
    stroke(0);
    textAlign(CENTER);
    textSize(max(w/15+h/15,12));
    //rotate(-rot);
    translate(tx+h/2,ty+h/2);
    rotate(-rot);
    text(""+int(w),0,0);
    popMatrix();
  }
  line(h,0,h,h);
  translate(w,0);
  rotate(radians(90));
  rot+=radians(90);
  //pushMatrix();
  //ellipse(tx,ty,10,10);
  //popMatrix();
  drawBox(h,w-h);
}