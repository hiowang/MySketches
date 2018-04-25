PImage map;
void initMap(String s) {
  map=loadImage(s);
}
void settings() {
  //map=loadImage("world_map.png");
  //map=loadImage("maze.png");
  //initMap("world_map_large_rivers.png");
  //initMap("canadian_flag.png");
  //initMap("lines.png");
  //initMap("flatlands.png");
  //initMap("fun.png");
  //initMap("trimmed_blue_eyes.png");
  initMap("trimmed.png");
  
  lastAtPos=new int[map.width][map.height];
  for (int x=0; x<map.width; x++) {
    for (int y=0; y<map.height; y++) {
      lastAtPos[x][y]=-1;
    }
  }
  size(map.width, map.height);
}
int[][]lastAtPos;
int totalColID=0;
ArrayList<Person>newPeople=new ArrayList<Person>();
ArrayList<Person>people=new ArrayList<Person>();
void setup() {
  //for (int i=0; i<30; i++) {
    //addColony(false);
  //}
  image(map, 0, 0, width, height);
}
void addColony(boolean mouse) {
  int x=int(random(width));
  int y=int(random(height));
  while (!isLand(x, y)||isOcean(x, y)) {
    x=int(random(width));
    y=int(random(height));
  }
  if (mouse) {
    x=mouseX;
    y=mouseY;
  }
  color col=color(random(255), random(100), random(255));
  totalColID++;
  float strength=random(0, 3);
  for (int j=0; j<100; j++) {
    Person p=new Person();
    p.strength=strength+random(-1, 1);
    p.colID=totalColID-1;
    p.alive=true;
    p.repro=random(0, 0.2);
    p.x=x;
    p.y=y;
    p.col=col;
    //p.diseased=false;
    //if(random(100)<0.1)p.diseased=true;
    p.age=0;
    people.add(p);
  }
}
void mousePressed() {
  addColony(true);
}
void draw() {
  if(frameCount%2==0&&totalColID<10)addColony(false);
  background(0);
  image(map, 0, 0, width, height);
  //fill(255,20);
  //rect(0,0,width,height);
  newPeople.clear();
  for (int i=0; i<simSpeed; i++) {
    for (Person person : people) {
      if (!person.alive)continue;
      person.update();
      fill(person.col);
      noStroke();
      //if(person.diseased)fill(255,0,0);
      rect(person.x, person.y, 10, 10);
      //set(person.x,person.y,person.col);
    }
    removeDead();
    people.addAll(newPeople);
  }
  if(hideStats)return;
  float[]strengths=new float[totalColID];
  float[]xs=new float[totalColID];
  float[]ys=new float[totalColID];
  color[]cols=new color[totalColID];
  float[]numPPL=new float[totalColID];
  for (Person p : people) {
    strengths[p.colID]+=p.strength/people.size();
    xs[p.colID]+=float(p.x)/numPPLCol(p.colID);
    ys[p.colID]+=float(p.y)/numPPLCol(p.colID);
    cols[p.colID]=p.col;
    numPPL[p.colID]=numPPLCol(p.colID);
  }
  for(int i=0;i<totalColID;i++){
    for(int j=0;j<totalColID;j++){
      if(strengths[i]*numPPL[i]>strengths[j]*numPPL[j]){
        strengths=swap(strengths,i,j);
        xs=swap(xs,i,j);
        ys=swap(ys,i,j);
        cols=swap(cols,i,j);
        numPPL=swap(numPPL,i,j);
      }
    }
  }
  fill(255);
  stroke(255);
  strokeWeight(5);
  rect(0, 0, 250, height);
  for (int i=0; i<totalColID; i++) {
    if (strengths[i]==0)continue;
    stroke(cols[i]);
    strokeWeight(5);
    //if (lastAtPos[int(mouseX/5)][int(mouseY/5)]==i)line(100, 12+20*i, xs[i], ys[i]);
  }
  int y=0;
  for (int i=0; i<totalColID; i++) {
    fill(cols[i]);
    noStroke();
    textAlign(LEFT, TOP);
    textSize(20);
    if (strengths[i]==0)continue;
    text(nfs(strengths[i], 1, 2)+":"+nf(int(numPPL[i]), 4), 2, 2+y);
    rect(152, 2+y, 100, 20);
    if(mouseX>152&&mouseY>2+y&&mouseX<152+100&&mouseY<22+y){
      stroke(cols[i]);
      strokeWeight(5);
      line(252,12+y,xs[i],ys[i]);
      strokeWeight(1);
    }
    y+=30;
  }
  //for(int x=0;x<map.width;x++){for(int a=0;a<map.height;a++){
  //if(lastAtPos[x][y]==-1)continue;
  //fill(cols[lastAtPos[x][y]]);
  //rect(map(x,0,map.width,0,width),map(a,0,map.height,0,height),10,10);
  //}}
}
color[]swap(color[]arr,int i,int j){
  color temp=arr[i];
  arr[i]=arr[j];
  arr[j]=temp;
  return arr;
}
float[]swap(float[]arr,int i,int j){
  float temp=arr[i];
  arr[i]=arr[j];
  arr[j]=temp;
  return arr;
}
int numPPLCol(int id) {
  int n=0;
  for (Person p : people)if (p.colID==id)n++;
  return n;
}
void removeDead() {
  for (Person p : people) {
    if (!p.alive) {
      people.remove(p);
      removeDead();
      return;
    }
  }
}
boolean hideStats=false;
int simSpeed=1;
void keyPressed(){
  if(key=='s')hideStats=!hideStats;
}
color getPixel(int x, int y) {
  return map.get(x, y);
}

boolean isLand(int x, int y) {
  return getPixel(x, y)==color(0, 255, 0);
}
boolean isOcean(int x, int y) {
  return getPixel(x, y)==color(0, 0, 255);
}