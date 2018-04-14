enum Dir{
  XMI,XPL,YMI,YPL,NONE;
}
Dir dirFromDXDY(int dx,int dy){
  if(dx==-1)return Dir.XMI;
  if(dx==1)return Dir.XPL;
  if(dy==-1)return Dir.YMI;
  if(dy==1)return Dir.YPL;
  return Dir.NONE;
}