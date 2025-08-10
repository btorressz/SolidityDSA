// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PerfectSquares {
    // Function to find the minimum number of perfect squares that sum up to `n`
    function minNumSquares(uint n) public pure returns (uint) {
        // Dynamic programming array
        uint[] memory dp = new uint[](n + 1);
        
        // Initialize with a large number
        for (uint i = 0; i <= n; i++) {
            dp[i] = n + 1; // Use n + 1 as the "infinity" value (larger than any possible number of pieces)
        }
        dp[0] = 0;

        // Fill dp array
        for (uint i = 1; i <= n; i++) {
            for (uint j = 1; j * j <= i; j++) {
                dp[i] = min(dp[i], dp[i - j * j] + 1);
            }
        }

        // The answer for dp[n]
        return dp[n];
    }

    // Helper function to find minimum of two numbers
    function min(uint a, uint b) private pure returns (uint) {
        return a < b ? a : b;
    }
}
