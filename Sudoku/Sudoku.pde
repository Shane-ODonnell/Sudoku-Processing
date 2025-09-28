//Sudoku

int rows = 9;
int cols = 9;

PImage background;


Cell[][] grid; //stores the value of every cell in the puzzle

void setup() {
  size(1000,1000);
  background = loadImage("Sudoku-Board.png");
  refresh();

  grid = new Cell[cols][rows];

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // Initialize each object
      grid[i][j] = new Cell(i, j);
    }
  }
}

void draw(){
  //LOOP

}

void showGrid(){
    for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {
            // show each object
            grid[i][j].show();
        }
    }
}
void mousePressed() {
  println("X is " + mouseX + " and Y is " + mouseY);
  //cell 1 is 60,60 to 140,140
  //cell 2 is 160,60 to 240,140
}

void refresh(){
  image(background, 0, 0, width, height);
  //showGrid();
}
