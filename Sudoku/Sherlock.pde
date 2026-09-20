//this is Sherlock, a sudoku solving machine 

void sherlock(){
    int it = 0;
    while(!complete() && it < 50){
        singles();
        //hiddenSingles();
        finishGrid();
        it++;
    }
    if(!complete()){
        it = 0;
        dualPairs();
        while(!complete() && it < 50){
            singles();
            //hiddenSingles();
            finishGrid();
            it++;
        }
    }
}

boolean complete(){
  for(int i = 0; i < rows; i++){
    for(int j = 0; j < cols; j++){
      if(grid[i][j].val() == 0)
        return false;
    }
  }
  return true;
}

void singles(){
    for(int i = 0; i < rows; i++){
        for (int j = 0; j < cols; j++){
            //iterate through every cell
            //for every cell check the sorrounding grid, and the column and row in question
            // narrow down if there is only one thing it could be
            
            int[] options = options(i,j); //initialize a tally of numbers 1- 9
            int numOptions = 0;

            for(int it = 0; it < options.length; it++){
                if(options[it] != 0)
                    numOptions++;
                //count the number of options in the array
            }

            if( numOptions == 1){
                //if there is only one option left, fill it in
                for( int k = 0; k < options.length; k++){
                    if( options[k] != 0 && grid[i][j].value == 0){
                        println("setting " + i + ", " + j + " to be " + options[k]);
                        grid[i][j].setVal(options[k]);
                        
                        // now this column is solved
                        k = options.length; // break out of this loop
                        j = cols;
                        i = -1; // start from square one again 
                    }
                }
            }//close if numOptions

        }//close for (j)
    }//close for (i)


}// close singles fx

boolean hiddenSingles(){
    /*
        //singles finds the one value that can fit in a given cell
        //hiddenSingles is going to find the only value that can go there
        //that is to say that it will look at filling in the puzzle by narrowing down which cell is 
        // the only cell remaining that could contain a needed value
    //*/

    //if a given value is already present in the puzzle 8 times then we can narrow down where the last 
    //instance of that value needs to be
    for(int k = 1; k <= 9; k++){
        //iterate through the puzzle and count how often a value is present
        if(instances(k) == 8 ){
            // there is only one instance of k missing from the puzzle
            //lets narrow down which rows and cols dont need a k
            //find the row that doesnt have a k

            int i,j;
            i = -1; //initialize to prevent error

            for( int it = 0; it < rows; it++){
                boolean foundK = false;

                for( int jt = 0; jt < cols; jt++){
                 if( grid[it][jt].val() == k){
                        foundK = true;
                        jt = cols;//break loop
                    }
                }

                if( !foundK ){
                    //this is the row that is missing k
                    i = it;
                    it = rows; // break loop
                }

            }// the row (i) that needs a k is found 

            for( int jt = 0; jt < cols; jt++){
                boolean foundK = false;

                for( int it = 0; it < rows; it++){
                 if( grid[it][jt].val() == k){
                        foundK = true;
                        it = cols;
                    }
                }

                if(!foundK){
                    //this is the colm that is missing k
                    j = jt;         

                    grid[i][j].setVal(k);
                    return true; //this means we made an addition
                }

            }// the col (j) that needs a k is found 
            
            //finally we have the only cell that can house the last k

        }
    }
    return false;
}

int getBox(int i, int j){
    //return number 1-9 depending on which box the cell (i,j) is in
    if( i < 3){
        if (j < 3)
            return 1;
        if( j < 6)
            return 4;
        else 
            return 7;
    }
    if( i < 6){
        if (j < 3)
            return 2;
        if( j < 6) 
            return 5;
        else 
            return 8;
    }
    else {
        if (j < 3)
            return 3;
        if (j < 6)
            return 6;
        else
            return 9;
    }
    
}

int instances(int val){
    //iterate through the puzzle and count how often a value is present
    int count = 0;
    for(int i = 0; i < rows; i++){
        for( int j = 0; j < cols; j++){
            if( grid[i][j].val() == val)
                count++;
        }//close for loop (j)
    }//close for loop (i)

    return count;
}

