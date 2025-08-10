// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MaximumGold {
    function getMaxGold(uint[][] memory grid) public pure returns (uint) {
        uint m = grid.length;
        uint n = grid[0].length;
        uint maxGold = 0;

        for (uint i = 0; i < m; i++) {
            for (uint j = 0; j < n; j++) {
                if (grid[i][j] > 0) {
                    maxGold = max(maxGold, dfs(grid, i, j, m, n));
                }
            }
        }

        return maxGold;
    }

    function dfs(uint[][] memory grid, uint x, uint y, uint m, uint n) private pure returns (uint) {
        if (x >= m || y >= n || grid[x][y] == 0) return 0;

        // Collect gold at the current cell
        uint gold = grid[x][y];
        grid[x][y] = 0;  // Mark the cell as visited by setting gold to 0

        // Explore all four possible directions
        uint maxGold = 0;
        maxGold = max(maxGold, dfs(grid, x + 1, y, m, n));
        maxGold = max(maxGold, dfs(grid, x - 1, y, m, n));
        maxGold = max(maxGold, dfs(grid, x, y + 1, m, n));
        maxGold = max(maxGold, dfs(grid, x, y - 1, m, n));

        // Return the gold to the cell as we backtrack
        grid[x][y] = gold;

        return gold + maxGold;
    }

    function max(uint a, uint b) private pure returns (uint) {
        return a > b ? a : b;
    }
}
