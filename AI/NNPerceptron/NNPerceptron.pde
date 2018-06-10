class Generation{
  ArrayList<Network> nets=new ArrayList<Network>();
  FloatList scores=new FloatList();
  int num;
  Generation(int n){
    num=n;
    int numInputs=3;//point.x,point.y,line.start.x,line.start.y,line.end.x,line.end.y
    int numLayers=1;
    int numHidden=2;
    int numOutput=1;
    for(int i=0;i<num;i++){
      nets.add(new Network(numInputs, numLayers, numHidden, numOutput));
    }
  }
  Network getBest(){
    //return nets.get(scores.indexOf(scores.min()));
    float mi=scores.min();
    for(int i=0;i<scores.size();i++){
      if(scores.get(i)<=mi)return nets.get(i);
    }
    return null;
  }
  Generation makeNew(){
    Generation gen=new Generation(200);
    gen.nets.clear();
    Network best=getBest();
    for(int i=0;i<gen.num;i++){
      gen.nets.add(best.vary(0.1));
    }
    return gen;
  }
  void evalScores(){
    scores.clear();
    for(Network net:nets){
      float score=0;
      for(PVector p:points){
        //Result r=new Result();
        float[] inputs=new float[]{p.x*scalar,p.y*scalar,lineSlope/*,lineStart.x,lineStart.y,lineEnd.x,lineEnd.y*/};
        //r.outputs=new float[]{evalOutput(p)};
        //score+=net.checkResult(r);
        net.calc(inputs);
        float realOut=evalOutput(p);
        float out=net.out(0);
        if(out<0&&realOut<0){}
        else if(out>0&&realOut>0){}
        else {
          score+=abs(out);
        }
      }
      scores.append(score);
    }
  }
}
float evalOutput(PVector point){
  float lerpVal=map(point.x,0,width,0,1);
  float lineY=lerp(0,height,lerpVal)*lineSlope;
  return lineY<point.y?-1:1;
}
Generation curGen;
//PVector lineStart;
//PVector lineEnd;
float lineSlope=0.5;
ArrayList<PVector>points;
float scalar=1;
void setup(){
  size(500,500);
  //lineStart=new PVector(0,0);
  //lineEnd=new PVector(width,height);
  points=new ArrayList<PVector>();
  curGen=new Generation(20);
  for(int i=0;i<5000;i++){
    points.add(new PVector(random(width),random(height)));
  }
}
void keyPressed(){
  if(key=='n'){
    curGen=curGen.makeNew();
    println("Next generation");
  }
  if(key=='q'){
    lineSlope-=0.1;
  }
  if(key=='w'){
    lineSlope+=0.1;
  }
  if(key=='s'){
    JSONObject obj=curGen.getBest().toJSON();
    saveJSONObject(obj,"network.json");
    println("Saved network");
  }
  if(key=='o'){
    JSONObject obj=loadJSONObject("network.json");
    curGen.nets.add(networkFromJSON(obj));
    println("Loaded network");
  }
}
void draw(){
  background(255);
  stroke(255,0,0);
  line(0,0,width,height*lineSlope);
  stroke(0);
  //if(frameCount%10==0){
    //curGen=curGen.makeNew();
  //}
  curGen.evalScores();
  Network nn=curGen.getBest();
  //curGen=curGen.makeNewI
  for(PVector p:points){
    nn.calc(new float[]{p.x*scalar,p.y*scalar});
    if(nn.out(0)<0)fill(0);
    else if(nn.out(0)>0)fill(255);
    stroke(0);
    ellipse(p.x,p.y,5,5);
  }
}