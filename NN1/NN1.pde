//TODO: connect 4 AI vs mommy
void setup() {
  size(500, 500);
  //mousePressed();
  //network.calc(new float[]{1,0});
  //println(network.getOutputs());
  for (int i=0; i<1000; i++) {
    nets.add(newNet());
  }
  //noLoop();
  //JSONObject obj=loadJSONObject("data.json");
  //Network n=networkFromJSON(obj);
  //float score=checkNetwork(n,false);
  //println("Loaded score: " + score);
  //frameRate(10);
}
Network newNet() {
  int numInputs=2;
  int numLayers=1;
  int numHidden=1;
  int numOutputs=1;
  return new Network(numInputs, numLayers, numHidden, numOutputs);
}
ArrayList<Network>nets=new ArrayList<Network>();
int scale=10;
float zoom=0.25;
float checkNetwork(Network nn, boolean printResults) {
  float error=0;
  //Result[][]res=new Result[10][10];
  int num=0;
  for (int x=0; x<20; x++) {
    for (int y=0; y<20; y++) {
      Result result=two2one(x,y,x-y);
      error+=nn.checkResult(result);
      num++;
    }
  }
  if(num>0)error/=num;
  if(printResults)print(error);
  return error;
}
Result two2one(float in1, float in2, float out1) {
  Result r=new Result();
  r.inputs=new float[]{in1, in2};
  r.outputs=new float[]{out1};
  return r;
}
void draw() {
  background(0);
  float lowestScore=Float.MAX_VALUE;
  Network net=newNet();
  for (Network n : nets) {
    float error=checkNetwork(n, false);
    if (error<lowestScore) {
      lowestScore=error;
      net=n;
    }
  }
  print(frameCount+" | ");
  print(lowestScore+" | ");
  checkNetwork(net, true);
  println();
  if(lowestScore<0.1){
    println("Done: " + lowestScore);
    JSONObject obj=net.toJSON();
    saveJSONObject(obj,"data/data.json");
    exit();
  }
  nets.clear();
  for (int i=0; i<1000; i++) {
    nets.add(net.vary(0.025));
  }
  //for(int x=0;x<3;x++){
    //for(int y=0;y<3;y++){
    //}
  //}
  //fill(255);
  //stroke(255);
  //float num=checkNetwork(network);
  //println(num);
  //text(num,30,30);
  //for(int i=0;i<width/scale;i++){
  //  for(int j=0;j<height/scale;j++){
  //    float rx=i-width/scale/2;
  //    float ry=j-height/scale/2;
  //    rx*=zoom;
  //    ry*=zoom;
  //    network.calc(new float[]{rx,ry,rx+ry,rx-ry,sin(rx),cos(rx)});
  //    float val=map(network.getOutputs()[0],-1,1,0,100);
  //    colorMode(HSB,100);
  //    color col=color(val,100,100);
  //    colorMode(RGB,255);
  //    fill(col);
  //    noStroke();
  //    rect(i*scale,j*scale,scale,scale);
  //  }
  //}
  //network=network.vary(0.025);
}