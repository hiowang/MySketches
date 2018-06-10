Population population;
PVector obstCenter;
float obstRad;
PVector finalCenter;
float finalRad;
int genNum=0;

int THINGS_PER_GEN=100;
int TIME_PER_GEN=5000;
int UPDATES_PER_FRAME=10;
float NEURON_WEIGHTS_VARY=0.1;
float NEURON_OFFSET_VARY=0.1;

void setup(){
  size(500,500);
  textFont(loadFont("Monospaced-10.vlw"));
  population=new Population();
  population.init();
  population.addRandPopulation();
  obstCenter=new PVector(width/2,height/2);
  obstRad=50;
  finalCenter=new PVector(width/2-150,100);
  finalRad=50;
}
void draw(){
  background(255);
  stroke(0);
  fill(255/2);
  ellipse(obstCenter.x,obstCenter.y,obstRad*2,obstRad*2);
  
  stroke(0);
  fill(255);
  ellipse(finalCenter.x,finalCenter.y,finalRad*2,finalRad*2);
  for(int i=0;i<UPDATES_PER_FRAME;i++)population.update();
  population.display();
  if(population.time>=TIME_PER_GEN)population=population.makeNew();
}
void mousePressed(){
  population=population.makeNew();
}