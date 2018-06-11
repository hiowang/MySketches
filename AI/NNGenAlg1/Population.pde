class Population{
  ArrayList<Thing>things;
  int time=0;
  void init(){
    things=new ArrayList<Thing>();
  }
  void addRandPopulation(){
    for(int i=0;i<THINGS_PER_GEN;i++)things.add(new Thing());
  }
  void update(){
    time++;
    for(Thing t:things)t.update();
  }
  float percHit(){
    float n=0;
    for(Thing t:things)if(t.good)n++;
    return 100*n/things.size();
  }
  float percLoss(){
    float n=0;
    for(Thing t:things)if(t.dead)n++;
    return 100*n/things.size();
  }
  void display(){
    for(Thing t:things)t.display();
    Thing best=best();
    best.displayAsBest();
    fill(255);
    stroke(255);
    String str="Time: "+time+"\nPercentage hit:"+nf(percHit(),3,2)+"%\nPercentage loss: "+nf(percLoss(),3,2)+"%\nGen #: "+genNum+"\nFramerate: "+nf(frameRate,2,3);
    rect(0,0,textWidth(str)+2,50+2);
    fill(0);
    noStroke();
    textAlign(LEFT,TOP);
    text(str,2,2);
    
    for(int x=0;x<width;x+=30){
      for(int y=0;y<height;y+=30){
        Thing t=best.makeNew();
        t.x=x;
        t.y=y;
        int i=0;
        while(!t.good&&!t.dead&&i<200){
          i++;
          t.update();
        }
        t.drawPath();
      }
    }
  }
  Thing best(){
    Thing min=things.get(0);
    for(Thing t:things){
      if(t.good&&min.good){
        if(t.hitGoodTime<min.hitGoodTime)min=t;
      }else{//!t.good||!min.good
        if(t.dist<min.dist)min=t;
      }
    }
    return min;
  }
  Population makeNew(){
    genNum++;
    Population p=new Population();
    p.init();
    Thing min=best();
    for(int i=0;i<THINGS_PER_GEN;i++){
      Thing t=min.makeNew();
      t.vary();
      p.things.add(t);
    }
    p.things.add(min.makeNew());
    return p;
  }
}