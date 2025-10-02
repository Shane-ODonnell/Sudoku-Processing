//this is Sherlock, a sudoku solving machine 

void sherlock(){
  while(!complete()){
    singles();
    hiddenSingles();
    finishGrid();
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
                //
            }

            if( numOptions == 1){
                //if there is only one option left, fill it in
                for( int k = 0; k < options.length; k++){
                    if( options[k] != 0 && grid[i][j].value == 0){
                        println("setting " + i + ", " + j + " to be " + k);
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

void dualPairs(){
    //iterate through all cells
    //check options for current cell. if count == 2
    //check if there is a related cell with an identical set of options
    //if there is then remove those 2 options from the arrays of every other related cell

    for(int i = 0; i < rows; i++){
        for(int j = 0; j < cols; j++){

            int [] options = options(i,j);
            int count = notZeros(options); //how many options does this cell have 
            boolean found = false;
            int fi = -1, fj = -1;

            if(count == 2){
                //check if there is a related cell with an identical options array
                //iterate through related cells
            
                for (int it = 0; it < rows; it++){
                    if( it != i ){
                        int [] curr = options(it,j);
                        if( curr == options){
                            //found a dual pair
                            fi = it;
                            fj = j;
                            found = true;
                            it = rows; //break loop
                        }
                    }
                }//close for (it)
            
                if( !found ){
                    for (int jt = 0; jt < cols; jt++){
                        if( jt != j){
                            int [] curr = options(i,jt);
                            if( curr == options){
                                //found a dual pair
                                fi = i;
                                fj = jt;
                                found = true;
                                jt = rows; //break loop
                            }
                        }
                    }//close for (jt)
                }//close if !found
                
                if(!found){
                    int currBox = getBox(i,j);
                    for(int it = 0; it < rows; it++){
                        for(int jt = 0; jt < cols; jt++){
                            if((it != i && j!= j) && currBox == getBox(i,j)){
                                //iterate through the cells in the same box
                                int [] curr = options(it,jt);
                                if( curr == options){
                                    //found a dual pair
                                    fi = it;
                                    fj = jt;
                                    found = true;
                                    jt = rows; //break loop
                                    it = rows;
                                }
                            }
                        }//close for (jt)
                    }//close for (it)
                }//close box search if !found

                if(found){
                    // now we have two related cells which each have the same 2 options (i,j) and (fi,fj)
                    /* 
                        let a & b be these options
                        now we need to remove those options from the other related cells and then see if that makes the puzzle any easier
                        since I dont actually store the options arrays this could be tricky
                    //*/
                    /* 
                        Either
                        I check related cells and see if they have two options
                        where 1 of which is a||b
                        then replace that cell with the option that isnt ab
                        OR
                            I can call this function somewhat recursively in the current options() 
                            to aid in the elimination of false options.
                            //gonna try the first thing first
                    //*/
                    //lets get a and b actually
                    int a = -1 ,b = -1;

                    for(int k = 0; k < cols; k++){
                        if(options[k] != 0){
                            if( a == b)
                                a = options[k];
                            else {
                                b = options[k];
                                k = cols;
                            }
                        }
                    }
                    //we now have a and b
                    //now search related cells that arent part of the pair
                    //if they have only two options
                    //if either option == a || b
                    //solve

                    for(int it = 0; it < rows; it++){
                        if( it != i && it != fi ){

                            int c = 0;
                            int jTemp = j; //first check j

                            for ( int w = 1; w != 5; w++ ){

                                if(w == 2){
                                    jTemp = fj; //2nd check fj
                                }

                                int [] curr = options(it,jTemp); //same thing needs to happen for fj

                                if( w <= 3 && (it != j && it != fj) ){
                                    jTemp = i; //gonna check the cols too while im here
                                    if( w == 4){
                                        jTemp = fi;
                                    }
                                    curr = options(jTemp, it);
                                }

                                if( notZeros(curr) == 2 ){
                                    //this cell is related to the pair and has only 2 options
                                    if( within(a, curr) || within(b, curr) ){
                                        //strike
                                        
                                        if(within(a, curr)){
                                            // find the other value
                                            
                                            for(int l = 0; l < cols; l++){
                                                if(curr[l] != 0 && curr[l] != a ){
                                                    c = curr[l];
                                                }
                                            }//close for (l)
                                                                            
                                        }
                                        else{
                                            for(int l = 0; l < cols; l++){
                                                if(curr[l] != 0 && curr[l] != b ){
                                                    c = curr[l];
                                                }
                                            }//close for (l)
                                        }
                                    }
                                }
                                
                                if(c != 0){
                                    //now let this cell equal c
                                    if( w < 3)
                                        grid[it][jTemp].setVal(c); 
                                    else
                                        grid[jTemp][it].setVal(c); 
                                    w = 5;
                                    it = rows;
                                    j = cols;
                                    i = rows;
                                    //break tf outta here
                                }
                                
                            }//close for (w)
                        }
                    }//clsoe for (it)

                }//close if found
            }
        }//close for (j)
    }//close for (i)

}//close fx

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

int notZeros(int [] array){
    //how many not zero ints are in the array
    int count = 0;
    for(int k = 0; k < array.length; k++){
        if(array[k] > 0){
            count++;
        }//close if
    }//close for (k)

    return count;

}
