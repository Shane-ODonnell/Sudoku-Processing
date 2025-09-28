class Cell1 {
  //member vars
  int val = 0;   // the value 0-9 of the cell

  int index;        // from 1 to 81 which cell is this in the puzzle
  int r, c, grid;   // the grid the cell is in. r is the row of the grid. c is the column
  int row, col;     // row and column in overall puzzle

  void start(int Val, int Index) {
    val = Val;
    index = Index;

    //index ranges from 1 to 81 to represent one of the 81 cells.
    // now we need to set row, c and the i,j,k based on this index
    
    row = getRow(index); // setup the row member val 
    col = getColumn(index);
    
    //now row and col are from 1-9 so find the grid 

    for(int i = 1; i <= 3; i++){       //where i is the grid row (1-3)
      if ( row <= 3*i ){
        r = i;                         // set the gird row
        for( int j = 1; j <= 3; j++){  // j is the grid column (1-3)
          if( col <= 3*j){
           c = j;                      // set the grid column  
          }
        }
      }
    }
    
    grid = ( c + 3 * (r - 1) ); // set the grid based on that info

  }

  void show(){}

  void setVal(int Val) {
    val = Val;
  }
}

int getRow(int index){
  for(int i = 1; i <= 9; i++){
    if(index <= (9 * i)){
      return i; // retrun the row 
    }
  }
  return 0;
}

int getColumn(int index){
  int row = getRow(index);
  row--;
  return (index - (9 * row));
}

int getGrid(int index){
  // may be redundant function
  int grid = 0;
  int row = getRow(index);
  int column = getColumn(index);

  //find the grid number 1-9

  //*
    if( row <= 3){
      if( column <= 3 )
        grid = 1;
      else if( column <= 6)
        grid = 2;
      else 
        grid = 3;
    }
    else if ( row <= 6){
      if( column <= 3 )
        grid = 4;
      else if( column <= 6)
        grid = 5;
      else 
        grid = 6;
    }
    else{
      if( column <= 3 )
        grid = 7;
      else if( column <= 6)
        grid = 8;
      else 
        grid = 9;
    }
    return grid;
  //*/

  /*
    //Alternative implementation which delivers the same result but may be slower 
    for(int r = 1; r <= 3; r++){ //where r is the grid row (1-3) as opposed to the puzzle row (1-9)
      if ( row <= 3*r ){
        for( int c = 1; c <= 3; c++){ // c is the grid column (1-3) as opposed to the puzzle column (1-9)
          if( column <= 3*c){
            //here we have effectively deduced the i and j components of the grid so to speak
            // (so grid 1 would be 1,1 grid 9 would be 3,3)
            // so we convert this to a corresponding grid
            return ( c + 3 * (r - 1) );
          }
        }
      }
    }
  //*/
}//close getGrid