int[] options(int i, int j){
    //return the possible options for a given cell
    int[] options = { 1, 2, 3, 4, 5, 6, 7, 8, 9 }; //initialize a tally of numbers 1- 9
    int numOptions = 9; //number of options remaining
    if(grid[i][j].val() == 0){
        //check the whole row for numbers
        for(int it = 0; it < rows; it++){
            int val = grid[it][j].val();

            if( val != 0 ){
                //remove val from options array
                if(options[val - 1] != 0){
                    options[val-1] = 0;
                    numOptions--;
                }
            }//close if 

        }//close for (it)

        //check the whole column for numbers
        for(int jt = 0; jt < cols; jt++){
            int val = grid[i][jt].val();

            if( val != 0 ){
                //remove val from options array
                if(options[val - 1] != 0){
                    options[val-1] = 0;
                    numOptions--;
                }
            }//close if 

        }//close for (jt)

        // searchGrid functionality here
        int currBox = getBox(i,j);
        int checked = 9;
        
        for(int it = 0; it < rows; it++){
            for(int jt = 0; jt < cols; jt++){
                if( currBox == getBox(it,jt) ){
                    checked--;
                    int val = grid[it][jt].val();
                    if( val != 0 ){
                        //remove val from options array
                        if(options[val - 1] != 0){
                            options[val-1] = 0;
                            numOptions--;
                        }
                    }//close if 
                    if(checked == 0){
                        it = rows;
                        jt = cols; // break loop to save time
                    }
                }
            }
        }
    }
    else {
     int [] zero = { 0, 0, 0, 0, 0, 0, 0, 0, 0 };
     return zero;
    }

    return options;
}

void finishGrid(){
    finishRow();
    finishCol();
    for(int k = 1; k <= 9; k++){//go thru all the boxes/grids
        int [] occurances = { 0, 0, 0, 0, 0, 0, 0, 0, 0 };
        boolean updated = false;
        for(int i = 0; i < rows; i++){
            for(int j = 0; j < cols; j++){
                //iterate through every cell
                if(getBox(i,j) == k){
                    if( grid[i][j].val() == 0){//if cell is empty 
                        int [] options = options(i,j); // look at which values are able to go in this cell
                        //i need to see if this is the only cell in the grid with a given option
                        //check if other cells in the grid have a given option
                        //use occurances array to count how many times any value appears as an option per box
                        //then if any single value in occurances == 1,
                        //go back through the grid and find where that is 
                        // fill in that cell 
                        for(int m = 1; m <= 9; m++){
                            if(within(m, options)){
                                occurances[m-1]++;
                            }
                        }
                    }
                }//iterate through the idividual cells of grid k
            }//close for (j)
        }//close for (i)

        //now we have the occurances array which tells us how many times each value appears in an one of the 9 options arrays for a grid
        if(within(1, occurances)){
            //if there is a value that can only go in one cell of the box
            //find that value and add it in.
            int target = getIndex(1, occurances);
            target++; // convert index to the needed value 

            //search which cell has temp as an option
            for(int i = 0; i < rows; i++){
                for(int j = 0; j<cols; j++){
                    if(getBox(i,j) == k){
                        if(within(target, options(i,j))){
                            grid[i][j].setVal(target);
                            updated = true;
                            //break loop
                            j = cols;
                            i = rows;
                        }
                    }
                }//close for (j)
            }//close for (i)
        }
        if(updated){
            k = -1; //start over
        }
    }//close for (k)
}

void finishRow(){
    //same idea as finishGrid(). but instead of looking at the other cells in the box look at the row
    //TODO
    for(int i = 0; i < rows; i++){
        int [] occurances = { 0, 0, 0, 0, 0, 0, 0, 0, 0 };
        boolean updated = false;
        for(int j = 0; j < cols; j++){
            //iterate through every cell
            if( grid[i][j].val() == 0){//if cell is empty 
                int [] options = options(i,j); // look at which values are able to go in this cell
                //i need to see if this is the only cell in the grid with a given option
                //check if other cells in the grid have a given option
                //use occurances array to count how many times any value appears as an option per box
                //then if any single value in occurances == 1,
                //go back through the grid and find where that is 
                // fill in that cell 
                for(int m = 1; m <= 9; m++){
                    if(within(m, options)){
                        occurances[m-1]++;
                    }
                }
            }
        }//close for (j)

        //now we have the occurances array which tells us how many times each value appears in an one of the 9 options arrays for a grid
        if(within(1, occurances)){
            //if there is a value that can only go in one cell of the box
            //find that value and add it in.
            int target = getIndex(1, occurances);
            target++; // convert index to the needed value 

            //search which cell has temp as an option
            for(int j = 0; j<cols; j++){
                if(within(target, options(i,j))){
                    grid[i][j].setVal(target);
                    updated = true;
                    //break loop
                    j = cols;
                }
            }//close for (j)
        }
        if(updated){
            i = -1; //start over
        }
    }//close for (i)
}

