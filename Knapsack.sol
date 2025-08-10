// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Knapsack {
    // Function to solve the 0/1 Knapsack problem
    function knapsack(uint[] memory values, uint[] memory weights, uint capacity) public pure returns (uint) {
        uint n = values.length;
        require(weights.length == n, "Values and weights must be of the same length");

        uint[][] memory dp = new uint[][](n + 1);
        for (uint i = 0; i <= n; i++) {
            dp[i] = new uint[](capacity + 1);
        }

        for (uint i = 1; i <= n; i++) {
            for (uint w = 0; w <= capacity; w++) {
                if (weights[i - 1] <= w) {
                    dp[i][w] = max(dp[i - 1][w], dp[i - 1][w - weights[i - 1]] + values[i - 1]);
                } else {
                    dp[i][w] = dp[i - 1][w];
                }
            }
        }

        return dp[n][capacity];
    }

    // Helper function to find maximum of two numbers
    function max(uint a, uint b) private pure returns (uint) {
        return a > b ? a : b;
    }
}
