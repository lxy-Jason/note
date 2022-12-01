```js
/**
 * @param {number[][]} matrix
 * @return {number[]}
 */
var spiralOrder = function(matrix) {
    if(!matrix[0]) return []
    let startx = 0, starty = 0, offset = 1;
    let row = matrix[0].length;
    let col = matrix.length;
    let count = row * col;
    let loop = Math.floor(Math.max(row,col) / 2);
    let mid = loop;
    let i,j;
    let res = [];

    while(loop--){
        i = startx;
        j = starty;

        for(; j < row - offset; j++){
            res.push(matrix[i][j])
            if(res.length === count){
                return res;
            }
        }
        for(; i < col - offset; i++){
            res.push(matrix[i][j]);
            if(res.length === count){
                return res;
            }
        }
        for(; j > starty; j--){
            res.push(matrix[i][j]);
            if(res.length === count){	
                return res;
            }
        }
        for(; i > startx; i--){
            res.push(matrix[i][j]);
            if(res.length === count){
                return res;
            }
        }
        startx++
        starty++
        offset++
    }
    if(col % 2 !== 0 || row % 2 !== 0){
        res.push(matrix[mid][mid])
    }
    return res;
}; 
```

