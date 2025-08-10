// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MinCostClimbingStairs {
    // Function to return the minimum cost to reach the top of the floor
    function minCostClimbingStairs(uint[] memory cost) public pure returns (uint) {
        uint n = cost.length;
        if (n == 2) {
            return min(cost[0], cost[1]);
        }

        // Extend the cost array to accommodate the top of the floor beyond the last step
        uint[] memory dp = new uint[](n + 1);
        dp[0] = cost[0];
        dp[1] = cost[1];

        for (uint i = 2; i <= n; i++) {
            uint currentCost = (i == n) ? 0 : cost[i]; // Cost for the last step beyond the array is 0
            dp[i] = min(dp[i - 1], dp[i - 2]) + currentCost;
        }

        // The last entry in dp array will hold the minimum cost to reach the top
        return dp[n];
    }

    // Helper function to find the minimum of two numbers
    function min(uint a, uint b) private pure returns (uint) {
        return a < b ? a : b;
    }
}