void finishCol(){
    //same idea as finishGrid(). but instead of looking at the other cells in the box look at the row
    //TODO
    for(int j = 0; j < cols; j++){
        int [] occurances = { 0, 0, 0, 0, 0, 0, 0, 0, 0 };
        boolean updated = false;
        for(int i = 0; i < rows; i++){
            //iterate through every cell
            if( grid[i][j].val() == 0){//if cell is empty 
                int [] options = options(i,j); // look at which values are able to go in this cell
                //i need to see if this is the only cell in the grid with a given option
                //check if other cells in the grid have a given option
                //use occurances array to count how many times any value appears as an option per box
                //then if any single value in occurances == 1,
                //go back through the grid and find where that is 
                // fill in that cell 
                for(int m = 1; m <= 9; m++){
                    if(within(m, options)){
                        occurances[m-1]++;
                    }
                }
            }
        }//close for (j)

        //now we have the occurances array which tells us how many times each value appears in an one of the 9 options arrays for a grid
        if(within(1, occurances)){
            //if there is a value that can only go in one cell of the box
            //find that value and add it in.
            int target = getIndex(1, occurances);
            target++; // convert index to the needed value 

            //search which cell has temp as an option
            for(int i = 0; i < rows; i++){
                if(within(target, options(i,j))){
                    grid[i][j].setVal(target);
                    updated = true;
                    //break loop
                    i = rows;
                }
            }//close for (j)
        }
        if(updated){
            j = -1; //start over
        }
    }//close for (i)
}

boolean within(int val, int [] array){
    //return true if val exists in the array
    for(int i = 0; i < array.length; i++){
        if(array[i] == val){
            return true;
        }
    }
    return false;
}

int getIndex(int val, int [] array){
    //return location of val where/if exists in the array
    for(int i = 0; i < array.length; i++){
        if(array[i] == val){
            return i;
        }
    }
    
    return -1; //if val doesnt exist in the array
}

void addNotes(){
    //add notes to every cell
    for(int i = 0; i < rows; i++){
        for(int j = 0; j < rows; j++){
            if(grid[i][j].val() == 0)
                grid[i][j].setNotes();
        }
    }

}

void dualPairs(){
    addNotes();
    //now I need to look at every cell and compare it to every other cell
    //if i find two identical arrays of 2 options in a shared block/row/col
    // remove those two values from the other local arrays
    //if that creates an array with only one option, fill it in and move on
    
    
    for(int i = 0; i < rows; i++){
        for(int j = 0; j < rows; j++){
            dualPairsTargeted(i, j, false);
        }
    }
}

