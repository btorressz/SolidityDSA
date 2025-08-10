// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract OnesAndZeroes {
    function findMaxForm(string[] memory strs, uint m, uint n) public pure returns (uint) {
        // Create a 2D array for dynamic programming
        uint[][] memory dp = new uint[][](m + 1);
        for (uint i = 0; i <= m; i++) {
            dp[i] = new uint[](n + 1);
        }

        // Iterate through each string
        for (uint i = 0; i < strs.length; i++) {
            // Count zeros and ones in the current string
            (uint zeros, uint ones) = countZerosAndOnes(strs[i]);

            // Update dp array
            for (uint j = m; j >= zeros; j--) {
                for (uint k = n; k >= ones; k--) {
                    dp[j][k] = max(dp[j][k], dp[j - zeros][k - ones] + 1);
                }
            }
        }

        // Return the maximum subset size
        return dp[m][n];
    }

    function countZerosAndOnes(string memory str) private pure returns (uint, uint) {
        uint zeros = 0;
        uint ones = 0;
        bytes memory strBytes = bytes(str);
        for (uint i = 0; i < strBytes.length; i++) {
            if (strBytes[i] == '0') {
                zeros++;
            } else if (strBytes[i] == '1') {
                ones++;
            }
        }
        return (zeros, ones);
    }

    function max(uint a, uint b) private pure returns (uint) {
        return a > b ? a : b;
    }
}