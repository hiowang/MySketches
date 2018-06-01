class Face {
  PVector a, b, c, d;//clockwise;
  PVector normal;
  Face(PVector _1, PVector _2, PVector _3, PVector _4, boolean orig, PVector p){
    a=_1;
    b=_2;
    c=_3;
    d=_4;
    if (orig) {
      PVector u=PVector.sub(b, a);
      PVector v=PVector.sub(c, a);
      normal= new PVector(u.y*v.z-u.z*v.y, u.z*v.x - u.x*v.z, u.x*v.y - u.y*v.x).normalize();
      if(PVector.dot(normal,new PVector(0,0,0))<0)normal.mult(-1);
    } else {
      normal=p.copy();
    }
  }
  void display() {
    //fill(255);
    //noFill();
    stroke(0, 50);
    fill(255);
    beginShape();
    vertex(a.x, a.y, a.z);
    vertex(b.x, b.y, b.z);
    vertex(c.x, c.y, c.z);
    vertex(d.x, d.y, d.z);
    endShape(CLOSE);
    //stroke(0,10);
    //PVector abcd=PVector.add(a,PVector.add(b,PVector.add(c,d))).mult(0.25);
    //PVector normal=getNormal().setMag(50);
    //line(abcd.x,abcd.y,abcd.z,abcd.x+normal.x,abcd.y+normal.y,abcd.z+normal.z);
  }
  ArrayList<Face>divide() {
    ArrayList<Face>list=new ArrayList<Face>();
    //a=p1
    //b=p2
    //c=p3
    PVector ab=PVector.add(a, b).mult(0.5);
    PVector ad=PVector.add(a, d).mult(0.5);
    PVector bc=PVector.add(b, c).mult(0.5);
    PVector cd=PVector.add(c, d).mult(0.5);
    PVector abcd=PVector.add(a, PVector.add(b, PVector.add(c, d))).mult(0.25).add(jitter(jitAmount));
    PVector offed=PVector.add(abcd, PVector.mult(normal, random(-diff,diff)));
    list.add(new Face(a, ab, offed, ad, false, normal));
    list.add(new Face(ab, b, bc, offed, false, normal));
    list.add(new Face(offed, bc, c, cd, false, normal));
    list.add(new Face(ad, offed, cd, d, false, normal));
    return list;
  }
}
ArrayList<Face>faces;
void setup() {
  size(750, 750, P3D);
  initFaces();
}
float diff;
float rot=0;
float jitAmount;
void draw() {
  background(255);
  rot+=0.01;
  camera(500, 500, 500, 0, 0, 0, 0, 1, 0);
  ambientLight(20,20,20);
  pointLight(50,50,50,500,500,500);
  rotateY(rot);
  for (Face f : faces)f.display();
}
PVector jitter(float f){
  return new PVector(random(-f,f),random(-f,f),random(-f,f));
}
void iterate() {
  diff*=0.9;
  jitAmount*=0.9;
  ArrayList<Face>temp=new ArrayList<Face>();
  for (Face f : faces)temp.addAll(f.divide());
  faces.clear();
  faces.addAll(temp);
}
void keyPressed(){
  if(key==' ')initFaces();
}
void mousePressed() {
  iterate();
}
PVector pointOnSphere(float theta,float phi,float r){
  return new PVector(r*sin(theta)*cos(phi),r*sin(theta)*sin(phi),r*cos(theta));
}
void initFaces() {
  faces=new ArrayList<Face>();
  diff=50;
  jitAmount=20;
  float itersTheta=10,itersPhi=10;
  float dtheta=map(1,0,itersTheta,0,TWO_PI);
  float dphi=map(1,0,itersPhi,0,TWO_PI);
  float r=300;
  for(int theta=0;theta<itersTheta;theta++){
    for(int phi=0;phi<itersPhi;phi++){
      float thetaF=dtheta*theta;
      float phiF=dphi*phi;
      PVector a=pointOnSphere(thetaF,phiF,r);
      PVector b=pointOnSphere(thetaF+dtheta,phiF,r);
      PVector c=pointOnSphere(thetaF+dtheta,phiF+dphi,r);
      PVector d=pointOnSphere(thetaF,phiF+dphi,r);
      faces.add(new Face(a,b,c,d,true,null));
    }
  }
}