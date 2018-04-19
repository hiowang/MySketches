ArrayList<Cell>removeNull(ArrayList<Cell>list){
  while(list.contains(null))list.remove(null);
  return list;
}
Dir aToB(Cell a,Cell b){
  return dirFromDXDY(b.x-a.x,b.y-a.y);
}
Dir randDir(ArrayList<Dir>dirs){
  return dirs.get(int(random(dirs.size())));
}
Cell pickRandom(ArrayList<Cell>list){
  if(list.size()==0)return null;
  Cell c=list.get(int(random(list.size())));
  if(c==null)return pickRandom(list);
  return c;
}
boolean chanceEven(){
  return chanceTrue(0.5);
}
boolean chanceTrue(float probTrue){
  return random(1)<probTrue;
}
boolean chanceFalse(float probFalse){
  return !chanceTrue(probFalse);
}