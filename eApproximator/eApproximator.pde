void setup(){
  size(400,130);
  textFont(loadFont("Monospaced-20.vlw"));
  frameRate(5);
}
void draw(){
  background(255);
  fill(0);
  stroke(0);
  float sum=0;
  float times=0;
  for(int i=0;i<1000000;i++){
    
    float n=0;
    float a=0;
    while(a<1){
      n++;
      a+=random(1);
    }
    sum+=n;
    times++;
    
  }
  float myE=sum/times;
  textAlign(LEFT,CENTER);
  text("approx e="+myE+"\n       e=2.7182817\n  diff e="+abs(2.7182817-myE),width/5,height/2);
}