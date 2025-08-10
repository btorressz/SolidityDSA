// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NearestExitInMaze {
    struct Position {
        uint row;
        uint col;
    }
    
    // Define directions for moving
    int[4] private dx = [int(0), int(0), int(1), int(-1)];
    int[4] private dy = [int(1), int(-1), int(0), int(0)];
    
    function nearestExitLength(bytes[] memory maze, uint entranceRow, uint entranceCol) public pure returns (int) {
        uint m = maze.length;
        uint n = maze[0].length;
        
        bool[m][n] memory visited;
        
        Position[] memory queue = new Position[](m * n);
        uint front = 0;
        uint rear = 0;
        
        queue[rear++] = Position(entranceRow, entranceCol);
        visited[entranceRow][entranceCol] = true;
        
        int steps = 0;
        
        while (front < rear) {
            uint size = rear - front;
            for (uint k = 0; k < size; k++) {
                Position memory current = queue[front++];
                
                if (isExit(current, m, n)) {
                    return steps;
                }
                
                for (uint d = 0; d < 4; d++) {
                    int x = int(current.row) + dx[d];
                    int y = int(current.col) + dy[d];
                    
                    if (isValid(x, y, m, n) && !visited[uint(x)][uint(y)] && maze[uint(x)][uint(y)] == bytes1('.')) {
                        visited[uint(x)][uint(y)] = true;
                        queue[rear++] = Position(uint(x), uint(y));
                    }
                }
            }
            steps++;
        }
        
        return -1;
    }
    
    function isValid(int x, int y, uint m, uint n) private pure returns (bool) {
        return x >= 0 && x < int(m) && y >= 0 && y < int(n);
    }
    
    function isExit(Position memory pos, uint m, uint n) private pure returns (bool) {
        return pos.row == 0 || pos.col == 0 || pos.row == m - 1 || pos.col == n - 1;
    }
}
