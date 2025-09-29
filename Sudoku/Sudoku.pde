//Sudoku

int rows = 9;
int cols = 9;
int currI, currJ;
boolean editing = false;

PImage background;


Cell[][] grid; //stores the value of every cell in the puzzle

void setup() {
  size(1000,1000);
  background = loadImage("Sudoku-Board.png");
  image(background, 0, 0, width, height);

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
  refresh();

  if(keyPressed && key == 's'){
    println("keypressed s");
    Singles();
  }
 
}

void mousePressed() {
  //println("X is " + mouseX + " and Y is " + mouseY);
  //check each cell to see if mouse is over it
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // check each object
      if( grid[i][j].mouseOver()){
        println("Mouse is over cell " + i + ", " + j);
        //store this as the current editing cell;
        currI = i;
        currJ = j;
        editing = true;
        i = cols; //break out of both loops
        j = rows;
      }
    }
  }
}

void keyPressed(){

  //if key is between 1 and 9 add it to the cell being edited
  if( 49 <= key && key <= 57 && editing){
    grid[currI][currJ].setVal(key - 48); //convert char to int
    editing = false;
  }

  if( keyCode == BACKSPACE ){
    grid[currI][currJ].setVal(0); //undo last addition
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

void refresh(){
  image(background, 0, 0, width, height);
  showGrid();
}
