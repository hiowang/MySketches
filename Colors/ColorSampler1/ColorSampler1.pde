void setup(){
  size(500,500,P3D);
  background(0);
}
void draw(){
  float zoom=1.5;
  float eyex=300*zoom;
  float eyey=255*zoom;
  float eyez=200*zoom;
  //center is where the camera is looking
  float centerx=0;
  float centery=0;
  float centerz=0;
  //up is the up vector
  float upx=0;
  float upy=1;
  float upz=0;
  camera(eyex, eyey, eyez, centerx, centery, centerz, upx, upy, upz);
  //camera(-255/2,200,600,0,0,0,0,1,0);
  for(int i=0;i<10;i++){
  PVector a=randPos();
  PVector b=PVector.add(a,PVector.random3D().mult(50));
  stroke(a.x,a.y,a.z);
  fill(a.x,a.y,a.z);
  //pushMatrix();
  //translate(a.x,a.y,a.z);
  //box(10);
  //popMatrix();
  line(a.x,a.y,a.z,b.x,b.y,b.z);}
  //noFill();
  //noStroke();
  //stroke(0);
  //box(255);
  
}
PVector randPos(){
  return new PVector(random(255),random(255),random(255));
}