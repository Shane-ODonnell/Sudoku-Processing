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

  gridTest4();
  
}

void draw(){
  //LOOP
  refresh();

  if(keyPressed && key == 's'){
    println("keypressed s");
    singles();
    /*
      while(hiddenSingles())
        singles();
    //*/
  }

  if(keyPressed && key == 'h'){
    println("keypressed h");
    hiddenSingles();
  }

  if(keyPressed && key == 'g'){
    println("keypressed g");
    finishGrid();
  }

  if(keyPressed && key == 'ö'){
    println("keypressed ö: restarting");
    setup();
  }
 
}

void mousePressed() {
  //println("X is " + mouseX + " and Y is " + mouseY);
  //check each cell to see if mouse is over it
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // check each object
      if( grid[i][j].mouseOver()){
        //println("Mouse is over cell " + i + ", " + j);
        int box = getBox(i,j);
        println( "Cell is in box:  " + box);
        //store this as the current editing cell;
        grid[currI][currJ].editing = false;
        currI = i;
        currJ = j;
        editing = true;
        grid[i][j].editing = true;
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
    grid[currI][currJ].editing = false;
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


void gridTest1(){
  //let grid equal to a presaved puzzle for testing
  //Test 1 was taken from https://sudoku.com/easy/ and was passed successfully 

  int[][] Test = { 
  { 0, 0, 6, 2, 5, 0, 1, 0, 0 },
  { 5, 1, 9, 6, 0, 7, 0, 2, 0 },
  { 7, 2, 4, 9, 0, 0, 5, 8, 6 },
  { 6, 5, 0, 0, 0, 1, 0, 3, 7 },
  { 9, 0, 3, 7, 2, 0, 0, 0, 0 },
  { 0, 7, 0, 0, 4, 0, 0, 0, 0 },
  { 2, 0, 0, 0, 0, 0, 0, 0, 8 },
  { 0, 6, 0, 5, 3, 0, 0, 9, 1 },
  { 8, 0, 0, 1, 6, 0, 0, 0, 3 }
  };
  
  setGrid(Test);

}

void gridTest2(){
  //let grid equal to a presaved puzzle for testing
  //Test 2 was taken from https://sudoku.com/medium/
  //passed successfully
  int[][] Test = { 
  { 4, 1, 5, 0, 7, 8, 2, 0, 0 },
  { 7, 0, 3, 0, 2, 9, 0, 8, 1 },
  { 0, 0, 0, 5, 0, 1, 4, 0, 0 },
  { 3, 9, 6, 0, 0, 5, 0, 0, 0 },
  { 0, 0, 0, 0, 3, 2, 6, 0, 0 },
  { 0, 0, 4, 0, 9, 6, 3, 0, 0 },
  { 6, 0, 0, 9, 8, 0, 0, 3, 5 },
  { 0, 3, 1, 0, 0, 0, 0, 4, 6 },
  { 0, 4, 0, 0, 0, 0, 7, 2, 0 }
  };
  
  setGrid(Test);

}

void gridTest3(){
  //let grid equal to a presaved puzzle for testing
  //Test 3 was taken from https://sudoku.com/hard/
  //passed successfully using finishGrid()

  int[][] Test = { 
  { 9, 0, 2, 0, 6, 3, 0, 8, 0 },
  { 8, 0, 0, 4, 0, 0, 9, 0, 0 },
  { 0, 5, 6, 0, 2, 0, 0, 0, 4 },
  { 0, 0, 3, 1, 0, 7, 0, 0, 0 },
  { 5, 0, 0, 3, 0, 6, 0, 1, 8 },
  { 0, 1, 0, 0, 0, 0, 0, 5, 0 },
  { 0, 0, 8, 0, 0, 0, 5, 0, 0 },
  { 0, 2, 0, 0, 0, 0, 0, 4, 0 },
  { 3, 0, 1, 5, 0, 9, 0, 0, 0 }
  };
  
  setGrid(Test);

}


void gridTest4(){
  //let grid equal to a presaved puzzle for testing
  //Test 3 was taken from https://sudoku.com/hard/
  //passed successfully using finishGrid()

  int[][] Test = { 
  { 0, 5, 0, 4, 9, 0, 6, 0, 7 },
  { 1, 0, 0, 0, 2, 6, 0, 9, 0 },
  { 0, 9, 0, 0, 0, 8, 0, 0, 0 },
  { 0, 0, 0, 1, 5, 9, 3, 2, 6 },
  { 0, 0, 0, 0, 0, 0, 0, 0, 9 },
  { 9, 0, 5, 0, 0, 0, 0, 0, 1 },
  { 0, 0, 0, 0, 8, 7, 0, 6, 3 },
  { 2, 7, 0, 6, 0, 3, 0, 0, 0 },
  { 0, 6, 0, 0, 0, 0, 7, 1, 0 }
  };
  
  setGrid(Test);

}

void setGrid(int [][] array){
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // Initialize each object
      grid[i][j].setVal(array[j][i]);
      if( array[j][i] != 0)
       grid[i][j].setDefault();
    }
  }
}
