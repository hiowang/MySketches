class MazeGeneratorRecursiveBacktracker extends MazeGenerator {
  Grid generateMaze(int w, int h) {
    grid=new Grid(w, h);
    //ArrayList<Cell>finished=new ArrayList<Cell>();
    current=new PVector(0, 0);
    stack.add(current);
    //graphics=createGraphics(300,300);
    //graphics.beginDraw();
    //graphics.fill(255);
    //graphics.textAlign(LEFT,TOP);
    //graphics.textSize(50);
    //graphics.text("Hello World",-10,-10);
    //graphics.endDraw();
    //img=loadImage("LUL.png");
    //img=loadImage("fun.png");
    //img=loadImage("fun2.png");
    img=loadImage("world_map.png");
    return grid;
  }
  boolean first=true;
  boolean isValidPos(int x, int y) {
    return isValidPos(new PVector(x, y));
  }
  PImage img;

  color getCol(float x, float y) {
    return img.get(int(map(x, 0, grid.w, 0, img.width)), int(map(y, 0, grid.h, 0, img.height)));
  }

  PVector randDir() {
    ArrayList<PVector>valids=new ArrayList<PVector>();
    PVector a=new PVector(current.x-1, current.y);
    PVector b=new PVector(current.x+1, current.y);
    PVector c=new PVector(current.x, current.y-1);
    PVector d=new PVector(current.x, current.y+1);
    if (isValidPos(a))valids.add(new PVector(-1, 0));
    if (isValidPos(b))valids.add(new PVector(1, 0));
    if (isValidPos(c))valids.add(new PVector(0, -1));
    if (isValidPos(d))valids.add(new PVector(0, 1));
    if (valids.size()==0)return null;
    return valids.get(int(random(valids.size())));
  }
  boolean isValidRGB(float r, float g, float b) {
    if (b>200)return true;
    return false;
  }
  boolean isValidPos(PVector p) {
    if (visited.contains(p))return false;
    color col=getCol(p.x, p.y);
    //if (!isValidRGB(red(col), green(col), blue(col)))return false;
    if (p.x<0)return false;
    if (p.y<0)return false;
    if (p.x>grid.w-1)return false;
    if (p.y>grid.h-1)return false;
    return true;
  }
  //Edge getEdge(PVector a,PVector b){
  //}
  PVector unfixedRand() {
    int i=int(random(4));
    if (i==0)return new PVector(-1, 0);
    if (i==1)return new PVector(1, 0);
    if (i==2)return new PVector(0, -1);
    return new PVector(0, 1);
  }
  ArrayList<PVector> stack=new ArrayList<PVector>();
  ArrayList<PVector>visited=new ArrayList<PVector>();
  ArrayList<PVector>retraced=new ArrayList<PVector>();
  PVector current;
  boolean done=false;
  boolean isDone(){
    return stack.size()<1;
  }
  void update() {
    if(done)return;
    if (stack.size()<1) {

      for (int x=0; x<grid.w-1; x++) {
        for (int y=0; y<grid.h-1; y++) {
          //if(x==18&&y==33)continue;
          //println(x+" "+y);
          //if (!isValidPos(x+1, y))grid.setWall(x, y, Dir.XPL, true);
          //if (!isValidPos(x, y+1))grid.setWall(x, y, Dir.YPL, true);
        }
      }
      done=true;
      return;
    }
    int ix=int(current.x);
    int iy=int(current.y);

    PVector dir=randDir();
    //while(dir==null){
    if (dir==null) {
      dir=randDir();
      retraced.add(current.copy());
      current=stack.get(stack.size()-1).copy();
      stack.remove(stack.size()-1);
      return;
    }
    stack.add(current.copy());
    current.add(dir);

    visited.add(current.copy());
    grid.setWall(ix, iy, dirFromDXDY(int(dir.x), int(dir.y)), true);
    //if (dir.x==-1) {
    //  grid[ix-1][iy].right=true;
    //}
    //if (dir.x==1) {
    //  grid[ix][iy].right=true;
    //}
    //if (dir.y==-1) {
    //  grid[ix][iy-1].down=true;
    //}
    //if (dir.y==1) {
    //  grid[ix][iy].down=true;
    //}
  }
  void display() {
    fill(230,29,255);
    noStroke();
    rect(current.x*densX,current.y*densY,densX,densY);
    //image(img, 0, 0, width, height);
  }

  PVector getColorScalar() {
    return new PVector(0, 1, 1);
  }
}