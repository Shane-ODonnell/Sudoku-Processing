//Sudoku

int rows = 9;
int cols = 9;

Cell[][] grid; //stores the value of every cell in the puzzle

void setup() {
  size(600,600);
  
  grid = new Cell[cols][rows];

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // Initialize each object
      grid[i][j] = new Cell();
    }
  }
}

void showGrid(){
    for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {
            // show each object
            grid[i][j].show();
        }
    }
}