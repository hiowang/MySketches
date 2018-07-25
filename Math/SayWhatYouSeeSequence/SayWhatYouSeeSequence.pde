String compute(String str) {
  String s="";
  char curNum=str.charAt(0);
  int runLength=0;
  for (int i=0; i<str.length(); i++) {
    if (str.charAt(i)==curNum)runLength++;
    else {
      s+=runLength;
      s+=curNum;
      curNum=str.charAt(i);
      runLength=1;
    }
  }
  s+=runLength;
  s+=curNum;
  //if (num==1)return 11;
  return s;
}
void setup() {
  size(100,100);
  String s="1";
  background(0);
  int n=40;
  String[]strs=new String[n];
  int[]nums=new int[n];
  int maxInd=0;
  for (int i=0; i<n; i++) {
    println(s);
    strs[i]=s;
    nums[i]=s.length();
    if(nums[i]>nums[maxInd])maxInd=i;
    s=compute(s);
  }
  noFill();
  stroke(255);
  beginShape();
  for(int i=0;i<n;i++){
    vertex(map(i,0,n,0,width),map(nums[i],0,nums[maxInd],0,height));
  }
  endShape();
}