int tileW = 64;
int tileH = 64;
PGraphics gr;
void setup() {
  size(1024, 1024);
  gr=createGraphics(2048, 2048);
  gr.noSmooth();
  gr.beginDraw();

  //drawImage("grass/grass_top.png", 0, 0);
  ////1,0 is reserved for grass_side.png
  //drawImage("grass/snow.png", 2, 0);
  //drawImage("grass/snowSideDownloaded.png", 3, 0);
  //drawImage("grass/grass_path_top.png", 4, 0);
  //drawImage("grass/grass_path_side.png", 5, 0);
  //drawImage("grass/dirtDownloaded.jpg", 6, 0);
  //drawImage("mycelium/mycelium_top.png", 7, 0);
  //drawImage("mycelium/mycelium_side.png", 8, 0);
  //drawImage("farmland/farmland_wet.png", 9, 0);
  //drawImage("farmland/farmland_dry.png", 10, 0);
  //drawImage("grass/clay.png", 11, 0);
  ////logs
  //drawImage("log/log_birch.png", 0, 1);
  //drawImage("log/log_birch_top.png", 1, 1);

  //drawImage("log/log_spruce.png", 0, 2);
  //drawImage("log/log_spruce_top.png", 1, 2);

  //drawImage("log/log_big_oak.png", 0, 3);
  //drawImage("log/log_big_oak_top.png", 1, 3);

  //drawImage("log/log_jungle.png", 0, 4);
  //drawImage("log/log_jungle_top.png", 1, 4);

  //drawImage("log/log_acacia.png", 0, 5);
  //drawImage("log/log_acacia_top.png", 1, 5);

  //drawImage("log/log_oak.png", 0, 6);
  //drawImage("log/log_oak_top.png", 1, 6);
  ////end logs

  ////planks
  //drawImage("planks/planks_birch.png", 2, 1);
  //drawImage("planks/planks_spruce.png", 2, 2);
  //drawImage("planks/planks_big_oak.png", 2, 3);
  //drawImage("planks/planks_jungle.png", 2, 4);
  //drawImage("planks/planks_acacia.png", 2, 5);
  //drawImage("planks/planks_oak.png", 2, 6);
  ////end planks

  ////sapling
  //drawImage("plants/sapling/sapling_birch.png", 3, 1);
  //drawImage("plants/sapling/sapling_spruce.png", 3, 2);
  //drawImage("plants/sapling/sapling_roofed_oak.png", 3, 3);
  //drawImage("plants/sapling/sapling_jungle.png", 3, 4);
  //drawImage("plants/sapling/sapling_acacia.png", 3, 5);
  //drawImage("plants/sapling/sapling_oak.png", 3, 6);
  ////end sapling

  ////leaves
  //drawImage("plants/leaves/leaves_birch.png", 4, 1);
  //drawImage("plants/leaves/leaves_spruce.png", 4, 2);
  //drawImage("plants/leaves/leaves_big_oak.png", 4, 3);
  //drawImage("plants/leaves/leaves_jungle.png", 4, 4);
  //drawImage("plants/leaves/leaves_acacia.png", 4, 5);
  //drawImage("plants/leaves/leaves_oak.png", 4, 6);
  ////end leaves

  ////door
  //drawImage("door/door_birch_upper.png", 5, 1);
  //drawImage("door/door_birch_lower.png", 6, 1);

  //drawImage("door/door_spruce_upper.png", 5, 2);
  //drawImage("door/door_spruce_lower.png", 6, 2);

  //drawImage("door/door_dark_oak_upper.png", 5, 3);
  //drawImage("door/door_dark_oak_lower.png", 6, 3);

  //drawImage("door/door_jungle_upper.png", 5, 4);
  //drawImage("door/door_jungle_lower.png", 6, 4);

  //drawImage("door/door_acacia_upper.png", 5, 5);
  //drawImage("door/door_acacia_lower.png", 6, 5);

  //drawImage("door/door_wood_upper.png", 5, 6);
  //drawImage("door/door_wood_lower.png", 6, 6);
  ////end door

  ////mushroom red
  //drawImage("mushroom/mushroom_red.png", 0, 7);
  //drawImage("mushroom/mushroom_block_skin_red.png", 0, 8);
  //drawImage("mushroom/mushroom_brown.png", 1, 7);
  //drawImage("mushroom/mushroom_block_skin_brown.png", 1, 8);
  //drawImage("mushroom/mushroom_block_skin_stem.png", 0, 9);
  //drawImage("mushroom/mushroom_block_inside.png", 1, 9);
  ////end mushroom red

  ////stone
  ////TODO: sort stone images
  //drawImage("stone/stone.png", 31, 0);
  //drawImage("stone/cobblestone.png", 31, 1);
  //drawImage("stone/cobblestone_mossy.png", 31, 2);
  //drawImage("stone/stone_diorite.png", 31, 3);
  //drawImage("stone/stone_granite.png", 31, 4);
  //drawImage("stone/stone_andesite.png", 31, 5);
  //drawImage("stone/stone_slab_top.png", 31, 6);
  //drawImage("stone/stone_slab_side.png", 31, 7);
  //drawImage("stone/gravel.png", 31, 8);
  //drawImage("stone/stone_andesite_smooth.png", 31, 9);
  //drawImage("stone/stone_diorite_smooth.png", 31, 10);
  //drawImage("stone/stone_granite_smooth.png", 31, 11);
  //drawImage("stone/stonebrick_cracked.png", 31, 12);
  //drawImage("stone/stonebrick.png", 31, 13);
  //drawImage("stone/stonebrick_mossy.png", 31, 14);
  //drawImage("stone/stonebrick_carved.png", 31, 15);
  ////end stone

  ////flower
  //drawImage("plants/flower/flower_rose.png", 30, 0);
  //drawImage("plants/flower/flower_tulip_white.png", 29, 0);
  //drawImage("plants/flower/flower_tulip_red.png", 28, 0);
  //drawImage("plants/flower/flower_tulip_pink.png", 27, 0);
  //drawImage("plants/flower/flower_tulip_orange.png", 26, 0);
  //drawImage("plants/flower/flower_paeonia.png", 25, 0);
  //drawImage("plants/flower/flower_pot.png", 24, 0);
  //drawImage("plants/flower/flower_oxeye_daisy.png", 23, 0);
  //drawImage("plants/flower/flower_houstonia.png", 22, 0);
  //drawImage("plants/flower/flower_dandelion.png", 21, 0);
  //drawImage("plants/flower/flower_blue_orchid.png", 20, 0);
  //drawImage("plants/flower/flower_allium.png", 19, 0);
  ////end flower

  ////double
  //drawImage("plants/double/double_plant_syringa_top.png", 30, 1);
  //drawImage("plants/double/double_plant_syringa_bottom.png", 30, 2);

  //drawImage("plants/double/double_plant_rose_top.png", 29, 1);
  //drawImage("plants/double/double_plant_rose_bottom.png", 29, 2);

  //drawImage("plants/double/double_plant_sunflower_top.png", 28, 1);
  //drawImage("plants/double/double_plant_sunflower_bottom.png", 28, 2);

  //drawImage("plants/double/double_plant_syringa_top.png", 27, 1);
  //drawImage("plants/double/double_plant_syringa_bottom.png", 27, 2);

  //drawImage("plants/double/double_plant_grass_top.png", 26, 1);
  //drawImage("plants/double/double_plant_grass_bottom.png", 26, 2);

  //drawImage("plants/double/double_plant_fern_top.png", 25, 1);
  //drawImage("plants/double/double_plant_fern_bottom.png", 25, 2);

  //drawImage("plants/double/double_plant_paeonia_top.png", 24, 1);
  //drawImage("plants/double/double_plant_paeonia_bottom.png", 24, 2);

  //drawImage("plants/double/double_plant_sunflower_front.png", 23, 1);
  //drawImage("plants/double/double_plant_sunflower_back.png", 23, 2);
  ////end double

  ////wheat
  //drawImage("plants/wheat/wheat_stage_7.png", 30, 3);
  //drawImage("plants/wheat/wheat_stage_6.png", 29, 3);
  //drawImage("plants/wheat/wheat_stage_5.png", 28, 3);
  //drawImage("plants/wheat/wheat_stage_4.png", 27, 3);
  //drawImage("plants/wheat/wheat_stage_3.png", 26, 3);
  //drawImage("plants/wheat/wheat_stage_2.png", 25, 3);
  //drawImage("plants/wheat/wheat_stage_1.png", 24, 3);
  //drawImage("plants/wheat/wheat_stage_0.png", 23, 3);
  ////end wheat

  ////melon
  //drawImage("plants/melon/melon_top.png", 30, 4);
  //drawImage("plants/melon/melon_side.png", 29, 4);
  //drawImage("plants/melon/melon_stem_connected.png", 28, 4);
  //drawImage("plants/melon/melon_stem_disconnected.png", 27, 4);
  ////end melon

  ////beetroot
  //drawImage("plants/beetroot/beetroots_stage_3.png", 30, 5);
  //drawImage("plants/beetroot/beetroots_stage_2.png", 29, 5);
  //drawImage("plants/beetroot/beetroots_stage_1.png", 28, 5);
  //drawImage("plants/beetroot/beetroots_stage_0.png", 27, 5);
  ////end beetroot

  ////potato
  //drawImage("plants/potato/potatoes_stage_3.png", 30, 6);
  //drawImage("plants/potato/potatoes_stage_2.png", 29, 6);
  //drawImage("plants/potato/potatoes_stage_1.png", 28, 6);
  //drawImage("plants/potato/potatoes_stage_0.png", 27, 6);
  ////end potato

  ////netherwart
  //drawImage("plants/netherwart/nether_wart_stage_2.png", 30, 7);
  //drawImage("plants/netherwart/nether_wart_stage_1.png", 29, 7);
  //drawImage("plants/netherwart/nether_wart_stage_0.png", 28, 7);
  ////end netherwart

  ////carrot
  //drawImage("plants/carrot/carrots_stage_3.png", 30, 8);
  //drawImage("plants/carrot/carrots_stage_2.png", 29, 8);
  //drawImage("plants/carrot/carrots_stage_1.png", 28, 8);
  //drawImage("plants/carrot/carrots_stage_0.png", 27, 8);
  ////end carrot

  ////cactus
  //drawImage("plants/cactus/cactus_top.png", 30, 9);
  //drawImage("plants/cactus/cactus_side.png", 29, 9);
  //drawImage("plants/cactus/cactus_bottom.png", 28, 9);
  ////end cactus

  ////cocoa
  //drawImage("plants/cocoa/cocoa_stage_2.png", 30, 10);
  //drawImage("plants/cocoa/cocoa_stage_1.png", 29, 10);
  //drawImage("plants/cocoa/cocoa_stage_0.png", 28, 10);
  ////end cocoa

  ////vine
  //drawImage("plants/vine/vine4.png", 30, 11);
  //drawImage("plants/vine/vine3.png", 29, 11);
  //drawImage("plants/vine/vine2.png", 28, 11);
  //drawImage("plants/vine/vine1.png", 27, 11);
  ////end vine

  ////misc plants
  //drawImage("plants/waterlily.png", 30, 12);
  //drawImage("plants/fern.png", 29, 12);
  //drawImage("plants/tallgrass.png", 28, 12);
  ////end misc plants

  ////mineral block
  //drawImage("mineral/block/quartz/quartz_block_chiseled.png", 0, 30);
  //drawImage("mineral/block/quartz/quartz_block_chiseled_top.png", 0, 29);
  //drawImage("mineral/block/quartz/quartz_block_lines.png", 0, 28);
  //drawImage("mineral/block/quartz/quartz_block_lines_top.png", 0, 27);
  //drawImage("mineral/block/quartz/quartz_block_side.png", 0, 26);
  //drawImage("mineral/block/quartz/quartz_block_top.png", 0, 25);
  //drawImage("mineral/block/quartz/quartz_block_bottom.png", 0, 24);
  //drawImage("mineral/block/emerald_block.png", 1, 30);
  //drawImage("mineral/block/gold_block.png", 2, 30);
  //drawImage("mineral/block/diamond_block.png", 3, 30);
  //drawImage("mineral/block/lapis_block.png", 4, 30);
  //drawImage("mineral/block/redstone_block.png", 5, 30);
  //drawImage("mineral/block/iron_block.png", 6, 30);
  //drawImage("mineral/block/coal_block.png", 7, 30);
  //drawImage("mineral/block/obsidian.png", 8, 30);
  ////end mineral block

  ////ore
  //drawImage("mineral/ore/quartz_ore.png", 0, 31);
  //drawImage("mineral/ore/emerald_ore.png", 1, 31);
  //drawImage("mineral/ore/gold_ore.png", 2, 31);
  //drawImage("mineral/ore/diamond_ore.png", 3, 31);
  //drawImage("mineral/ore/lapis_ore.png", 4, 31);
  //drawImage("mineral/ore/redstone_ore.png", 5, 31);
  //drawImage("mineral/ore/iron_ore.png", 6, 31);
  //drawImage("mineral/ore/coal_ore.png", 7, 31);
  ////end ore

  ////pumpkin
  //drawImage("pumpkin/pumpkin_face_on.png", 31, 31);
  //drawImage("pumpkin/pumpkin_face_off.png", 30, 31);
  //drawImage("pumpkin/pumpkin_side.png", 29, 31);
  //drawImage("pumpkin/pumpkin_top.png", 28, 31);
  ////end pumpkin

  ////tnt
  //drawImage("tnt/tnt_side.png", 31, 30);
  //drawImage("tnt/tnt_top.png", 30, 30);
  //drawImage("tnt/tnt_bottom.png", 29, 30);
  ////end tnt

  ////red sandstone
  //drawImage("redsandstone/red_sandstone_carved.png", 31, 29);
  //drawImage("redsandstone/red_sandstone_normal.png", 30, 29);
  //drawImage("redsandstone/red_sandstone_smooth.png", 29, 29);
  //drawImage("redsandstone/red_sandstone_bottom.png", 28, 29);
  //drawImage("redsandstone/red_sandstone_top.png", 27, 29);
  //drawImage("redsandstone/red_sand.png", 27, 29);
  ////end red sandstone

  ////sandston
  //drawImage("sandstone/sandstone_carved.png", 31, 28);
  //drawImage("sandstone/sandstone_normal.png", 30, 28);
  //drawImage("sandstone/sandstone_smooth.png", 29, 28);
  //drawImage("sandstone/sandstone_bottom.png", 28, 28);
  //drawImage("sandstone/sand.png", 27, 28);
  ////end sandstone

  ////cake
  //drawImage("cake/cake_top.png", 31, 27);
  //drawImage("cake/cake_inner.png", 30, 27);
  //drawImage("cake/cake_side.png", 29, 27);
  //drawImage("cake/cake_bottom.png", 28, 27);
  ////end cake

  ////furnace
  //drawImage("furnace/furnace_front_on.png", 31, 26);
  //drawImage("furnace/furnace_front_off.png", 30, 26);
  //drawImage("furnace/furnace_side.png", 29, 26);
  //drawImage("furnace/furnace_top.png", 28, 26);
  ////end furnace

  ////ice
  //drawImage("ice/ice.png", 31, 25);
  //drawImage("ice/ice_packed.png", 30, 25);
  //drawImage("ice/frosted_ice_3.png", 29, 25);
  //drawImage("ice/frosted_ice_2.png", 28, 25);
  //drawImage("ice/frosted_ice_1.png", 27, 25);
  //drawImage("ice/frosted_ice_0.png", 26, 25);
  ////end ice

  ////crafting
  //drawImage("crafting/crafting_table_top.png", 31, 24);
  //drawImage("crafting/crafting_table_front.png", 30, 24);
  //drawImage("crafting/crafting_table_side.png", 29, 24);
  ////end crafting

  ////enchanting
  //drawImage("enchanting/enchanting_table_top.png", 31, 23);
  //drawImage("enchanting/enchanting_table_side.png", 30, 23);
  //drawImage("enchanting/enchanting_table_bottom.png", 29, 23);
  ////end enchanting

  ////glass
  //drawImage("glass/glass.png", 9, 31);
  //drawImage("glass/glass_black.png", 9, 30);
  //drawImage("glass/glass_blue.png", 9, 29);
  //drawImage("glass/glass_brown.png", 9, 28);
  //drawImage("glass/glass_cyan.png", 9, 27);
  //drawImage("glass/glass_gray.png", 9, 26);
  //drawImage("glass/glass_green.png", 9, 25);
  //drawImage("glass/glass_light_blue.png", 9, 24);
  //drawImage("glass/glass_lime.png", 9, 23);
  //drawImage("glass/glass_magenta.png", 9, 22);
  //drawImage("glass/glass_orange.png", 9, 21);
  //drawImage("glass/glass_pink.png", 9, 20);
  //drawImage("glass/glass_purple.png", 9, 19);
  //drawImage("glass/glass_red.png", 9, 18);
  //drawImage("glass/glass_silver.png", 9, 17);
  //drawImage("glass/glass_white.png", 9, 16);
  //drawImage("glass/glass_yellow.png", 9, 15);
  ////end glass

  ////pane
  //drawImage("glass/pane/glass_pane_top.png", 10, 31);
  //drawImage("glass/pane/glass_pane_top_black.png", 10, 30);
  //drawImage("glass/pane/glass_pane_top_blue.png", 10, 29);
  //drawImage("glass/pane/glass_pane_top_brown.png", 10, 28);
  //drawImage("glass/pane/glass_pane_top_cyan.png", 10, 27);
  //drawImage("glass/pane/glass_pane_top_gray.png", 10, 26);
  //drawImage("glass/pane/glass_pane_top_green.png", 10, 25);
  //drawImage("glass/pane/glass_pane_top_light_blue.png", 10, 24);
  //drawImage("glass/pane/glass_pane_top_lime.png", 10, 23);
  //drawImage("glass/pane/glass_pane_top_magenta.png", 10, 22);
  //drawImage("glass/pane/glass_pane_top_orange.png", 10, 21);
  //drawImage("glass/pane/glass_pane_top_pink.png", 10, 20);
  //drawImage("glass/pane/glass_pane_top_purple.png", 10, 19);
  //drawImage("glass/pane/glass_pane_top_red.png", 10, 18);
  //drawImage("glass/pane/glass_pane_top_silver.png", 10, 17);
  //drawImage("glass/pane/glass_pane_top_white.png", 10, 16);
  //drawImage("glass/pane/glass_pane_top_yellow.png", 10, 15);
  ////end pane

  ////brewingstand
  //drawImage("brewingstand/brewing_stand.png", 31, 22);
  //drawImage("brewingstand/brewing_stand_base.png", 30, 22);
  ////end brewindstand

  ////cauldron
  //drawImage("cauldron/cauldron_top.png", 31, 21);
  //drawImage("cauldron/cauldron_side.png", 30, 21);
  //drawImage("cauldron/cauldron_inner.png", 29, 21);
  //drawImage("cauldron/cauldron_bottom.png", 28, 21);
  ////end cauldron

  ////torch
  //drawImage("torch/torch_on.png", 31, 20);
  ////end torch
  doStuff1();

  gr.endDraw();
  gr.save("MinecraftAtlas2.png");
  background(200);
  image(gr, 0, 0,1024,1024);
  //for (int x=0; x<1024; x++) {
    //for (int y=0; y<1024; y++) {
      //noStroke();
      //fill(gr.get(x*2, y*2));
      //rect(x, y, 1, 1);
    //}
  //}
}
void settings(){
  size(1024,1024);
  noSmooth();
}
void drawImage(String image, int x, int y) {
  //gr.image(loadImage("blocks/"+image), x*tileW, y*tileH,tileW,tileH);
  drawImage(loadImage("blocks/"+image),x,y);
}
void drawImage(PImage image, int x, int y) {
  //image.resize(tileW,tileH);
  //for(int rx=0;rx<image.width;rx++){
    //for(int ry=0;ry<image.height;ry++){
      //color c=image.get(rx,ry);
      //if(red(c)==green(c)&&green(c)==blue(c)){
        //float v=red(c);
        //if(v>100)c=color(255,0,0);
      //}
      //image.set(rx,ry,c);
    //}
  //}
  //if(image.width==16){
    //for(int rx=0;rx<16;rx++){
      //for(int ry=0;ry<16;ry++){
        //noStroke();
        //fill(image.get(rx,ry));
        //rect(rx*4+x*tileW,ry*4+y*tileH,4,4);
      //}
    //}
  //}else
  gr.image(image, x*tileW, y*tileH,tileW,tileH);
  //for(int px=0;px<image.width;px++){
    //for(int py=0;py<image.height;py++){
      //gr.noStroke();
      //gr.fill(image.get(px,py));
      //gr.rect(x*tileW+px*64/image.width,y*tileH+py*64/image.height,tileW,tileH);
    //}
  //}
  //float size=tileW/image.width;
  //for(int rx=0;rx<tileW/size;rx++){
  //  for(int ry=0;ry<tileH/size;ry++){
  //    noStroke();
  //    fill(image.get(rx,ry));
  //    rect(x*tileW+rx*size,y*tileH+ry*size,size,size);
    //}
  //}
}