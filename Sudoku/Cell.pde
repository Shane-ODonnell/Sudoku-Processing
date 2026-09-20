class Cell {
  //Cell class compatible with 2D array

  int value = 0;
  int x, y; //coords for top left corner of cell
  int w;    // width of cell
  boolean given = false;
  boolean editing = false;
  int[] notes;
  int oVal1,oVal2;
  int I,J;
  boolean annotated = false;

  //Cell constructor
  Cell(int i, int j){
    //Set the dimensions that the cell occupies on screen
    x = getX(i);
    y = getX(j);
    I = i;
    J = j;
    w = 80;
  }

  void setVal(int Val){
    value = Val;
  }

  void setDefault(){
    given = true;
  }

  void show(){
    if(mouseOver() || editing){
      fill(200);
      rect(x,y,w,w);
    }
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

  void setNotes(){
    notes = options(I,J);
    annotated = true;
    getNumOptions();
  }

  int getNumOptions(){
    //
    int count = 0;
    if(value == 0){
      for(int i = 0; i < notes.length; i++){
        if(notes[i] != 0)
          count++;
      }
    }
    else return 11; //like -1 but more useful to me

    if(count <= 2){
      boolean first = true;
      for(int i = 0; i < notes.length; i++){
        if(notes[i] != 0){
          if(first){
            first = false;
            oVal1 = notes[i];
          }
          else 
            oVal2 = notes[i];
        }
      }
    }

    return count;
  }
  
  void printOptions(){
    if(annotated){
      int iTemp = I + 1;
      int jTemp = J + 1;
      print( "| " + iTemp + " , " + jTemp + " | (" + getNumOptions() + ") | ");
      for(int i = 0; i < notes.length; i++){
        int curr = notes[i];
        if(curr != 0){
          print( " " + curr );
        }
      }
      println();
    }
  }

  boolean compareNotes(int[] input){
    if(input.length == notes.length){
      //
      for(int i = 0; i < notes.length; i++){
        //
        if(notes[i] != input[i])
          return false;
      }
    
    }
    return true;
  }

  int[] getNotes(){
    return notes;
  }

  int getIndex(int val){
    //return location of val where/if exists in the array
    for(int i = 0; i < notes.length; i++){
      if(notes[i] == val){
        return i;
      }
    }
    
    return -1; //if val doesnt exist in the array
}

}// close class Cell

int getX(int i){
  //given the i or j component of a cell and retunr the coresponding x or y 
  return (60 + 100 * (i));
}