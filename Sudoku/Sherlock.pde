//this is Sherlock, a sudoku solving machine 

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

    return options;
}

void hiddenSinglesTest(){
    //check every row colm and grid. 
    //check the options array of each of the cells in those categories
    //if a given number only appears once, fill it in.

    for(int i = 0; i < rows; i++){
        for (int j = 0; j < cols; j++){
            //iterate through the cells.
            if( grid[i][j].val() == 0){ //TODO idk if this is meant to be for empty or ! Cells
                for(int k = 1; k <= 9; k++){ //we want to check if each possible value is only able to go in one place
                    int occurances = 0; 
                    boolean NA = false;
                    // we want tok count how many of the rows options arrays feature this value k
                    //check the sorrounding row
                    for (int it = 0; it < rows; it++){
                        int val = grid[it][j].val();
                        if(val == k){
                            //if one of the cells in the row is equal to the k we are looking to add
                            //then we dont need to add it 
                            NA = true;//break loop
                            it = rows;
                        }
                        //from here k is a valid target 
                        if( val == 0 ){//if the cell is empty 
                            int[] Options = options(it,j);

                            if(within(k, Options)){
                                occurances++;
                            }//close if

                            if(occurances > 1){
                                break; //break loop
                            }

                        }//close if 
                    }//close for (it)
                    if(NA) break;


                }//close for (k)
            }//close if
        }//close for (j)
    }//close for (i)
}

boolean within(int val, int [] array){
    //return true if val exists in the array
    for(int i = 0; i < 9; i++){
        if(array[i] == val){
            return true;
        }
    }
    return false;
}