
ArrayList<Planet>planets;

void setup(){
  fullScreen();
  //size(1000,1000);
  planets=new ArrayList<Planet>();
  for(int i=0;i<1000;i++){
    planets.add(new Planet());
  }
}
ArrayList<Planet>toAdd;
ArrayList<Planet>toRem;
void draw(){
  background(255);
  toAdd=new ArrayList<Planet>();
  toRem=new ArrayList<Planet>();
  translate(width/2,height/2);
  scale(0.1);
  for(Planet p:planets){
    p.display();
    p.update();
  }
  planets.removeAll(toRem);
  planets.addAll(toAdd);
}