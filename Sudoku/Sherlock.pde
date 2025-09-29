//this is Sherlock, a sudoku solving machine 


int[] options(){
    int[] numbers = { 1, 2, 3, 4, 5, 6, 7, 8, 9 };
    return numbers;
}


void singles(){
    for(int i = 0; i < rows; i++){
        for (int j = 0; j < cols; j++){
            //iterate through every cell
            //for every cell check the sorrounding grid, and the column and row in question
            // narrow down if there is only one thing it could be
            //TODO: add searchGrid functionality

            int[] options = options(); //initialize a tally of numbers 1- 9
            int numOptions = 9; //number of options remaining

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

            //add searchGrid functionality here

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