void dualPairsTargeted(int i, int j, boolean debugPrint){
    if(debugPrint){
        int iTemp = i + 1; int jTemp = j + 1;
        //println("Running dp on cell (" + iTemp + " , " + jTemp + ") "); 
    }
    if( grid[i][j].getNumOptions() == 2){
        //go thru all the other local cells for another 2 option array
        if(debugPrint){
            //println("passed gate 1 "); 
        }
        int currBox = getBox(i,j);
        for(int it = 0; it < rows; it++){
            for(int jt = 0; jt < rows; jt++){
                if(debugPrint){
                    int iTemp = it+1;
                    int jTemp = jt+1;
                    //println("passed gate 2 @ (" + iTemp + " , " + jTemp + ") with localscore: " + localNature);
                    if( grid[it][jt].val() == 0 ){
                        //println("(" + iTemp + " , " + jTemp + ") | " + grid[it][jt].getNumOptions());
                    }
                }
                if( grid[it][jt].getNumOptions() == 2 && !(it == i && jt == j) ){
                    //filter for only related / local cells (common row,col,block)
                    //so far we have only filtered for the exact cell
                    
                    int localNature = 0;
                    if (i == it)
                        localNature++;      //lsb
                    else if (j == jt)
                        localNature += 2;
                    if (currBox == getBox(it,jt)){
                        localNature += 4;  //MSB
                    }
                    
                    if(debugPrint){
                        int iTemp = it+1;
                        int jTemp = jt+1;
                        //println("passed gate 2 @ (" + iTemp + " , " + jTemp + ") with localscore: " + localNature);
                        //println("(" + iTemp + " , " + jTemp + ") | " + grid[it][jt].getNumOptions());
                    }

                    if( localNature > 0 ){ //if the row column or box match 
                        // grid[i][j] and grid[it][jt] both have only 2 possible options
                        // they are also are in the same neighbourhood

                        if(debugPrint){                            
                            println("passed gate 3 with localscore: " + localNature);
                        }

                        if(grid[i][j].compareNotes(grid[it][jt].notes)){
                            if(debugPrint){
                                int iTemp = it+1;
                                int jTemp = jt+1;
                                println("Match found in cell: " + iTemp + " , " + jTemp); 
                            }
                            //identical pair options between 2 local arrays
                            //now i need to check the other empty tiles in the local area
                                //if they have one of the pair values 
                                //remove them from that array and hopefully that will create a new single
                            
                            for(int r = 0; r < rows; r++){
                                for(int c = 0; c < rows; c++){
                                    boolean first = true;
                                    if(grid[r][c].getNumOptions() < 4){
                                        if( (r == i && localNature % 2 != 0) || (c == j && localNature % 2 == 0 && localNature != 4) || ( getBox(r,c) == currBox && localNature >= 4) ){
                                            //if( !(r != i || r != it) && !(c != j || c != jt) ){
                                                
                                                if(debugPrint){println("passed gate 5" );}
                                                int val1 = grid[i][j].oVal1;
                                                int val2 = grid[i][j].oVal2;
                                                for(int iterator = 0; iterator < grid[r][c].notes.length; iterator++){
                                                    int curr = grid[r][c].notes[iterator]; if(debugPrint){println("curr is " + curr );}
                                                    if(curr == val1 || curr == val2){
                                                        
                                                        int location;
                                                        if (!first){
                                                            location = grid[r][c].getIndex(val1);                                                                
                                                            first = false;
                                                            if(debugPrint){println("passed gate 51" );}
                                                        }
                                                        else{
                                                            location = grid[r][c].getIndex(val2);  
                                                            if(debugPrint){println("passed gate 52" );}
                                                        }

                                                        if(debugPrint){println("Location " + location );}
                                                        if(debugPrint){
                                                            int iTemp = it+1;
                                                            int jTemp = jt+1;
                                                            println("(it , jt) = (" + iTemp + " , " + jTemp + ")");
                                                            iTemp = i+1;
                                                            jTemp = j+1;
                                                            println("( i , j ) = (" + iTemp + " , " + jTemp + ")");
                                                            iTemp = r+1;
                                                            jTemp = c+1;
                                                            println("( r , c ) = (" + iTemp + " , " + jTemp + ")");
                                                            println("----------------------------------");
                                                            //println("(" + iTemp + " , " + jTemp + ") | " + grid[it][jt].getNumOptions());
                                                        }

                                                        if(location != -1 && !( (r == i && c == j) || (r == it && c == jt) ) ) {
                                                            grid[r][c].notes[location] = 0;
                                                            if(debugPrint){println("% passed gate 6" );}
                                                        }
                                                        else if(debugPrint){println(" one of the pair cells: Skipped" );}
                                                    }
                                                }

                                                if(grid[r][c].getNumOptions() == 1){
                                                    val1 = grid[r][c].oVal1;
                                                    grid[r][c].setVal(val1);        // should be solved now
                                                    if(debugPrint){println("passed gate 7" );}
                                                    return;
                                                }
                                            //}
                                        }
                                    }
                                }
                            }                        
                        }
                    }
                }
            }
        }
    }
}