// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DecodeWays {
    function numDecodings(string memory s) public pure returns (uint) {
        bytes memory b = bytes(s);
        uint n = b.length;
        if (n == 0 || b[0] == '0') return 0;

        uint[] memory dp = new uint[](n + 1);
        dp[0] = 1;  // Base case: Empty string can be decoded in 1 way
        dp[1] = b[0] == '0' ? 0 : 1;

        for (uint i = 2; i <= n; i++) {
            uint oneDigit = uint8(b[i - 1]) - 48; // Convert char to int
            uint twoDigit = (uint8(b[i - 2]) - 48) * 10 + oneDigit;

            if (oneDigit >= 1) {
                dp[i] += dp[i - 1];
            }
            if (twoDigit >= 10 && twoDigit <= 26) {
                dp[i] += dp[i - 2];
            }
        }

        return dp[n];
    }
}
