void cantor(float x,float y,float w,float h,int i){
  //rect(x,y,w,h);
  if(i<=0){
    rect(x,y,w,h);
  }else{
    cantor(x,y, w/3,h/3,i-1);
    cantor(x+2*w/3,y, w/3,h/3,i-1);
    cantor(x,y+2*h/3, w/3,h/3,i-1);
    cantor(x+2*w/3,y+2*h/3,w/3,h/3,i-1);
  }
}
void setup(){
  size(500,500);
  background(255);
  noStroke();
  fill(0);
  cantor(0,0,width,height,5);
}