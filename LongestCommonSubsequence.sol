// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LongestCommonSubsequence {
    // Function to find the length of the longest common subsequence
    function lcs(string memory x, string memory y) public pure returns (uint) {
        bytes memory s1 = bytes(x);
        bytes memory s2 = bytes(y);
        uint m = s1.length;
        uint n = s2.length;
        uint[][] memory dp = new uint[][](m + 1);

        for (uint i = 0; i <= m; i++) {
            dp[i] = new uint[](n + 1);
        }

        // Build the dp array from bottom up
        for (uint i = 0; i <= m; i++) {
            for (uint j = 0; j <= n; j++) {
                if (i == 0 || j == 0) {
                    dp[i][j] = 0; // Initialize the borders to zero
                } else if (s1[i - 1] == s2[j - 1]) {
                    dp[i][j] = dp[i - 1][j - 1] + 1; // If characters match, increment the count from the diagonal
                } else {
                    dp[i][j] = max(dp[i - 1][j], dp[i][j - 1]); // Take the maximum of left and top cells
                }
            }
        }

        return dp[m][n]; // The bottom-right cell will have the length of the LCS
    }

    // Helper function to find maximum of two numbers
    function max(uint a, uint b) private pure returns (uint) {
        return a > b ? a : b;
    }
}
