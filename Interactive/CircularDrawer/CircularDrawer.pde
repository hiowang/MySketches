void setup() {
  size(1500, 1000);
  background(255);
}
int mode=0;
float n=15;
void keyPressed() {
  if (key=='1')mode=0;
  if (key=='2')mode=1;
  if (key=='3')mode=2;
  if (key=='4')mode=3;
}
float lastX=0,lastY=0;
void draw() {
  //n=noise(frameCount*0.05)*20;
  if (mode==0) {
  } else if (mode==1) {
    fill(255, 50);
    rect(-1, -1, width+2, height+2);
  } else if (mode==2) {
    fill(255, 20);
    rect(-1, -1, width+2, height+2);
  } else if (mode==3) {
    fill(255, 10);
    rect(-1, -1, width+2, height+2);
  }
  stroke(0);
  if(key==' '&&keyPressed)return;
  float col=random(1);
  noFill();
  stroke(100,10);
  //set(0,0,0);
  float d=dist(mouseX,mouseY,width/2,height/2)*2;
  ellipse(width/2,height/2,d,d);
  for (int i=0; i<n; i++) {
    pushMatrix();
    translate(width/2, height/2);
    rotate(radians(360*i/n));
    //translate(width/2, height/2);
    float px=lastX;
    float py=lastY;
    
    float x=mouseX;
    float y=mouseY;
    float offx=-width/2;
    float offy=-height/2;
    px+=offx;
    py+=offy;
    x+=offx;
    y+=offy;
    d=dist(px, py, x, y)*5;
    colorMode(HSB, 100);
    stroke(col*100, 100, 100);
    colorMode(RGB, 255);
    line(px, py, x, y);
    popMatrix();
    //rotate(-2.0*i/PI/n);
    //translate(-width/2, -height/2);
  }
  noStroke();
  fill(0);
  rect(width/2-5,height/2-5,10,10);
  lastX=mouseX;
  lastY=mouseY;
}