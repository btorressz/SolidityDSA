pragma solidity ^0.8.0;

contract RottingOranges {
    // Define the grid dimensions
    uint constant private m = 2;
    uint constant private n = 3;
    
    // Define directions for adjacent cells
    int[4] private dx = [int(0), int(0), int(1), int(-1)];
    int[4] private dy = [int(1), int(-1), int(0), int(0)];
    
    function orangesRotting(uint8[m][n] memory grid) public pure returns (int) {
        // Initialize queue for BFS
        uint[m*n] memory queue;
        uint front = 0;
        uint rear = 0;
        
        // Count fresh oranges
        uint freshOranges = 0;
        
        // Push rotten oranges into the queue and count fresh oranges
        for (uint i = 0; i < m; i++) {
            for (uint j = 0; j < n; j++) {
                if (grid[i][j] == 2) {
                    queue[rear++] = i * n + j;
                } else if (grid[i][j] == 1) {
                    freshOranges++;
                }
            }
        }
        
        // Initialize minutes
        uint minutes = 0;
        
        // Start BFS
        while (front < rear && freshOranges > 0) {
            uint size = rear - front;
            for (uint k = 0; k < size; k++) {
                uint current = queue[front++];
                uint row = current / n;
                uint col = current % n;
                
                // Check adjacent cells
                for (uint d = 0; d < 4; d++) {
                    uint x = row + uint(dx[d]);
                    uint y = col + uint(dy[d]);
                    
                    // Check if the adjacent cell is valid and has a fresh orange
                    if (x < m && y < n && grid[x][y] == 1) {
                        grid[x][y] = 2; // Rot the fresh orange
                        freshOranges--;
                        queue[rear++] = x * n + y;
                    }
                }
            }
            minutes++;
        }
        
        // If there are still fresh oranges, return -1, otherwise return minutes
        if (freshOranges > 0) {
            return -1;
        } else {
            return int256(minutes);
        }
    }
}
