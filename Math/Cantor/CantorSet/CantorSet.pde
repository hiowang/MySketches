
float numiters=10;
float offset=2;

void cantor(float x,float w,float y){
  rect(x,y,w,height/(numiters+offset));
  if(y<=height+height/numiters){
    cantor(x,w/3,y+height/numiters);
    cantor(x+2*w/3,w/3,y+height/numiters);
  }
}

void setup(){
  size(500,500);
  background(255);
  noStroke();
  fill(0);
  cantor(0,width,0);
}