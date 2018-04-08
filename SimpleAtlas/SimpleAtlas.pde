size(512,512);

color grass = color(3,172,0);
color bg = color(234,60,212);
color dirt = color(117,83,32);
color stone = color(119,119,119);
color sand = color(255,178,127);
color woodside = color(89,37,5);
color woodtop = color(206,85,5);
color leaf = color(3,172,0);
color water = color(132,208,240,200);
color snow = color(250);
color flowergreen = color(0,136,72);
color flowerred = color(251,6,1);
color plant = color(3,172,0);
PGraphics img = createGraphics(512,512);

img.beginDraw();
img.noStroke();
//img.fill(bg);
//img.rect(0,0,512,512);

img.fill(grass);
img.rect(0,0,16,16);

img.fill(dirt);
img.rect(16,0,16,16);
img.fill(grass);
img.rect(16,0,16,5);

img.fill(dirt);
img.rect(32,0,16,16);

img.fill(stone);
img.rect(48,0,16,16);

img.fill(sand);
img.rect(64,0,16,16);

img.fill(woodside);
img.rect(80,0,16,16);

img.fill(woodtop);
img.rect(96,0,16,16);
img.fill(woodside);
img.rect(96,0,2,16);
img.rect(110,0,2,16);
img.rect(96,0,16,2);
img.rect(96,14,16,2);

img.fill(255,255,255,0);
img.rect(112,0,16,16);
for(int x=0;x<8;x++){
  for(int y=0;y<8;y++){
    if(!(x%2==0&&y%2==0)){
      println(x+" "+y);
      img.fill(leaf);
      img.rect(x*2+112,y*2,2,2);
    }
  }
}

img.fill(water);
img.rect(128,0,16,16);

img.fill(snow);
img.rect(144,0,16,16);

img.fill(flowergreen);
img.rect(160+6,8,2,8);
img.rect(160+3,12,3,2);
img.rect(160+8,10,3,2);

img.fill(flowerred);
img.rect(160+3,2,8,6);

img.fill(plant);
for(int x=0;x<8;x+=2){
  img.rect(x*2+176,4,2,12);
}

img.endDraw();

img.save("simpleatlas.png");

image(img,0,0,512,512);