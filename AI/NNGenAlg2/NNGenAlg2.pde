Population population;
ArrayList<Obstacle>obstacles;
PVector finalCenter;
float finalRad;
int genNum=0;

int THINGS_PER_GEN=500;
int TIME_PER_GEN=5000;
int UPDATES_PER_FRAME=1;
float NEURON_WEIGHTS_VARY=0.01;
float NEURON_OFFSET_VARY=0.01;
float POPULATION_PASS_MARGIN=10.0;
//take best thing and draw flow field of options for all positions on grid
//ArrayList of obstacles

void setup() {
  size(500, 500);
  textFont(loadFont("Monospaced-10.vlw"));
  population=new Population();
  population.init();
  population.addRandPopulation();
  //obstCenter=new PVector(width/2,height/2);
  //obstRad=50;
  obstacles=new ArrayList<Obstacle>();
  //obstacles.add(new Obstacle(width/2+30, height/2, 30));
  obstacles.add(new Obstacle(width/2-50, height/2, 100));
  finalCenter=new PVector(width/2, 50);
  finalRad=100;
}
void draw() {
  background(255);
  for (Obstacle o : obstacles)o.display();
  //stroke(0);
  //fill(255/2);
  //ellipse(obstCenter.x,obstCenter.y,obstRad*2,obstRad*2);
  //finalCenter.x=mouseX;
  //finalCenter.y=mouseY;
  obstacles.get(0).x=mouseX;
  obstacles.get(0).y=mouseY;
  stroke(0);
  fill(255);
  ellipse(finalCenter.x, finalCenter.y, finalRad*2, finalRad*2);
  for (int i=0; i<UPDATES_PER_FRAME; i++)population.update();
  population.display();
  if (population.time>=TIME_PER_GEN)population=population.makeNew();
}
void mousePressed() {
  population=population.makeNew();
}