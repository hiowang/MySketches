float[]vals;
float noiseRange=100000;
float numSamples=100000;
void setup() {
  size(1000, 900);
  frameRate(20);
}
void draw(){
  background(255);
  initVals();
  for(int i=0;i<numSamples;i++)vals[int(noise(random(noiseRange))*width)]++;
  normVals();
  displayVals(0  ,300);
  initVals();
  for(int i=0;i<numSamples;i++)vals[int(noise(random(noiseRange),random(noiseRange))*width)]++;
  normVals();
  displayVals(300,600);
  initVals();
  for(int i=0;i<numSamples;i++)vals[int(noise(random(noiseRange),random(noiseRange),random(noiseRange))*width)]++;
  normVals();
  displayVals(600,900);
  
  line(0,300,width,300);
  line(0,600,width,600);
}
void displayVals(float offY,float nextOff){
  for(int x=1;x<width;x++){
    colorMode(HSB,100);
    stroke(map(vals[x],0,height/3,0,100),100,100);
    colorMode(RGB,255);
    line(x,offY+vals[x],x,nextOff);
    stroke(0);
    line(x-1,vals[x-1]+offY,x,vals[x]+offY);
  }
}
void initVals(){
  vals=new float[width];
  for(int i=0;i<width;i++)vals[i]=0;
}
void normVals(){
  float max=0;
  for(int i=0;i<width;i++)if(vals[i]>max)max=vals[i];
  for(int i=0;i<width;i++)vals[i]=map(vals[i],0,max,height/3,0);
}