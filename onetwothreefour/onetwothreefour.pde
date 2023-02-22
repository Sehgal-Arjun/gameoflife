/*
John Conway's Game of Life
Rules:
1) A live cell dies if it has fewer than two live neighbors
2) A live cell with two or three live neighbors lives on to the next generation
3) A live cell with more than three live neighbors dies
4) A dead cell will be brought back to live if it has exactly three live neighbors
*/

int windowsize = 650;
int cellsize = 50; // wimdowsize needs to evenly divide by cellsize and cannot be 1

int[][] board = 
{   {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0},
    {0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0},
    {0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 0},
    {0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0},
    {0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
};

ArrayList<Integer> iplc = new ArrayList<Integer>();
ArrayList<Integer> jplc = new ArrayList<Integer>();
ArrayList<Integer> ito0 = new ArrayList<Integer>();
ArrayList<Integer> ito1 = new ArrayList<Integer>();
ArrayList<Integer> jto0 = new ArrayList<Integer>();
ArrayList<Integer> jto1 = new ArrayList<Integer>();

void settings(){
    size(windowsize, windowsize);
    
}

void setup(){
    background(0, 0, 0);
    colorMode(RGB);
    setboard();
    frameRate(60);
    //printboard();
}

void setboard(){ // onetwothree pattern board

    for (int i = 0; i < board.length; i++){
        for (int j = 0; j < board[i].length; j++){
            if (board[i][j] == 1){
                fill(0, 255, 0);
                rect(j*cellsize, i*cellsize, cellsize, cellsize); // j and then i bc j is the row and i is the col
            }
            else{
                fill(0, 0, 0);
                rect(j*cellsize, i*cellsize, cellsize, cellsize);
            }
        }
    }

}

void draw(){
    
    if (frameCount % 120 == 0){
        for (int i = 0; i < board.length; i++){
            for (int j = 0; j < board[i].length; j++){
                int numofneighbors = numneighbors(i, j, board);
                //println("(" + i + ", " + j + "): " + numofneighbors
                
                if (numofneighbors == 3){ // RULE 4
                    ito1.add(i);
                    jto1.add(j);
                }
                else{
                    if (numofneighbors < 2){ // RULE 1
                        //board[i][j] = 0;
                        ito0.add(i);
                        jto0.add(j);
                    }
                    else if (numofneighbors > 3){ // RULE 3
                        //board[i][j] = 0;
                        ito0.add(i);
                        jto0.add(j);
                    }
                }
            }
        }
        for (int x = 0; x < ito0.size(); x++){
            board[ito0.get(x)][jto0.get(x)] = 0;
        }
        for (int x = 0; x < ito1.size(); x++){
            board[ito1.get(x)][jto1.get(x)] = 1;
        }
        ito0 = new ArrayList<Integer>();
        ito1 = new ArrayList<Integer>();
        jto0 = new ArrayList<Integer>();
        jto1 = new ArrayList<Integer>();
        setboard();
    }
}

int numneighbors(int i, int j, int[][] currboard){
    int num = 0;
    int far = windowsize/cellsize - 1;
    if (i != 0 && i != far && j != 0 && j != far){ // PIXEL IS NOT ON THE EDGES
        if (currboard[i][j-1] == 1){ // left
            num++;
        }
        if (currboard[i][j+1] == 1){ // right
            num++;
        }
        if (currboard[i-1][j] == 1){ // top
            num++;
        }
        if (currboard[i+1][j] == 1){ // bottom
            num++;
        }
        if (currboard[i-1][j-1] == 1){ // top left
            num++;
        }
        if (currboard[i+1][j-1] == 1){ // bottom left
            num++;
        }
        if (currboard[i-1][j+1] == 1){ // top right
            num++;
        }
        if (currboard[i+1][j+1] == 1){ // bottom right
            num++;
        }
    }
    else{
        if (i == 0 && j == 0){ // PIXEL IS TOP LEFT 

            if (currboard[i][j+1] == 1){ // right
                num++;
            }
            if (currboard[i+1][j+1] == 1){ // bottom right
                num++;
            } 
            if (currboard[i+1][j] == 1){ // bottom
                num++;
            } 
            if (currboard[i+1][far] == 1){ // bottom left (wraps to far right of board)
                num++;
            } 
            if (currboard[i][far] == 1){ // left (wraps to far right of board)
                num++;
            } 
            if (currboard[far][j] == 1){ // top (wraps to the bottom of board)
                num++;
            } 
            if (currboard[far][j+1] == 1){ // top right (wrap to bottom of board)
                num++;
            } 
            if (currboard[far][far] == 1){ // top left (wrap to bottom right of board)
                num++;
            } 
        }
        else if (i == 0 && j == far) { // PIXEL IS TOP RIGHT

            if (currboard[i][j-1] == 1){ // left
                num++;
            }
            if (currboard[i+1][j-1] == 1){ // bottom left
                num++;
            }
            if (currboard[i+1][j] == 1){ // bottom
                num++;
            }
            if (currboard[i+1][0] == 1){ // bottom right (wraps to left side of board)
                num++;
            }
            if (currboard[i][0] == 1){ // right (wraps to left side of board )
                num++;
            }
            if (currboard[far][j-1] == 1){ // top left (wraps to bottom of board)
                num++;
            }
            if (currboard[far][j] == 1){ // top (wraps to bottom of board)
                num++;
            }
            if (currboard[far][0] == 1){ // top right (wrap to bottom left of board)
                num++;
            }
        }
        else if (i == far && j == 0){ // PIXEL IS BOTTOM LEFT

            if (currboard[i-1][j] == 1){ // top
                num++;
            }
            if (currboard[i-1][j+1] == 1){ // top right
                num++;
            }
            if (currboard[i][j+1] == 1){ // right
                num++;
            }
            if (currboard[0][j+1] == 1){ // bottom right (wraps to top of board)
                num++;
            }
            if (currboard[0][j] == 1){ // bottom (wraps to top of board)
                num++;
            }
            if (currboard[0][far] == 1){ // bottom left (wraps to top right of board)
                num++;
            }
            if (currboard[i][far] == 1){ // left (wraps to right of board)
                num++;
            }
            if (currboard[i-1][far] == 1){ // top left (wraps to right of board)
                num++;
            }
        }
        else if (i == far && j == far){ // PIXEL IS BOTTOM RIGHT

            if (currboard[i-1][j] == 1){ // top
                num++;
            }
            if (currboard[i-1][j-1] == 1){ // top left
                num++;
            }
            if (currboard[i][j-1] == 1){ // left
                num++;
            }
            if (currboard[0][j-1] == 1){ // bottom left (wraps to top of board)
                num++;
            }
            if (currboard[0][j] == 1){ // bottom (wraps to top of board)
                num++;
            }
            if (currboard[0][0] == 1){ // bottom right (wraps to top left of board)
                num++;
            }
            if (currboard[i][0] == 1){ // right (wraps to left of board)
                num++;
            }
            if (currboard[i-1][0] == 1){ // top right (wraps to left of board)
                num++;
            } 
        }
        else if (j == 0){ // SOMEWHERE IN LEFT COLUMN (NOT CORNERS)

            if (currboard[i-1][j] == 1){ // top
                num++;
            }
            if (currboard[i-1][j+1] == 1){ // top right
                num++;
            }
            if (currboard[i][j+1] == 1){ // right
                num++;
            }
            if (currboard[i+1][j+1] == 1){ // bottom right
                num++;
            }
            if (currboard[i+1][j] == 1){ // bottom
                num++;
            }
            if (currboard[i+1][far] == 1){ // bottom left (wraps to right of board)
                num++;
            }
            if (currboard[i][far] == 1){ // left (wraps to right of board)
                num++;
            }
            if (currboard[i-1][far] == 1){ // top left (wraps to right of board)
                num++;
            } 
        }
        else if (i == 0){ // SOMEWHERE IN TOP ROW (NOT CORNERS)

            if (currboard[i][j+1] == 1){ // right
                num++;
            }
            if (currboard[i+1][j+1] == 1){ // bottom right
                num++;
            }
            if (currboard[i+1][j] == 1){ // bottom
                num++;
            }
            if (currboard[i+1][j-1] == 1){ // bottom left
                num++;
            }
            if (currboard[i][j-1] == 1){ // left
                num++;
            }
            if (currboard[far][j-1] == 1){ // top left (wraps to bottom of board)
                num++;
            } 
            if (currboard[far][j] == 1){ // top (wraps to bottom of board)
                num++;
            }
            if (currboard[far][j+1] == 1){ // top right (wraps to bottom of board)
                num++;
            } 
        }
        else if (i == far){ // SOMEWHERE IN BOTTOM ROW (NOT CORNERS)

            if (currboard[i][j-1] == 1){ // left
                num++;
            }
            if (currboard[i-1][j-1] == 1){ // top left
                num++;
            }
            if (currboard[i-1][j] == 1){ // top
                num++;
            }
            if (currboard[i-1][j+1] == 1){ // top right
                num++;
            }
            if (currboard[i][j+1] == 1){ // right
                num++;
            }
            if (currboard[0][j+1] == 1){ // bottom right (wraps to top of board)
                num++;
            }
            if (currboard[0][j] == 1){ // bottom (wraps to top of board)
                num++;
            }
            if (currboard[0][j-1] == 1){ // bottom left (wraps to top of board)
                num++;
            } 
        }
        else if (j ==  far){ // SOMEWHERE ON RIGHT COLUMN (NOT CORNERS)

            if (currboard[i+1][j] == 1){ // bottom
                num++;
            }
            if (currboard[i+1][j-1] == 1){ // bottom left
                num++;
            }
            if (currboard[i][j-1] == 1){ // left
                num++;
            }
            if (currboard[i-1][j-1] == 1){ // top left
                num++;
            }
            if (currboard[i-1][j] == 1){ // top
                num++;
            }
            if (currboard[i-1][0] == 1){ // top right (wraps to left of board)
                num++;
            }
            if (currboard[i][0] == 1){ // right (wraps to left of board)
                num++;
            }
            if (currboard[i+1][0] == 1){ // bottom right (wraps to left of board)
                num++;
            } 
        }
    }
    return num;
}

void printboard(){
    println();
    for (int i = 0; i < board.length; i++){
        for (int j = 0; j < board[i].length; j++){
            print(board[i][j]);
        }
        println();
    }
}
