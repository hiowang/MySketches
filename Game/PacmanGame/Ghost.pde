abstract class Ghost extends Entity {

  abstract color getColor();
  abstract Node getCorner();

  Ghost() {
    offX=0;
    offY=0;
    gridX=13-1;
    gridY=23+6;
  }
  int getSpeed(){
    if(scared)return 1;
    return 2;
  }
  int maxScareCounter=700;
  int maxDeadCounter=200;
  void display() {
    if (dead&&deadCounter<maxDeadCounter-100)return;
    calcPath();
    if(dead)fill(red(getColor()),green(getColor()),blue(getColor()),map(deadCounter,maxDeadCounter-200,maxDeadCounter,0,255));
    else fill(getColor());
    if (scared){
      fill(0, 0, 255);
      if(scaredCounter>maxScareCounter-100){
        if(scaredCounter%20<10)fill(255);
      }
    }
    noStroke();
    rect(gridX*cellSize+offX, gridY*cellSize+offY, cellSize, cellSize);
    if(dead)return;
    fill(getColor());
    if (debugGhostTargets) {
      Node t=getRealTarget();
      int r=6;
      rect(t.x*cellSize+cellSize/2-r/2, t.y*cellSize+cellSize/2-r/2, r, r);
    }
    if (debugGhostPaths) {
      debugPath(getColor(), path);
    }
  }

  abstract Node getTarget();
  Node getRealTarget() {
    if (scatterMode)return getCorner();
    return getTarget();
  }

  void update() {
    super.update();
    //int i=0;
    //while (i<5&&!canGoInDir(getDir())) {
    //curDir=rotateDir(curDir);
    //i++;
    //}
    //Dir d0=curDir;
    //Dir newDir=curDir;
    //int i=0;
    //while(!canGoInDir(newDir)||d0==oppositeDir(newDir)){
    //  newDir=rotateDir(newDir);
    //  i++;
    //}
    //curDir=newDir;
    if (scared) {
      if (scaredCounter>maxScareCounter) {
        scared=false;
        flip();
      } else {
        scaredCounter++;
      }
    } else {
      scaredCounter=0;
    }
    if (dead) {
      offX=0;
      offY=0;
      if (deadCounter>maxDeadCounter) {
        dead=false;
        gridX=ghostX;
        gridY=ghostY;
        offX=0;
        offY=0;
        curDir=Dir.L;
      } else {
        deadCounter++;
      }
    } else {
      deadCounter=0;
    }
  }
  ArrayList<Node>path=new ArrayList<Node>();
  void calcPath() {
    path=aStar(oppositeDir(curDir), new Node(gridX, gridY), nearestOpen(getRealTarget()));
  }
  void flip() {
    offX=0;
    offY=0;
    curDir=oppositeDir(curDir);
  }
  boolean scared=false;
  int scaredCounter=0;
  void scare() {
    offX=0;
    offY=0;
    scared=true;
    scaredCounter=0;
  }
  int deadCounter=0;
  boolean dead=false;
  void die() {
    gridX=ghostX;
    gridY=ghostY;
    dead=true;
    scared=false;
    scaredCounter=0;
    deadCounter=0;
  }
  Dir getDir() {
    //Dir d=curDir;
    //calcPath();
    //if (path.size()==0)return curDir;
    //Node n0=path.get(0);
    //if (path.size()<2)d=curDir;
    //else {
    //  Node n1=path.get(1);
    //  d=dirFromNodes(n0, n1);
    //  if (d==Dir.NONE)d=curDir;
    //}
    //while (!canGoInDir(d)||d==oppositeDir(curDir))d=rotateDir(d);
    Node target=getRealTarget();
    Node pos=new Node(gridX, gridY);
    Dir d=Dir.NONE;
    int dx=target.x-pos.x;
    int dy=target.y-pos.y;
    int m=max(abs(dx), abs(dy));
    if (m==abs(dx)) {
      if (target.x>pos.x)d=Dir.R;
      else d=Dir.L;
    } else {
      if (target.y>pos.y)d=Dir.D;
      else d=Dir.U;
    }
    if (scared) {
      int i=int(random(4));
      if (i==0)d=Dir.L;
      if (i==1)d=Dir.R;
      if (i==2)d=Dir.U;
      if (i==3)d=Dir.D;
    }
    int i=0;
    while ((!canGoInDir(d)||d==oppositeDir(curDir))&&i<10) {
      if (d==Dir.U)d=Dir.L;
      else if (d==Dir.L)d=Dir.D;
      else if (d==Dir.D)d=Dir.R;
      else if (d==Dir.R)d=Dir.U;
      i++;
    }
    if (i>4) {
      d=curDir;
    }
    return d;
  }
}