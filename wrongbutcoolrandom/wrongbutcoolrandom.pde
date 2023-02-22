/*
John Conway's Game of Life
Rules:
1) A live cell dies if it has fewer than two live neighbors
2) A live cell with two or three live neighbors lives on to the next generation
3) A live cell with more than three live neighbors dies
4) A dead cell will be brought back to live if it has exactly three live neighbors
*/

int windowsize = 1300;
int cellsize = 4; // wimdowsize needs to evenly divide by cellsize and cannot be 1

int[][] board = new int[windowsize/cellsize][windowsize/cellsize];

void settings(){
    size(windowsize, windowsize);
    
}

void setup(){
    background(0, 0, 0);
    colorMode(RGB);
    setboard();
    //frameRate(60);
}

void setboard(){ // random board for this sketch
    for (int i = 0; i < width; i = i + cellsize){
        for (int j = 0; j < height; j = j + cellsize){
            int rand = int(random(10));
            if (rand == 1){
                fill(0, 255, 0);
                rect(i, j, cellsize, cellsize);
                board[i/cellsize][j/cellsize] = rand;
            }
        }
    }

}

void draw(){
    for (int i = 0; i < board.length; i++){
        for (int j = 0; j < board[i].length; j++){
            int numofneighbors = numneighbors(i, j);
            //println("(" + i + ", " + j + "): " + numofneighbors);

            if (numofneighbors < 2){ // RULE 1

                fill(0, 0, 0);
                rect(i * cellsize, j * cellsize, cellsize, cellsize);
                fill(0, 255, 0);
                board[i][j] = 0;
            }
            else if (numofneighbors > 3){ // RULE 3

                fill(0, 0, 0);
                rect(i * cellsize, j * cellsize, cellsize, cellsize);
                fill(0, 255, 0);
                board[i][j] = 0;
            }
            else if (numofneighbors == 3 && board[i][j] == 0){ // RULE 4
                fill(0, 255, 0);
                rect(i * cellsize, j * cellsize, cellsize, cellsize);
                board[i][j]= 1;
            }
        }
    }
}

