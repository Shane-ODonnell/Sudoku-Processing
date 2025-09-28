class Cell {
  //Cell class compatible with 2D array

  int val = 0;
  int x, y; //coords for top left corner of cell
  int w;    // width of cell

  //Cell constructor
  Cell(int i, int j){
    //Set the dimensions that the cell occupies on screen
    x = getX(i);
    y = getX(j);
    w = 80;
  }

  void setVal(int Val){
    val = Val;
  }

  void show(){
    //display 
  }

  boolean mouseOver(){
    if( x <= mouseX && mouseX <= (x+w))
      if(y <= mouseY && mouseY <= (y+w))
        return true;
    return false;
  }
}

int getX(int i){
  //given the i or j component of a cell and retunr the coresponding x or y 
  return (60 + 100 * (i-1));
};