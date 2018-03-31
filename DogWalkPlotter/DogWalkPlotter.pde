class Day{
  String daystr,month,day;
  int numwalks,year;
}
Day[] days;
float max;
String[]strs;
void setup(){
  size(600,255);
  strs=loadStrings("../../../MyLogs/DogWalking.txt");
  //String[]strs=loadStrings("~/Documents/MyLogs/DogWalking.txt");
  pixelDensity(2);
  days=new Day[strs.length];
  max=0;
  for(int i=0;i<strs.length;i++){
    String[] split=strs[i].split(" ");
    Day d=new Day();
    d.daystr=split[0];
    d.month=split[1];
    d.day=split[2];
    d.year=parseInt(split[3]);
    d.numwalks=parseInt(split[5]);
    if(d.numwalks>max)max=d.numwalks;
    days[i]=d;
  }
  //rect(0,0,50,height);
  //rect(width-50,0,50,height);
}
void draw(){
  float w=500;
  pushMatrix();
  background(0);
  noFill();
  stroke(255);
  translate(50,10);
  stroke(100);
  float heightScale=10;
  float factor=w/(strs.length-1);
  for(int i=0;i<strs.length;i++){
    line(i*factor,-10,i*factor,height+10);
  }
  int selectedI=-1;
  beginShape();
  for(int i=0;i<strs.length;i++){
    stroke(255);
    vertex(i*factor,heightScale*max-days[i].numwalks*heightScale);
    if(mouseX>i*factor){
      selectedI=i;
    }
  }
  endShape();
  
  beginShape();
  fill(255);
  noFill();
  curveVertex(0,2*heightScale*max);
  for(int i=0;i<strs.length;i++){
    curveVertex(i*factor,-days[i].numwalks*10+2*heightScale*max);
  }
  curveVertex(w,2*heightScale*max);
  endShape();
  
  for(int i=0;i<strs.length;i++){
    //colorMode(HSB,100);
    //color c=color(map(days[i].numwalks,0,max,0,100),100,100);
    float val=map(days[i].numwalks,0,max,0,255);
    color c=color(val);
    fill(c);
    stroke(c);
    ellipseMode(CENTER);
    ellipse(i*factor,3.5*heightScale*max,min(factor,heightScale*max),min(factor,heightScale*max));
    fill(255-val);
    stroke(255-val);
    textAlign(CENTER,CENTER);
    textSize(10);
    text(""+days[i].numwalks,i*factor,3.5*heightScale*max);
  }
  for(int i=0;i<w;i++){
    //colorMode(HSB,100);
    strokeWeight(1.25);
    int num=(int)(i/factor);
    float val1=days[num].numwalks;
    float val2=days[num+1].numwalks;
    float val=lerp(val1,val2,(i%factor)/factor);
    //val=round(val*50)/50;
    val=map(val,0,max,0,255);
    stroke(val);
    line(i,4.5*heightScale*max-10,i,4.5*heightScale*max+10);
  }
  translate(-50,-10);
  fill(0);
  stroke(0);
  popMatrix();
  
  if(selectedI!=-1){
    pushMatrix();
    float val=map(days[selectedI].numwalks,0,max,0,255);
    fill(val);
    stroke(val);
    noCursor();
    translate(20,0);
    rect(mouseX-50,mouseY,60,40);
    fill(255-val);
    stroke(255-val);
    textAlign(LEFT,TOP);
    Day d=days[selectedI];
    textSize(10);
    text("Year:"+d.year,mouseX-50,mouseY);
    text("Month:"+d.month,mouseX-50,mouseY+10);
    text("Day:"+d.day,mouseX-50,mouseY+20);
    text("Day:"+d.daystr,mouseX-50,mouseY+30);
    popMatrix();
  }
}