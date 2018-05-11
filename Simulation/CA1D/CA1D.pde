boolean[] rules=new boolean[8];
void setup(){
  size(1024,1024);
  initRules(false);
}
void initRules(boolean wait){
  genNum=0;
  for(int i=0;i<8;i++){
    rules[i]=random(100)<50;
    print(rules[i]?1:0);
  }
  if(wait)try{Thread.sleep(5000);}catch(Throwable t){t.printStackTrace();}
  println();
  background(0);
  for(int i=0;i<width;i++){
    set(i,0,random(100)<50?color(255):color(0));
  }
}
void mousePressed(){
  initRules(false);
}
int genNum=0;
void draw(){
  for(int i=0;i<5;i++){
  genNum++;
  if(genNum>=height){
    initRules(true);
    genNum=0;
  }
  for(int x=0;x<width;x++){
    boolean b1=get(x-1,genNum-1)==color(255);
    boolean b2=get(x,genNum-1)==color(255);
    boolean b3=get(x+1,genNum-1)==color(255);
    int n=(b1?1:0)*4+(b2?1:0)*2+(b3?1:0);
    set(x,genNum,rules[n]?color(255):color(0));
  }}
}