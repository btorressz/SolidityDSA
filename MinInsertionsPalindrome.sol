// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MinInsertionsPalindrome {
    function minInsertions(string memory s) public pure returns (uint) {
        bytes memory str = bytes(s);
        uint n = str.length;
        uint[][] memory dp = new uint[][](n);
        
        for (uint i = 0; i < n; i++) {
            dp[i] = new uint[](n);
        }
        
        // Single characters are palindromes of length 1
        for (uint i = 0; i < n; i++) {
            dp[i][i] = 1;
        }
        
        // Build the dp array
        for (uint len = 2; len <= n; len++) { // length of the substring
            for (uint i = 0; i <= n - len; i++) {
                uint j = i + len - 1;
                if (str[i] == str[j]) {
                    dp[i][j] = (i + 1 <= j - 1) ? dp[i + 1][j - 1] + 2 : 2;
                } else {
                    dp[i][j] = (dp[i + 1][j] > dp[i][j - 1]) ? dp[i + 1][j] : dp[i][j - 1];
                }
            }
        }
        
        // The minimum insertions needed
        return n - dp[0][n - 1];
    }
}
