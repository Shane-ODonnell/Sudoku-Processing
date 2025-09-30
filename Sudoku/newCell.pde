class Cell {
  //Cell class compatible with 2D array

  int value = 0;
  int x, y; //coords for top left corner of cell
  int w;    // width of cell
  boolean given = false;

  //Cell constructor
  Cell(int i, int j){
    //Set the dimensions that the cell occupies on screen
    x = getX(i);
    y = getX(j);
    w = 80;
  }

  void setVal(int Val){
    value = Val;
  }

  void setDefault(){
    given = true;
  }

  void show(){
    if(value != 0){

      fill( 0, 0, 255);

      if(given)
      fill(0);
      
      textAlign(CENTER, CENTER);
      textSize(50);
      text(value, x + w/2, y + w/2);
    }
  }

  boolean mouseOver(){
    // returns true if mouse is over this cell
    if( x <= mouseX && mouseX <= (x+w))
      if(y <= mouseY && mouseY <= (y+w))
        return true;
    return false;
  }

  int val(){
    return value;
  }

}// close class Cell

int getX(int i){
  //given the i or j component of a cell and retunr the coresponding x or y 
  return (60 + 100 * (i));
}