void setup(){
  size(500,210);
  col=color(random(255),random(255),random(255));
  textFont(loadFont("Monospaced-20.vlw"));
}
color col;
void draw(){
  background(0);
  //translate(width/2,height/2);
  drawColor(col);
}
void keyPressed(){
  if(key==' ')col=color(random(255),random(255),random(255));
}
void drawColor(color c){
  noStroke();
  //stroke(
  fill(c);
  rect(200,0,width-200,30);
  fill(255);
  text("         color:",2,2);
  translate(0,30);
  fill(255-red(c),255-green(c),255-blue(c));
  rect(200,0,width-200,30);
  colorMode(RGB,255);
  float r=red(c);
  float g=green(c);
  float b=blue(c);
  for(int x=0;x<255;x++){
    fill(x,g,b);
    rect(200+map(x,0,255,0,width-200),30,map(2,0,255,0,width-200),30);
    fill(r,x,b);
    rect(200+map(x,0,255,0,width-200),60,map(2,0,255,0,width-200),30);
    fill(r,g,x);
    rect(200+map(x,0,255,0,width-200),90,map(2,0,255,0,width-200),30);
    //fill(255-r,255-g,255-b);
    //rect(200+map(x,0,255,0,width-200),120,map(2,0,255,0,width-200),30);
  }
  fill(255-r,255-g,255-b);
  rect(200,120,width-200,30);
  colorMode(HSB,255);
  float h=hue(c);
  float s=saturation(c);
  b=brightness(c);
  for(int x=0;x<255;x++){
    fill(h,x,b);
    rect(200+map(x,0,255,0,width-200),120,map(2,0,255,0,width-200),30);
    fill(h,s,x);
    rect(200+map(x,0,255,0,width-200),150,map(2,0,255,0,width-200),30);
  }
  
  textAlign(LEFT,TOP);
  fill(255);
  stroke(255);
  text("       inverse:",2,2);
  text("  R(GB) varied:",2,32);
  text("(R)G(B) varied:",2,62);
  text("  (RG)B varied:",2,92);
  text("(H)S(B) varied:",2,122);
  text("  (HS)B varied:",2,152);
}