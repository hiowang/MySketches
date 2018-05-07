import processing.video.*;

//Step 2. Declare a capture object.
Capture video;

void captureEvent(Capture video) {
  video.read();
}
void settings(){
  int s=4;
  size(320*s, 240*s);
}
void setup() {  

  // Step 3. Initialize Capture object.
  video = new Capture(this, 320, 240);

  // Step 4. Start the capturing process.
  video.start();
}

// Step 6. Display the image.

color grayscaleColor(float g){
  return rgbColor(g,g,g);
}
color rgbColor(float r,float g,float b){
  colorMode(RGB,100);
  color c=color(r,g,b);
  colorMode(HSB,100);
  return c;
}

void draw() { 
  background(0);
  video.read();
  float blevels=100;
  float slevels=100;
  float hlevels=100;
  float d=10;
  float xs=width/320;
  float ys=height/240;
  for(int x=0;x<320;x+=d){
    for(int y=0;y<240;y+=d){
      color col=video.get(x,y);
      color xmi=video.get(x-1,y);
      color xpl=video.get(x+1,y);
      color ymi=video.get(x,y-1);
      color ypl=video.get(x,y+1);
      
      float bxmi=brightness(xmi);
      float bxpl=brightness(xpl);
      float bymi=brightness(ymi);
      float bypl=brightness(ypl);
      
      float sxmi=saturation(xmi);
      float sxpl=saturation(xpl);
      float symi=saturation(ymi);
      float sypl=saturation(ypl);
      
      float hxmi=hue(xmi);
      float hxpl=hue(xpl);
      float hymi=hue(ymi);
      float hypl=hue(ypl);
      
      float b=brightness(col);
      float s=saturation(col);
      float h=hue(col);
      
      float bdiff=abs(bxmi-b)+abs(bxpl-b)+abs(bymi-b)+abs(bypl-b);
      float sdiff=abs(sxmi-s)+abs(sxpl-s)+abs(symi-s)+abs(sypl-s);
      float hdiff=abs(hxmi-h)+abs(hxpl-h)+abs(hymi-h)+abs(hypl-h);
      
      float diff=pow(2,bdiff+sdiff);
      
      float roundb=int(b/blevels)*blevels;
      float rounds=int(s/slevels)*slevels;
      float roundh=int(h/hlevels)*hlevels;
      
      //if(diff>7000000)
      //if(sdiff>10)
      //if(hdiff>100)
      //if(sdiff>50||hdiff>50)
        //col=grayscaleColor(diff);
      //else col=color(150,25,25);
      //float v=abs(noise(noise(x*0.01),noise(y*0.01))-0.5)*2;
      float v=1-abs(noise(x*0.01,y*0.01,frameCount*0.1)-0.5)*2;
      col=color(red(col)*v,green(col)*v,blue(col)*v);
      fill(col);
      stroke(col);
      rect(x*xs/d,y*ys/d,xs*d,ys*d);
    }
  }
  //video.read();
  //image(video, 0, 0,width,height);
}