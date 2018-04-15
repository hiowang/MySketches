
ArrayList<Tree>trees=new ArrayList<Tree>();
void setup() {
  size(500, 500, P3D);
  for(int x=0;x<w*h;x++){
    trees.add(new Tree());
  }
}
void mousePressed(){
  for(Tree t:trees)t.iterate();
}
float rot=0;
float offx=0;
float offz=0;
float w=7;
float h=7;
float spacing=400;
void draw() {
  background(255);
  camera(1000, -1000, 1000, 0, 0, 0, 0, 1, 0);
  //rot+=0.01;
  int x=0;
  int y=0;
  for(Tree t:trees){
    if(x>=5){
      x=0;
      y++;
    }
    x++;
    translate(spacing*x-spacing*w/2,0,spacing*y-spacing*h/2);
    //offx=50*x;
    //offz=50*y;
    rotateY(rot);
    t.display();
    rotateY(-rot);
    translate(-spacing*x+spacing*w/2,0,-spacing*y+spacing*h/2);
  }
  //rotateY(rot);
  fill(225);
  stroke(0);
  beginShape();
  float a=spacing*w/2;
  float b=spacing*h/2;
  vertex(-a,0,b);
  vertex(-a,0,-b);
  vertex(a,0,-b);
  vertex(a,0,b);
  endShape(CLOSE);
  //rotateY(-rot);
}