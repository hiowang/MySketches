class Branch {
  PVector a, b;
  float alpha;
  boolean leaf=false;
  Branch(PVector a, PVector b, float alpha) {
    //a=new PVector(x1, y1, z1);
    //b=new PVector(x2, y2, z2);
    this.a=a;
    this.b=b;
    this.alpha=alpha;
    if(alpha<50)leaf=random(100)<10;
  }
  void display() {
    if (alpha>50) {
      stroke(#895824, alpha);
      line(a.x+offx, -a.y, a.z+offz, b.x+offx, -b.y, b.z+offz);
    }else if(leaf){
      translate(b.x+offx,-b.y,b.z+offz);
      fill(0,255,0);
      stroke(0,255,0);
      box(5);
      translate(-b.x-offx,b.y,-b.z-offz);
    }
  }
  ArrayList<Branch>makeNew() {
    ArrayList<Branch>list=new ArrayList<Branch>();
    if(leaf)return list;
    int numNew=int(random(1, 10));
    for (int i=0; i<numNew; i++) {
      //PVector newTip=new PVector(a.x+random(-50,50),a.y-100,a.z+random(-50,50));
      PVector offset=new PVector(random(-50, 50), random(100), random(-50, 50));
      Branch newB=new Branch(PVector.add(a, offset), a, alpha-50);
      //Branch newB=new Branch(newTip.x,newTip.y,newTip.z,a.z,a.y,a.z,alpha-10);
      //Branch newB=new Branch(a.x+random(-50, 50), a.y-20, a.z+random(-50, 50), alpha-10,a.x, a.y, a.z);
      list.add(newB);
    }
    return list;
  }
}