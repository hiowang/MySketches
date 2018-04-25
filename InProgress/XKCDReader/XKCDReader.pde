String download(String s){
  return URLDownloader.getStr(s);
}
void setup(){
  size(1000,1000);
  JSONObject obj=loadJSONObject("data.json");
  println(download("https://xkcd.com/info.0.json"));
}
void draw(){
}