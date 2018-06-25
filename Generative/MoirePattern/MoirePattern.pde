
void setup(){
  size(500,500);
}
int spacing=30;
int maxnum=400;
int num=maxnum/spacing;
void draw(){
  background(255);
  for(int x=0;x<num;x++){
    for(int y=0;y<num;y++){
      pushMatrix();
      translate(width/2-maxnum/2,height/2-maxnum/2);
      stroke(0);
      line(x*spacing,0,x*spacing,maxnum);
      line(0,y*spacing,maxnum,y*spacing);
      popMatrix();
      pushMatrix();
      translate(width/2,height/2);
      rotate(frameCount*0.01);
      translate(5,0);
      translate(-maxnum/2,-maxnum/2);
      stroke(0);
      line(x*spacing,0,x*spacing,maxnum);
      line(0,y*spacing,maxnum,y*spacing);
      popMatrix();
    }
  }
}