int numneighbors(int i, int j){
    int num = 0;
    int far = windowsize/cellsize - 1;
    if (i != 0 && i != far && j != 0 && j != far){ // PIXEL IS NOT ON THE EDGES
        if (board[i][j-1] == 1){ // left
            num++;
        }
        if (board[i][j+1] == 1){ // right
            num++;
        }
        if (board[i-1][j] == 1){ // top
            num++;
        }
        if (board[i+1][j] == 1){ // bottom
            num++;
        }
        if (board[i-1][j-1] == 1){ // top left
            num++;
        }
        if (board[i+1][j-1] == 1){ // bottom left
            num++;
        }
        if (board[i-1][j+1] == 1){ // top right
            num++;
        }
        if (board[i+1][j+1] == 1){ // bottom right
            num++;
        }
    }
    else{
        if (i == 0 && j == 0){ // PIXEL IS TOP LEFT 

            if (board[i][j+1] == 1){ // right
                num++;
            }
            if (board[i+1][j+1] == 1){ // bottom right
                num++;
            } 
            if (board[i+1][j] == 1){ // bottom
                num++;
            } 
            if (board[i+1][far] == 1){ // bottom left (wraps to far right of board)
                num++;
            } 
            if (board[i][far] == 1){ // left (wraps to far right of board)
                num++;
            } 
            if (board[far][j] == 1){ // top (wraps to the bottom of board)
                num++;
            } 
            if (board[far][j+1] == 1){ // top right (wrap to bottom of board)
                num++;
            } 
            if (board[far][far] == 1){ // top left (wrap to bottom right of board)
                num++;
            } 
        }
        else if (i == 0 && j == far) { // PIXEL IS TOP RIGHT

            if (board[i][j-1] == 1){ // left
                num++;
            }
            if (board[i+1][j-1] == 1){ // bottom left
                num++;
            }
            if (board[i+1][j] == 1){ // bottom
                num++;
            }
            if (board[i+1][0] == 1){ // bottom right (wraps to left side of board)
                num++;
            }
            if (board[i][0] == 1){ // right (wraps to left side of board )
                num++;
            }
            if (board[far][j-1] == 1){ // top left (wraps to bottom of board)
                num++;
            }
            if (board[far][j] == 1){ // top (wraps to bottom of board)
                num++;
            }
            if (board[far][0] == 1){ // top right (wrap to bottom left of board)
                num++;
            }
        }
        else if (i == far && j == 0){ // PIXEL IS BOTTOM LEFT

            if (board[i-1][j] == 1){ // top
                num++;
            }
            if (board[i-1][j+1] == 1){ // top right
                num++;
            }
            if (board[i][j+1] == 1){ // right
                num++;
            }
            if (board[0][j+1] == 1){ // bottom right (wraps to top of board)
                num++;
            }
            if (board[0][j] == 1){ // bottom (wraps to top of board)
                num++;
            }
            if (board[0][far] == 1){ // bottom left (wraps to top right of board)
                num++;
            }
            if (board[i][far] == 1){ // left (wraps to right of board)
                num++;
            }
            if (board[i-1][far] == 1){ // top left (wraps to right of board)
                num++;
            }
        }
        else if (i == far && j == far){ // PIXEL IS BOTTOM RIGHT

            if (board[i-1][j] == 1){ // top
                num++;
            }
            if (board[i-1][j-1] == 1){ // top left
                num++;
            }
            if (board[i][j-1] == 1){ // left
                num++;
            }
            if (board[0][j-1] == 1){ // bottom left (wraps to top of board)
                num++;
            }
            if (board[0][j] == 1){ // bottom (wraps to top of board)
                num++;
            }
            if (board[0][0] == 1){ // bottom right (wraps to top left of board)
                num++;
            }
            if (board[i][0] == 1){ // right (wraps to left of board)
                num++;
            }
            if (board[i-1][0] == 1){ // top right (wraps to left of board)
                num++;
            } 
        }
        else if (j == 0){ // SOMEWHERE IN LEFT COLUMN (NOT CORNERS)

            if (board[i-1][j] == 1){ // top
                num++;
            }
            if (board[i-1][j+1] == 1){ // top right
                num++;
            }
            if (board[i][j+1] == 1){ // right
                num++;
            }
            if (board[i+1][j+1] == 1){ // bottom right
                num++;
            }
            if (board[i+1][j] == 1){ // bottom
                num++;
            }
            if (board[i+1][far] == 1){ // bottom left (wraps to right of board)
                num++;
            }
            if (board[i][far] == 1){ // left (wraps to right of board)
                num++;
            }
            if (board[i-1][far] == 1){ // top left (wraps to right of board)
                num++;
            } 
        }
        else if (i == 0){ // SOMEWHERE IN TOP ROW (NOT CORNERS)

            if (board[i][j+1] == 1){ // right
                num++;
            }
            if (board[i+1][j+1] == 1){ // bottom right
                num++;
            }
            if (board[i+1][j] == 1){ // bottom
                num++;
            }
            if (board[i+1][j-1] == 1){ // bottom left
                num++;
            }
            if (board[i][j-1] == 1){ // left
                num++;
            }
            if (board[far][j-1] == 1){ // top left (wraps to bottom of board)
                num++;
            } 
            if (board[far][j] == 1){ // top (wraps to bottom of board)
                num++;
            }
            if (board[far][j+1] == 1){ // top right (wraps to bottom of board)
                num++;
            } 
        }
        else if (i == far){ // SOMEWHERE IN BOTTOM ROW (NOT CORNERS)

            if (board[i][j-1] == 1){ // left
                num++;
            }
            if (board[i-1][j-1] == 1){ // top left
                num++;
            }
            if (board[i-1][j] == 1){ // top
                num++;
            }
            if (board[i-1][j+1] == 1){ // top right
                num++;
            }
            if (board[i][j+1] == 1){ // right
                num++;
            }
            if (board[0][j+1] == 1){ // bottom right (wraps to top of board)
                num++;
            }
            if (board[0][j] == 1){ // bottom (wraps to top of board)
                num++;
            }
            if (board[0][j-1] == 1){ // bottom left (wraps to top of board)
                num++;
            } 
        }
        else if (j ==  far){ // SOMEWHERE ON RIGHT COLUMN (NOT CORNERS)

            if (board[i+1][j] == 1){ // bottom
                num++;
            }
            if (board[i+1][j-1] == 1){ // bottom left
                num++;
            }
            if (board[i][j-1] == 1){ // left
                num++;
            }
            if (board[i-1][j-1] == 1){ // top left
                num++;
            }
            if (board[i-1][j] == 1){ // top
                num++;
            }
            if (board[i-1][0] == 1){ // top right (wraps to left of board)
                num++;
            }
            if (board[i][0] == 1){ // right (wraps to left of board)
                num++;
            }
            if (board[i+1][0] == 1){ // bottom right (wraps to left of board)
                num++;
            } 
        }
    }
    return num;
}
