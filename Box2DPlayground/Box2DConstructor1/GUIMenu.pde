class GUIMenu extends GUIButton{
  boolean shown;
  ArrayList<GUIButton>buttons;
  GUIMenu(float x,float y,float w,float h,String txt,float txtoffx,float txtoffy){
    super(x,y,w,h,txt,txtoffx,txtoffy);
    shown=false;
    buttons=new ArrayList<GUIButton>();
    event=new GUIEvent(){
      void happen(){
        shown=!shown;
      }
    };
  }
  void expandMenus(){
    shown=true;
    for(GUIButton btn:buttons)btn.expandMenus();
  }
  void hideMenus(){
    shown=false;
    for(GUIButton btn:buttons)btn.hideMenus();
  }
  GUILabel addLabel(String text){
    GUILabel lbl=new GUILabel(x,y+(buttons.size()+1)*h,w,h,text,txtoffx,txtoffy);
    buttons.add(lbl);
    return lbl;
  }
  GUIMenu addMenu(String text){
    GUIMenu menu=new GUIMenu(x+(buttons.size()+1)*w,y,w,h,text,txtoffx,txtoffy);
    menu.isDropdown=true;
    buttons.add(menu);
    return menu;
  }
  GUIButton addButton(String text,GUIEvent e){
    GUIButton btn=new GUIButton(x,y+(buttons.size()+1)*h,w,h,text,txtoffx,txtoffy);
    btn.event=e;
    btn.isDropdown=!isDropdown;
    buttons.add(btn);
    return btn;
  }
  void keyCheck(){
    super.keyCheck();
    for(GUIButton btn:buttons){
      btn.keyCheck();
    }
  }
  void display(){
    keyCheck();
    super.display();
    if(shown){
      for(GUIButton btn:buttons){
        btn.display();
        btn.keyCheck();
      }
    }
  }
}