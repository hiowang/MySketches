import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
Box2DProcessing box2d;

Theme lightTheme=new Theme(color(50,150),color(255),color(200));
Theme darkTheme=new Theme(color(255,150),color(0),color(100));
Theme theme=darkTheme;
//Theme theme=lightTheme;

//Have option for toggling display of convex hull of points
ArrayList<Mass>masses=new ArrayList<Mass>();
ArrayList<Boundary>bounds=new ArrayList<Boundary>();
ArrayList<Edge>edges=new ArrayList<Edge>();
void addEdge(Mass a,Mass b,float d,float t){
  edges.add(new Edge(a,b,d,t));
}
void setup(){
  size(600,600);
  textFont(loadFont("Monospaced-10.vlw"));
  initGUI();
  
  
  box2d=new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0,-100);
  for(int i=0;i<300;i++)masses.add(new Mass(random(100,width-100),random(200),10,true));
  for(int i=0;i<masses.size();i++){
    for(int j=i+1;j<masses.size();j++){
      if(random(100)<0.1)addEdge(masses.get(i),masses.get(j),100,1);
    }
  }
  //for(int i=0;i<10;i++)edges.add(new Edge(masses.get(int(random(masses.size()))),masses.get(int(random(masses.size()))),100));
  float bWidth=5;
  bounds.add(new Boundary(width/2,height-bWidth,width,bWidth*2));
  bounds.add(new Boundary(bWidth,height/2,bWidth*2,height));
  bounds.add(new Boundary(height-bWidth,height/2,bWidth*2,height));
  
}
void draw(){
  updateGUI();
  background(theme.bgColor);
  box2d.step();
  for(Mass m:masses)m.display();
  for(Edge e:edges)e.display();
  for(Boundary b:bounds)b.display();
  displayGUI();
}