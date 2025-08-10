// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EditDistance {
    function minDistance(string memory word1, string memory word2) public pure returns (uint) {
        bytes memory w1 = bytes(word1);
        bytes memory w2 = bytes(word2);
        uint len1 = w1.length;
        uint len2 = w2.length;

        uint[][] memory dp = new uint[][](len1 + 1);
        for (uint i = 0; i <= len1; i++) {
            dp[i] = new uint[](len2 + 1);
        }

        // Initialize the boundary of the DP table
        for (uint i = 0; i <= len1; i++) {
            dp[i][0] = i;
        }
        for (uint j = 0; j <= len2; j++) {
            dp[0][j] = j;
        }

        // Fill the DP table
        for (uint i = 1; i <= len1; i++) {
            for (uint j = 1; j <= len2; j++) {
                if (w1[i - 1] == w2[j - 1]) {
                    dp[i][j] = dp[i - 1][j - 1]; // no operation needed
                } else {
                    uint insertOp = dp[i][j - 1] + 1;
                    uint deleteOp = dp[i - 1][j] + 1;
                    uint replaceOp = dp[i - 1][j - 1] + 1;
                    dp[i][j] = min(insertOp, min(deleteOp, replaceOp));
                }
            }
        }

        return dp[len1][len2];
    }

    // Helper function to find minimum value
    function min(uint a, uint b) private pure returns (uint) {
        return a < b ? a : b;
    }
}
