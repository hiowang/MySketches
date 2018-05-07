enum Dir{
  XMI,XPL,YMI,YPL,NONE;
}
int getDX(Dir d){
  if(d==Dir.XMI)return -1;
  if(d==Dir.XPL)return 1;
  return 0;
}
int getDY(Dir d){
  if(d==Dir.YMI)return -1;
  if(d==Dir.YPL)return 1;
  return 0;
}
Dir dirFromDXDY(int dx,int dy){
  if(dx==-1)return Dir.XMI;
  if(dx==1)return Dir.XPL;
  if(dy==-1)return Dir.YMI;
  if(dy==1)return Dir.YPL;
  return Dir.NONE;
}
Dir randDir(Cell c){
  int x=c.x;
  int y=c.y;
  Dir d=randDir();
  if(grid.outBounds(x+getDX(d),y+getDY(d)))return null;
  //while(grid.outBounds(x+getDX(d),y+getDY(d))){
    //d=randDir();
  //}
  return d;
}
Dir randDir(){
  int i=int(random(4));
  if(i==0)return Dir.XMI;
  if(i==1)return Dir.XPL;
  if(i==2)return Dir.YMI;
  if(i==3)return Dir.YPL;
  return Dir.NONE;
}