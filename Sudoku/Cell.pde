class Cell {
  //member vars
  int val = 0;   // the value 0-9 of the cell

  int index;     // from 1 to 81 which cell is this in the puzzle
  int i, j, k;   // Where k is the grid the cell is in. i is the row of the grid. j is the column
  int r, c;      // row and column in overall puzzle

  void start(int Val, int Index) {
    val = Val;
    index = Index;

    //index ranges from 1 to 81 to represent one of the 81 cells.
    // now we need to set r, c and the i,j,k based on this index

  }






  void setVal(int Val) {
    val = Val;
  }
}
