class Enemy extends Entity{
  
  Vec2[]points;
  int ind;
  
  Enemy(){
    super(width/2,100,color(0),color(0));
    ind=0;
    points=new Vec2[4];
    points[0]=new Vec2(100,100);
    points[1]=new Vec2(width-100,100);
    points[2]=new Vec2(width-100,height-100);
    points[3]=new Vec2(100,height-100);
  }
  
  void update(){
    if(frameCount%500==0){
      ind++;
      if(ind>=points.length)ind=0;
    }
    applyForce(box2d.coordPixelsToWorld(box2d.getBodyPixelCoord(body).sub(points[ind])));
  }
  
}